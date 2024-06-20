Scoreboard_Config = Scoreboard_Config or {}

Scoreboard_Config.ServerName = 'Scoreboard' 
Scoreboard_Config.Website = 'www.google.com'

Scoreboard_Config.Ranks = {
    ['superadmin'] = {name='Super Administrator', color = Color(0,0,255)},
    ['developer'] = {name='Developer', color = Color(0,0,255)},
    ['moderator'] = {name='Moderator', color = Color(255,0,0)},
    ['vip'] = {name='VIP', color = Color(0,255,0)},
    ['user'] = {name='User', color = Color(0,255,0)}
} 
Scoreboard_Config.Staff = {
    ['superadmin'] = true,
    ['developer'] = true,
    ['moderator'] = true
} 
 