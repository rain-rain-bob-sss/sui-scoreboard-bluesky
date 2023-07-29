--[[

SUI Scoreboard v2.6 by Dathus [BR] is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
----------------------------------------------------------------------------------------------------------------------------
Copyright (c) 2014 - 2023 Dathus [BR] <http://www.juliocesar.me> <http://steamcommunity.com/profiles/76561197983103320>

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
To view a copy of this license, visit <http://creativecommons.org/licenses/by-nc-sa/4.0/deed.en_US> .
----------------------------------------------------------------------------------------------------------------------------
This Addon is based on the original SUI Scoreboard v2 developed by suicidal.banana.
Copyright only on the code that I wrote, my implementation and fixes and etc, The Initial version (v2) code still is from suicidal.banana.
----------------------------------------------------------------------------------------------------------------------------

$Id$
Version 2.6 - 2023-06-06 8:00 PM(UTC -03:00)

]]--

include( "admin_buttons.lua" )
include( "vote_button.lua" )

local PANEL = {}

surface.CreateFont(  "suiscoreboardcardinfo", { font = "DefaultSmall", size = 12, weight = 0, antialiasing = true} )

--- Init
function PANEL:Init()
	self.InfoLabels = {}
	self.InfoLabels[ 1 ] = {}
	self.InfoLabels[ 2 ] = {}
	self.InfoLabels[ 3 ] = {}

	self.btnKick = vgui.Create( "suiplayerkickbutton", self )
	self.btnBan = vgui.Create( "suiplayerbanbutton", self )
	self.btnPBan = vgui.Create( "suiplayerpermbanbutton", self )

	self.VoteButtons = {}

	self.VoteButtons[5] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[5]:SetUp( "wrench", "builder", "非常好建筑!", true )

	self.VoteButtons[4] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[4]:SetUp( "star", "gold_star", "闪亮的金星!", true )

	self.VoteButtons[3] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[3]:SetUp( "palette", "artistic", "艺术", true )

	self.VoteButtons[2] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[2]:SetUp( "heart", "love", "我爱这个玩家", true )

	self.VoteButtons[1] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[1]:SetUp( "emoticon_smile", "smile", "我喜欢这各玩家", true )


	self.VoteButtons[10] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[10]:SetUp( "corner16", "curvey", "曲线" )

	self.VoteButtons[9] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[9]:SetUp( "faceposer_indicator", "best_landvehicle", "非常好陆地载具" )

	self.VoteButtons[8] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[8]:SetUp( "arrow", "best_airvehicle", "非常好空中载具" )

	self.VoteButtons[7] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[7]:SetUp( "inv_corner16", "stunter", "非常好特技" )

	self.VoteButtons[6] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[6]:SetUp( "gmod_logo", "god", "神!" )


	self.VoteButtons[15] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[15]:SetUp( "emoticon_smile", "lol", "XSWL!", true )

	self.VoteButtons[14] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[14]:SetUp( "info", "informative", "信息丰富的" )

	self.VoteButtons[13] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[13]:SetUp( "user", "friendly", "非常友好", true )

	self.VoteButtons[12] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[12]:SetUp( "exclamation", "naughty", "调皮", true )

	self.VoteButtons[11] = vgui.Create( "suispawnmenuvotebutton", self )
	self.VoteButtons[11]:SetUp( "gmod_logo", "gay", "同性恋?!?!?!?!?!!?!?!??!!?!?!?!!?!?!??!?!?!?!?!?!?!?!!?!?!?!?!?!?!?!?!?" )
end

--- SetInfo
function PANEL:SetInfo( column, k, v )
	if not v or v == "" then v = "N/A" end

	if not self.InfoLabels[ column ][ k ] then
		self.InfoLabels[ column ][ k ] = {}
		self.InfoLabels[ column ][ k ].Key 	= vgui.Create( "DLabel", self )
		self.InfoLabels[ column ][ k ].Value 	= vgui.Create( "DLabel", self )
		self.InfoLabels[ column ][ k ].Key:SetText( k )
		self.InfoLabels[ column ][ k ].Key:SetColor(Color(0,0,0,255))
		self.InfoLabels[ column ][ k ].Key:SetFont("suiscoreboardcardinfo")
		self:InvalidateLayout()
	end

	self.InfoLabels[ column ][ k ].Value:SetText( v )
	self.InfoLabels[ column ][ k ].Value:SetColor(Color(0,0,0,255))
	self.InfoLabels[ column ][ k ].Value:SetFont("suiscoreboardcardinfo")
	return true
