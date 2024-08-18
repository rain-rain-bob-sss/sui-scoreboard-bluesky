--[[

SUI Scoreboard v2.6 by Dathus [BR] is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
----------------------------------------------------------------------------------------------------------------------------
Copyright (c) 2014 - 2024 Dathus [BR] <http://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
To view a copy of this license, visit <http://creativecommons.org/licenses/by-nc-sa/4.0/deed.en_US> .
----------------------------------------------------------------------------------------------------------------------------
This Addon is based on the original SUI Scoreboard v2 developed by suicidal.banana.
Copyright only on the code that I wrote, my implementation and fixes and etc, The Initial version (v2) code still is from suicidal.banana.
----------------------------------------------------------------------------------------------------------------------------

$Id$
Version 2.7 - 2024-05-20 12:17 PM (UTC -03:00)

]]--
if(engine.ActiveGamemode()!="sandbox")then return end
-- Setup Class
Scoreboard = {}
-- Scoreboard version
Scoreboard.version = "2.7.0"

--Setup Loading Log Formatation
function loadingLog (text)
  --Set Max Size
  local size = 32
  --If Text Len < max size
  if(string.len(text) < size) then
    -- Format the text to be Text+Spaces*LeftSize
    text = text .. string.rep( " ", size-string.len(text) )
  else
    --If Text is too much big then cut and add ...
    text = string.Left( text, size-3 ) .. "..."
  end
  --Log Messsage
  Msg( "||  "..text.."||\n" )
end

Msg( "\n/====================================\\\n")
Msg( "||           SUI Scoreboard         ||\n" )
Msg( "||----------------------------------||\n" )
loadingLog("Version " .. Scoreboard.version)
loadingLog("Updated on 2024-05-20 12:17 PM")
Msg( "\\====================================/\n\n" )

if SERVER then
  -- For Players to Download this addon from Workshop.
  resource.AddWorkshop("160121673")
  
  -- Add to the pool
  util.AddNetworkString("SUIScoreboardPlayerColor")
  
  -- Send required files to client
  AddCSLuaFile()
  AddCSLuaFile("sui_scoreboard/client/scoreboard.lua")
  AddCSLuaFile("sui_scoreboard/client/admin_buttons.lua")
  AddCSLuaFile("sui_scoreboard/client/tooltips.lua")
  AddCSLuaFile("sui_scoreboard/client/player_frame.lua")
  AddCSLuaFile("sui_scoreboard/client/player_infocard.lua")
  AddCSLuaFile("sui_scoreboard/client/player_row.lua")
  AddCSLuaFile("sui_scoreboard/client/connecting_player_row.lua")
  AddCSLuaFile("sui_scoreboard/client/scoreboard.lua")
  AddCSLuaFile("sui_scoreboard/client/vote_button.lua")
  AddCSLuaFile("sui_scoreboard/client/library.lua")
  AddCSLuaFile("sui_scoreboard/client/net_client.lua")
  include( "sui_scoreboard/server/rating.lua" )
  include( "sui_scoreboard/server/library.lua" )
else
  Scoreboard.vgui = nil
  Scoreboard.playerColor = Color(255, 155, 0, 255)
  include( "sui_scoreboard/client/library.lua" )
  include( "sui_scoreboard/client/scoreboard.lua" )
  include( "sui_scoreboard/client/net_client.lua" )
end
