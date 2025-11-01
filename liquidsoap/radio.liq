set("log.stdout", true)
set("server.telnet", false)

def get_env(name, default="") =
  value = system.getenv(name)
  if value == nil or value == "" then
    default
  else
    value
  end
end

host = get_env("ICECAST_HOST", "icecast")
port = int_of_string(get_env("ICECAST_PORT", "8000"))
password = get_env("ICECAST_SOURCE_PASSWORD", "sourcepassword")
public_url = get_env("ICECAST_PUBLIC_URL", "http://localhost:8000")
stream_name = get_env("STREAM_NAME", "Local Random Stream")
stream_description = get_env("STREAM_DESCRIPTION", "Randomized playlist from ./media")
stream_genre = get_env("STREAM_GENRE", "Various")

radio_tracks = playlist(mode="random", reload=3600, "/music")
radio = fallback(track_sensitive=true, [radio_tracks, blank(duration=5.0)])
radio = normalize(radio)

audio_metadata = [
  ("url", public_url),
  ("genre", stream_genre)
]

output.icecast(
  %mp3(bitrate=192, stereo=true),
  host=host,
  port=port,
  password=password,
  mount="/stream.mp3",
  name=stream_name ^ " (MP3)",
  description=stream_description,
  url=public_url,
  genre=stream_genre,
  public=true,
  metadata=audio_metadata,
  radio
)

output.icecast(
  %aac(bitrate=128, stereo=true),
  host=host,
  port=port,
  password=password,
  mount="/stream.aac",
  name=stream_name ^ " (AAC)",
  description=stream_description,
  url=public_url,
  genre=stream_genre,
  public=true,
  metadata=audio_metadata,
  radio
)
