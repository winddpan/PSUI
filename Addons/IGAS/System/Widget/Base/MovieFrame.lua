-- Author      : Kurapica
-- Create Date : 2011/03/13
-- Change Log  :

-- Check Version
local version = 1
if not IGAS:NewAddon("IGAS.Widget.MovieFrame", version) then
	return
end
__AutoProperty__()
class "MovieFrame"
	inherit "Frame"

	------------------------------------------------------
	-- Method
	------------------------------------------------------
	__Doc__"EnableSubtitles" [[
		<desc>Enables or disables subtitles for movies played in the frame. Subtitles are not automatically displayed by the MovieFrame; enabling subtitles causes the frame's OnMovieShowSubtitle and OnMovieHideSubtitle script handlers to be run when subtitle text should be displayed.</desc>
		<param name="enable">boolean, true to enable display of movie subtitles; false to disable</param>
	]]

	__Doc__"StartMovie" [[
		<desc>Plays a specified movie in the frame. Note: Size and position of the movie display is unaffected by that of the MovieFrame -- movies are automatically centered and sized proportionally to fill the screen in their largest dimension (i.e. a widescreen movie will fill the width of the screen but not necessarily its full height).</desc>
		<param name="filename">string, path to a movie file (excluding filename extension)</param>
		<param name="volume">number, audio volume for movie playback (0 = minimum, 255 = maximum)</param>
		<return type="boolean">1 if a valid movie was loaded and playback begun; otherwise nil</return>
	]]

	__Doc__"StopMovie" [[Stops the movie currently playing in the frame]]

	------------------------------------------------------
	-- Constructor
	------------------------------------------------------
	function Constructor(self, name, parent, ...)
		return CreateFrame("MovieFrame", nil, parent, ...)
	end
endclass "MovieFrame"

class "MovieFrame"
	------------------------------------------------------
	-- BlzMethodes
	------------------------------------------------------
	StoreBlzMethod(MovieFrame)
endclass "MovieFrame"