end

--- SetPlayer
function PANEL:SetPlayer( ply )
	self.Player = ply
	self:UpdatePlayerData()
end

--- UpdatePlayerData
function PANEL:UpdatePlayerData()
	if not self.Player then return end
	if not self.Player:IsValid() then return end
        pcall(function() --Do pcall because it would error on other gamemode LOL!
		self:SetInfo( 1, "道具:", self.Player:GetCount( "props" ) )
		self:SetInfo( 1, "悬浮屎:", self.Player:GetCount( "hoverballs" ) )
		self:SetInfo( 1, "推进去:", self.Player:GetCount( "thrusters" ) )
		self:SetInfo( 1, "气球:", self.Player:GetCount( "balloons" ) )
		self:SetInfo( 1, "按钮:", self.Player:GetCount( "buttons" ) )
		self:SetInfo( 1, "炸药:", self.Player:GetCount( "dynamite" ) )
		self:SetInfo( 1, "LUA物品:", self.Player:GetCount( "sents" ) )
	
		self:SetInfo( 2, "布娃娃:", self.Player:GetCount( "ragdolls" ) )
		self:SetInfo( 2, "特效物品:", self.Player:GetCount( "effects" ) )
		self:SetInfo( 2, "载具:", self.Player:GetCount( "vehicles" ) )
		self:SetInfo( 2, "NPC:", self.Player:GetCount( "npcs" ) )
		self:SetInfo( 2, "特效喷射屎:", self.Player:GetCount( "emitters" ) )
		self:SetInfo( 2, "老逼(灯):", self.Player:GetCount( "lamps" ) )
		self:SetInfo( 2, "AD2生成器:", self.Player:GetCount( "spawners" ) )
	end)

	self:InvalidateLayout()
end

--- ApplySchemeSettings
function PANEL:ApplySchemeSettings()
	for _k, column in pairs( self.InfoLabels ) do
		for k, v in pairs( column ) do
				v.Key:SetFGColor( 50, 50, 50, 255 )
				v.Value:SetFGColor( 80, 80, 80, 255 )
		end
	end
end

--- Think
function PANEL:Think()
	if self.PlayerUpdate and self.PlayerUpdate > CurTime() then return end
	self.PlayerUpdate = CurTime() + 0.25

	self:UpdatePlayerData()
end

--- PerformLayout
function PANEL:PerformLayout()
	local x = 5

	for column, column in pairs( self.InfoLabels ) do

		local y = 0
		local RightMost = 0

		for k, v in pairs( column ) do
			v.Key:SetPos( x, y )
			v.Key:SizeToContents()

			v.Value:SetPos( x + 60 , y )
			v.Value:SizeToContents()

			y = y + v.Key:GetTall() + 2

			RightMost = math.max( RightMost, v.Value.x + v.Value:GetWide() )
		end

		if x<100 then
			x = x + 205
		else
			x = x + 115
		end
	end

	if not LocalPlayer():IsAdmin() then
		self.btnKick:SetVisible( false )
		self.btnBan:SetVisible( false )
		self.btnPBan:SetVisible( false )
	else
		self.btnKick:SetVisible( true )
		self.btnBan:SetVisible( true )
		self.btnPBan:SetVisible( true )

		self.btnKick:SetPos( self:GetWide() - 175, 85 - (22 * 2) )
		self.btnKick:SetSize( 46, 20 )

		self.btnBan:SetPos( self:GetWide() - 175, 85 - (22 * 1) )
		self.btnBan:SetSize( 46, 20 )

		self.btnPBan:SetPos( self:GetWide() - 175, 85 - (22 * 0) )
		self.btnPBan:SetSize( 46, 20 )

		self.btnKick.DoClick = function () Scoreboard.kick( self.Player ) end
		self.btnPBan.DoClick = function () Scoreboard.pBan( self.Player ) end
		self.btnBan.DoClick = function () Scoreboard.ban( self.Player ) end
	end

	for k, v in ipairs( self.VoteButtons ) do
		v:InvalidateLayout()
		if k < 6 then
			v:SetPos( self:GetWide() -  k * 25, 0 )
		elseif k < 11 then
			v:SetPos( self:GetWide() -  (k-5) * 25, 36 )
		else
			v:SetPos( self:GetWide() -  (k-10) * 25, 72 )
		end
		v:SetSize( 20, 32 )
	end
end

--- Paint
function PANEL:Paint(w,h)
	return true
end

vgui.Register( "suiscoreplayerinfocard", PANEL, "Panel" )
