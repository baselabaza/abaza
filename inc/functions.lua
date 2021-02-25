--[[
#abaza#
]]


function dl_cb(a,d)  end

function GetInputFile(file)
local file = file or "" 
if file:match('/') then
infile = {ID= "InputFileLocal", path_  = file}
elseif file:match('^%d+$') then
infile = {ID= "InputFileId", id_ = file}
else
infile = {ID= "InputFilePersistentId", persistent_id_ = file}
end
return infile
end

local clock = os.clock
function sleep(time)  
local untime = clock()
while clock() - untime <= time do end
end

function sendMsg(chat_id,reply_id,text,funcb)
tdcli_function({
ID="SendMessage",
chat_id_=chat_id,
reply_to_message_id_= reply_id,
disable_notification_=1,
from_background_= 1,
reply_markup_= nil,
input_message_content_={
ID = "InputMessageText",
text_= text,
disable_web_page_preview_= 1,
clear_draft_= 0,
entities_={},
parse_mode_=  {ID = "TextParseModeMarkdown"} ,
}},funcb or dl_cb,nil)
end

function sendPhoto(chat_id,reply_id,photo,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessagePhoto",
photo_ = GetInputFile(photo),
added_sticker_file_ids_ = {},
width_ = 0,
height_ = 0,
caption_ = caption or ''
}
},func or dl_cb,nil)
end


function sendVoice(chat_id,reply_id,voice,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVoice",
voice_ = GetInputFile(voice),
duration_ = '',
waveform_ = '',
caption_ = caption or ''
}},func or dl_cb,nil)
end

function sendAnimation(chat_id,reply_id,animation,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAnimation",
animation_ = GetInputFile(animation),
width_ = 0,
height_ = 0,
caption_ = caption or ''
}},func or dl_cb,nil)
end

function sendAudio(chat_id,reply_id,audio,title,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageAudio",
audio_ = GetInputFile(audio),
duration_ = '',
title_ = title or '',
performer_ = '',
caption_ = caption or ''
}},func or dl_cb,nil)
end

function sendSticker(chat_id,reply_id,sticker,func)
tdcli_function({
ID='SendMessage',
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageSticker",
sticker_ = GetInputFile(sticker),
width_ = 0,
height_ = 0
}},func or dl_cb,nil)
end

function sendVideo(chat_id,reply_id,video,caption,func)
tdcli_function({ 
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 0,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageVideo",  
video_ = GetInputFile(video),
added_sticker_file_ids_ = {},
duration_ = 0,
width_ = 0,
height_ = 0,
caption_ = caption or ''
}},func or dl_cb,nil)
end


function sendDocument(chat_id,reply_id,document,caption,func)
tdcli_function({
ID="SendMessage",
chat_id_ = chat_id,
reply_to_message_id_ = reply_id,
disable_notification_ = 0,
from_background_ = 1,
reply_markup_ = nil,
input_message_content_ = {
ID="InputMessageDocument",
document_ = GetInputFile(document),
caption_ = caption
}},func or dl_cb,nil)
end


function fwdMsg(chat_id,from_chat_id,msg_id,func)
tdcli_function({
ID="ForwardMessages",
chat_id_ = chat_id,
from_chat_id_ = from_chat_id,
message_ids_ = {[0] = msg_id},
disable_notification_ = 0,
from_background_ = 0
},func or dl_cb,nil)
end


function SendMention(chat_id,user_id,msg_id,Text,offset, length) 
tdcli_function ({ 
ID = "SendMessage", 
chat_id_ = chat_id, 
reply_to_message_id_ = msg_id, 
disable_notification_ = 0, 
from_background_ = 1, 
reply_markup_ = nil, 
input_message_content_ = { 
ID = "InputMessageText", 
text_ = Text, 
disable_web_page_preview_ = 1, 
clear_draft_ = 0, 
entities_ = {[0]={ 
ID="MessageEntityMentionName", 
offset_ = offset , 
length_ = length , 
user_id_ = user_id },},},
},dl_cb, nil)
end

function sendChatAction(chatid,action,func)
tdcli_function({ID = 'SendChatAction',chat_id_ = chatid,action_ = {ID = "SendMessage"..action.."Action",progress_ = 1},}, func or dl_cb,nil)
end

--================================{{  GetChannelFull  }} ===================================
function download_file(Link,Bath)
local Get_Files, res = https.request(Link)
if res == 200 then
local FileD = io.open(Bath,'w+')
FileD:write(Get_Files)
FileD:close()
end
end
--================================{{  GetChannelFull  }} ===================================

function GetFullChat(GroupID,func,Arg)
tdcli_function({ID="GetChannelFull",channel_id_ = tostring(GroupID):gsub("-100","")},func or dl_cb,Arg or nil)
end

--================================{{  KickUser  }} ===================================

function kick_user(user_id,chat_id,func,Arg)
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat_id,user_id_=user_id,status_={ID="ChatMemberStatusKicked"}},func or dl_cb,Arg or nil)
end

--================================{{  UnBlock  }} ===================================

function StatusLeft(chat_id,user_id,func,Arg)
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=chat_id,user_id_=user_id,status_={ID="ChatMemberStatusLeft"}},func or dl_cb,Arg or nil)
end
--================================{{  DeleteMsg  }} ===================================

function Del_msg(GroupID,msg_id,func,Arg)
tdcli_function({ID="DeleteMessages",chat_id_=GroupID,message_ids_={[0]=msg_id}},func or dl_cb,Arg or nil)
end


function GetPhotoUser(User,func,Arg)
tdcli_function({ID='GetUserProfilePhotos',user_id_=User,offset_=0,limit_=1},func,Arg or nil)
end

function GetMsgInfo(UID,Msg_id,Cb,Arg)
tdcli_function({ID="GetMessage",chat_id_ = UID,message_id_ = Msg_id},Cb,Arg or nil)
end

function GetUserName(User,Cb,Arg)
tdcli_function({ID="SearchPublicChat",username_ = User},Cb,Arg or nil)
end

function GetUserID(User,Cb,Arg)
tdcli_function({ID="GetUser",user_id_ = User},Cb,Arg or nil)
end

function GroupTitle(GroupID,func,Arg)
tdcli_function({ID="GetChat",chat_id_ = GroupID},func or dl_cb,Arg or nil)
end

function GetChannelAdministrators(GroupID,func,limit,Arg)
tdcli_function({ID="GetChannelMembers",channel_id_= tostring(GroupID):gsub('-100',''),filter_={ID = "ChannelMembersAdministrators"},offset_=0,limit_=limit or 25},func,Arg or nil)
end 

function GetChatMember(GroupID,UserID,func,Arg)
tdcli_function({ID='GetChatMember',chat_id_ = GroupID,user_id_ = UserID},func,Arg or nil)
end 

function GetHistory(GroupID,NumDel,func,Arg)
tdcli_function({ID="GetChatHistory",chat_id_ = GroupID,from_message_id_ = 0,offset_ = 0,limit_ = NumDel},func,Arg or nil)
end
-----------------------{ Start Api Token Bot}-----------------------------
function getr(br)
if br then
return "✓"
else
return "✖️"
end
end

function GetApi(web)
local info, res = https.request(web)
if res ~= 200 then return false end
local success, res = pcall(JSON.decode, info);
if success then
if not res.ok then return false end
res = res
else
res = false
end
return res
end


--================================{{  ExportChatInviteLink  }} ===================================

function ExportLink(GroupID)
local GetLin,res = https.request(ApiToken..'/exportChatInviteLink?chat_id='..GroupID)
print(res)
if res ~= 200 then return false end
local success, res = pcall(JSON.decode, GetLin)
return (res or "")
end

function Restrict(chat_id,user_id,right)
if right == 1 then
ii = https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=false')
elseif right == 2 then
ii = https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=true&can_send_media_messages=true&can_send_other_messages=true&can_add_web_page_previews=true')
elseif right == 3 then
ii = https.request(ApiToken..'/restrictChatMember?chat_id='..chat_id..'&user_id='..user_id..'&can_send_messages=true&can_send_media_messages=false&can_send_other_messages=false&can_add_web_page_previews=false')
end
print(ii)
return ii
end


function ChangeNikname(chat_id,user_id,nikname)
--setChatAdministratorCustomTitle
slaheat = user_id
slaheat = slaheat.."&custom_title="..URL.escape(nikname)
result,res = https.request(ApiToken..'/setChatAdministratorCustomTitle?chat_id='..chat_id..'&user_id='..slaheat)
print(result,res)
return result ,res
end


function UploadAdmin(chat_id,user_id,right)

print(chat_id)
print(user_id)
print(right)
slaheat = user_id
if right:match(1) then
slaheat = slaheat.."&can_change_info=true"
end
if right:match(2) then
slaheat = slaheat.."&can_delete_messages=true"
end
if right:match(3) then
slaheat = slaheat.."&can_invite_users=true"
end
if right:match(4) then
slaheat = slaheat.."&can_restrict_members=true"
end
if right:match(5) then
slaheat = slaheat.."&can_pin_messages=true"
end
if right:match(6) then
slaheat = slaheat.."&can_promote_members=true"
end
if right:match("[*][*]") then
slaheat = slaheat.."&can_change_info=true&can_delete_messages=true&can_invite_users=true&can_pin_messages=true&can_restrict_members=true&can_promote_members=true"
elseif right:match("[*]") then
slaheat = slaheat.."&can_change_info=true&can_delete_messages=true&can_invite_users=true&can_pin_messages=true&can_restrict_members=true"
end
print(slaheat)

result,res = https.request(ApiToken..'/promoteChatMember?chat_id='..chat_id..'&user_id='..slaheat)
print(result,res)
return result ,res
end


function send_msg(chat_id,text,msg_id)
local url = ApiToken..'/sendMessage?chat_id='..chat_id..'&text='..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true"
if msg_id then
url = url.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(url)
end

function EditMsg(chat_id,message_id,text,funcb)
local url = ApiToken..'/editMessageText?chat_id='..chat_id ..'&message_id='..tonumber(message_id/2097152/0.5)..'&text='..URL.escape(text)..'&parse_mode=Markdown&disable_web_page_preview=true'
return GetApi(url)
end

function send_key(chat_id,text,keyboard,inline,msg_id)
local response = {}
response.inline_keyboard = inline
response.keyboard = keyboard
response.resize_keyboard = true
response.one_time_keyboard = false
local Send_api = ApiToken.."/sendMessage?chat_id="..chat_id.."&text="..
URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response))
if msg_id then 
Send_api = Send_api.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(Send_api)
end 

function send_inline(chat_id,text,inline,msg_id)
local response = {}
response.inline_keyboard = inline
local Send_api = ApiToken.."/sendMessage?chat_id="..chat_id.."&text="..
URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response))
if msg_id then 
Send_api = Send_api.."&reply_to_message_id="..msg_id/2097152/0.5
end
return GetApi(Send_api)
end 


function answerCallbackQuery(callback_query_id, text, show_alert)
local url = ApiToken..'/answerCallbackQuery?callback_query_id='..callback_query_id..'&text='..URL.escape(text)
if show_alert then url = url..'&show_alert=true' end
return GetApi(url)
end


function GetFilePath(FileID)
local UrlInfo = https.request(ApiToken..'/getfile?file_id='..FileID)
return ApiToken..'/'..JSON.decode(UrlInfo).result.file_path
end 

----------------------{ End Api Token Bot }-----------------------------

function UpdateSource(msg,edit)
if edit then EditMsg(msg.chat_id_,msg.id_,'10% - |█          |') end
if edit then EditMsg(msg.chat_id_,msg.id_,'20% - |███         |') end
download_file('https://raw.githubusercontent.com/TH3BS/abaza/master/inc/Run.lua','./inc/Run.lua')
if edit then EditMsg(msg.chat_id_,msg.id_,'40% - |█████       |') end
download_file('https://raw.githubusercontent.com/TH3BS/abaza/master/inc/locks.lua','./inc/locks.lua')
if edit then EditMsg(msg.chat_id_,msg.id_,'60% - |███████     |') end
download_file('https://raw.githubusercontent.com/TH3BS/abaza/master/inc/Script.lua','./inc/Script.lua')
if edit then EditMsg(msg.chat_id_,msg.id_,'80% - |█████████   |') end
download_file('https://raw.githubusercontent.com/TH3BS/abaza/master/inc/functions.lua','./inc/functions.lua')
if edit then EditMsg(msg.chat_id_,msg.id_,'100% - |█████████████|\n\n🔝*¦* تم تحديث السورس الى اصدار *v'..redis:get(abaza..":VERSION")..'*\n📟*¦* تم اعاده تشغيل السورس بنجاح') end
if edit then dofile("./inc/Run.lua") end
print("Update Source And Reload ~ ./inc/Run.lua")

end
----------------------{ Get Name Bot }-----------------------------


function GetType(ChatID) 
if tostring(ChatID):match('^-100') then
return 'channel' 
elseif tostring(ChatID):match('-') then
return 'chat' 
else 
return 'pv'
end 
end

function All_File()
local Text = "🗂| قائمه الملفات : \nـ------------------------------------\n\n"
local Num = 0
local allfiles = io.popen('ls plugins'):lines()
for Files in allfiles do
if Files:match(".lua$") then
Num = Num +1
Text = Text..Num..'- * '..Files..' * \n' 
end
end 
if Num == 0 then
Text = Text.."📛| Not files ~⪼ لا يوجد ملفات !"
end 
return Text.."\n\n🗃| لتحميل المزيد من الملفات ادخلل لمتجر الملفات بالامر الاتي {` متجر الملفات `}"
end


function ResolveName(data)
if type(data) == 'table' then
if data.last_name_ then Name = data.first_name_ .." "..data.last_name_ else Name = data.first_name_ end
TNAME = FlterName(Name,20) 
else
TNAME = FlterName(data,20)
end
print("| Number char : "..utf8.len(TNAME))
ncn = {}
for c in TNAME:gmatch("[^%s]+") do 
table.insert(ncn,c)  
print(c) 
end
return utf8.escape(ncn[1])
end

function ResolveUserName(data)
if data.username_ then 
USERNAME = '@'..data.username_
else 
if data.last_name_ then Name = data.first_name_ .." "..data.last_name_ else Name = data.first_name_ end
USERNAME = FlterName(Name,20) 
end
return USERNAME
end

function Hyper_Link_Name(data)
if data.first_name_ then 
if data.last_name_ then 
Name = data.first_name_ .." "..data.last_name_
else 
Name = data.first_name_ 
end
usernn = data.username_ or "th3bs"
else 
Name = data.title_
usernn = data.type_.user_.username_ or "th3bs"
end
Name = Name:gsub('[[][]]','')
Name = FlterName(Name,10)
Name = "["..Name.."](t.me/"..usernn..")"
print(Name)
return Name
end



function Flter_Markdown(TextMsg) 
local Text = tostring(TextMsg)
Text = Text:gsub('_',[[\_]])
Text = Text:gsub('*','\\*')
Text = Text:gsub('`','\\`')
local Hyperlink = Text:match('[(](.*)[)]')
local Hyperlink1 = Text:match('[[](.*)[]]')
if Hyperlink and Hyperlink1 then
Hyperlink = "("..Hyperlink:gsub([[\_]],'_')..")"
Text = Text:gsub('[(](.*)[)]',Hyperlink ) 
Hyperlink1 = Hyperlink1:gsub([[\_]],'_')
Hyperlink1 = "["..Hyperlink1:gsub('[[][]]','').."]"
Text = Text:gsub('[[](.*)[]]',Hyperlink1 ) 
end
return Text 
end



function FlterName(Name,Num)
if Name.last_name_ then
Name = Name.first_name_ .." "..Name.last_name_ 
elseif Name.first_name_ then
Name = Name.first_name_ 
end
local CharNumber = tonumber(Num or 25)
local Name = tostring(Name):lower()
Name = Name:gsub("https://[%a%d_]+",'') 
Name = Name:gsub("http://[%a%d_]+",'') 
Name = Name:gsub("telegram.dog/[%a%d_]+",'') 
Name = Name:gsub("telegram.me/[%a%d_]+",'') 
Name = Name:gsub("t.me/[%a%d_]+",'') 
Name = Name:gsub("[%a%d_]+.pe[%a%d_]+",'') 
Name = Name:gsub("@[%a%d_]+",'')
Name = Name:gsub("#[%a%d_]+",'')

Name = FlterEmoje(Name)
Name = Flterzhrfa(Name)
Name = utf8.gsub(Name,"✸","")
Name = utf8.gsub(Name,"ﮧ","")
Name = utf8.gsub(Name,"┊","")
Name = utf8.gsub(Name,"ٜ","")
Name = utf8.gsub(Name,"༒","")
Name = utf8.gsub(Name,"ᬼ","")
Name = utf8.gsub(Name,"̅","")
Name = utf8.gsub(Name,"❦","")
Name = utf8.gsub(Name,"ᝢ","")
Name = utf8.gsub(Name,"༼","")
Name = utf8.gsub(Name,"๘","")
Name = utf8.gsub(Name,"༽","")
Name = utf8.gsub(Name,"⎨","")
Name = utf8.gsub(Name,"ௌ","")
Name = utf8.gsub(Name,"⎬","")
Name = utf8.gsub(Name,"ۤ","")
Name = utf8.gsub(Name,"꧄","")
Name = utf8.gsub(Name,"░","")
Name = utf8.gsub(Name,"͝","")
Name = utf8.gsub(Name,"¥","")
Name = utf8.gsub(Name,"َ","")
Name = utf8.gsub(Name,"✧","")
Name = utf8.gsub(Name,"ֆ","")
Name = utf8.gsub(Name,"ۖ","")
Name = utf8.gsub(Name,"(])","")
Name = utf8.gsub(Name,"","")
Name = utf8.gsub(Name,"֧","")
Name = utf8.gsub(Name,"*","")
Name = utf8.gsub(Name,"","")
Name = utf8.gsub(Name,"﴿","")
Name = utf8.gsub(Name,"₪","")
Name = utf8.gsub(Name,"ૣ","")
Name = utf8.gsub(Name,"☆","")
Name = utf8.gsub(Name,"͞","")
Name = utf8.gsub(Name,"ٖ","")
Name = utf8.gsub(Name,"֯","")
Name = utf8.gsub(Name,"‘","")
Name = utf8.gsub(Name,"ُ","")
Name = utf8.gsub(Name,"ꪆ","")
Name = utf8.gsub(Name,"↡","")
Name = utf8.gsub(Name,"᭄","")
Name = utf8.gsub(Name,"௵","")
Name = utf8.gsub(Name,"♚","")
Name = utf8.gsub(Name,"ﹻ","")
Name = utf8.gsub(Name,"ۦ","")
Name = utf8.gsub(Name,"͟","")
Name = utf8.gsub(Name,"̶","")
Name = utf8.gsub(Name,"_","")
Name = utf8.gsub(Name,"`","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"๘","")
Name = utf8.gsub(Name,"͡","")
Name = utf8.gsub(Name,"⸨","")
Name = utf8.gsub(Name,"▓","")
Name = utf8.gsub(Name,"ـ","")
Name = utf8.gsub(Name,"ஞ","")
Name = utf8.gsub(Name,"❥","")
Name = utf8.gsub(Name,"ꨩ","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"ೈ","")
Name = utf8.gsub(Name,"٘","")
Name = utf8.gsub(Name,"ࣧ","")
Name = utf8.gsub(Name,"“","")
Name = utf8.gsub(Name,"•","")
Name = utf8.gsub(Name,']',"")
Name = utf8.gsub(Name,'[[]',"")
Name = utf8.gsub(Name,"}","")
Name = utf8.gsub(Name,"ཻ","")
Name = utf8.gsub(Name,"⸩","")
Name = utf8.gsub(Name,"ِ","")
Name = utf8.gsub(Name,"ࣩ","")
Name = utf8.gsub(Name,"ٰ","")
Name = utf8.gsub(Name,"ہ","")
Name = utf8.gsub(Name,"ۙ","")
Name = utf8.gsub(Name,"ৡ","")
Name = utf8.gsub(Name,"҉","")
Name = utf8.gsub(Name,"ٙ","")
Name = utf8.gsub(Name,"ّ","")
Name = utf8.gsub(Name,"ۨ","")
Name = utf8.gsub(Name,"ै","")
Name = utf8.gsub(Name,"ೋ","")
Name = utf8.gsub(Name,"๋","")
Name = utf8.gsub(Name,"͢","")
Name = utf8.gsub(Name,"ﮩ","")
Name = utf8.gsub(Name,"❁","")
Name = utf8.gsub(Name,"⃤","")
Name = utf8.gsub(Name,"ﮮ","")
Name = utf8.gsub(Name,"⸽","")
Name = utf8.gsub(Name,"̝","")
Name = utf8.gsub(Name,"{","")
Name = utf8.gsub(Name,"𖤍","")
Name = utf8.gsub(Name,"|","")
Name = utf8.gsub(Name,"ۧ","")
Name = utf8.gsub(Name,"ۗ","")
Name = utf8.gsub(Name,"ۣ","")
Name = utf8.gsub(Name,"ٍ","")
Name = utf8.gsub(Name,"ؔ","")
Name = utf8.gsub(Name,"ٌ","")
Name = utf8.gsub(Name,"͜","")
Name = utf8.gsub(Name,"ꪸ","")
Name = utf8.gsub(Name,"ۂ","")
Name = utf8.gsub(Name,"»","")
Name = utf8.gsub(Name,"̚","")
Name = utf8.gsub(Name,"𖣁","")
Name = utf8.gsub(Name,"۫","")
Name = utf8.gsub(Name,"ْ","")
Name = utf8.gsub(Name,"ৣ","")
Name = utf8.gsub(Name,"ے","")
Name = utf8.gsub(Name,"♱","")
Name = utf8.gsub(Name,"℘","")
Name = utf8.gsub(Name,"ً","")
Name = utf8.gsub(Name,"۪","")
Name = utf8.gsub(Name,"❰","")
Name = utf8.gsub(Name,"꯭","")
Name = utf8.gsub(Name,"ٚ","")
Name = utf8.gsub(Name,"﷽","")
Name = utf8.gsub(Name,"ۛ","")
Name = utf8.gsub(Name,"〞","")
Name = utf8.gsub(Name,"█","")
Name = utf8.gsub(Name,"✮","")
Name = utf8.gsub(Name,"✿","")
Name = utf8.gsub(Name,"✺","")
Name = utf8.gsub(Name,"̐","")
Name = utf8.gsub(Name,"ྀ","")
Name = utf8.gsub(Name,"←","")
Name = utf8.gsub(Name,"↝","")
Name = utf8.gsub(Name,"ؒ","")
Name = utf8.gsub(Name,"̷","")
Name = utf8.gsub(Name,"⇣","")
Name = utf8.gsub(Name,"«","")
Name = utf8.gsub(Name,"ٛ","")
Name = utf8.gsub(Name,"ॠ","")
Name = utf8.gsub(Name,"̲","")
Name = utf8.gsub(Name,"-","")
Name = utf8.gsub(Name,"͛","")
Name = utf8.gsub(Name,"☬","")
Name = utf8.gsub(Name,"ٓ","")
Name = utf8.gsub(Name,"❱","")
Name = utf8.gsub(Name,"ۓ","")
Name = utf8.gsub(Name,"‏","")
Name = utf8.gsub(Name,"௸","")
Name = utf8.gsub(Name,"°","")
Name = utf8.gsub(Name,"ᔕ","")
Name = utf8.gsub(Name,"[⁽₎]","")
Name = utf8.gsub(Name,"͒","")
Name = utf8.gsub(Name,"❀","")
Name = utf8.gsub(Name,"◎","")
Name = utf8.gsub(Name,"ᴗ̈","")
Name = utf8.gsub(Name,"►","")
Name = utf8.gsub(Name,"ಿ","")
Name = utf8.gsub(Name,"ಿ","")
Name = utf8.gsub(Name,"⋮","")
Name = utf8.gsub(Name,"┋","")
Name = utf8.gsub(Name,"♛","")
Name = utf8.gsub(Name,"✫","")
Name = utf8.gsub(Name,"՞","")
Name = utf8.gsub(Name,"﴾","")
Name = utf8.gsub(Name,"♡","")
Name = utf8.gsub(Name,"彡","")
Name = utf8.gsub(Name,"卍","")
Name = utf8.gsub(Name,"』","")
Name = utf8.gsub(Name,"『","")
Name = utf8.gsub(Name,"∫","")
Name = utf8.gsub(Name,"Ξ","")
Name = utf8.gsub(Name,"۩","")
Name = utf8.gsub(Name,"*","")
Name = utf8.gsub(Name,"ಿ","")
Name = utf8.gsub(Name,"ᵎ","")
Name = utf8.gsub(Name,"║","")
Name = utf8.gsub(Name,"ꪾ","")
Name = utf8.gsub(Name,"ꪳ","")
Name = utf8.gsub(Name,"ㅤ","")

if utf8.len(Name) > CharNumber then
Name = utf8.sub(Name,0,CharNumber)..'...' 
end
local CheckName = Name:gsub(' ','')
if CheckName == "" then 
Name = 'الاسم سبام 📛'
end
return utf8.escape(Name)
end

--[[
function KlmatMmno3(text)
resq = false
local listFshars = redis:get("UpdatWordsFshar")
if not listFshars then
local Fshar_Word , res = https.request('https://api.th3abaza.com/Words_Fshars.txt')
if res ~= 200 then Fshar_Word = "\n" end
redis:setex("UpdatWordsFshar",3600,Fshar_Word)
print(Fshar_Word)
end


for lines in listFshars:gmatch('[^\r\n]+') do
if text:match('^('..lines..')$') or text:match(lines..' .*') or text:match('.* '..lines) then
print("Word is Fshar")
resq = true
end end
print(resq)
return resq
end
]]


function KlmatMmno3(text)
resq = false
if not Fshar_Word or not redis:get("UpdatWordsFshar") then
Fshar_Word , res = https.request('https://api.th3abaza.com/Words_Fshars.txt')
if res ~= 200 then Fshar_Word = "\n" end
redis:setex("UpdatWordsFshar",3600,true)
end
for lines in Fshar_Word:gmatch('[^\r\n]+') do
if text:match('^('..lines..')$') or text:match(lines..' .*') or text:match('.* '..lines) then
print("Word is Fshar")
resq = true
end end
return resq
end


function Get_Ttl(msgs)
local MsgShow = '' 
local NumMsg = tonumber(msgs)
if NumMsg < 80 then 
MsgShow = 'غير متفاعل ✘' 
elseif NumMsg < 300 then
MsgShow = 'ضعيف 🥀' 
elseif NumMsg < 900 then 
MsgShow = 'متوسط 🎋' 
elseif NumMsg < 5000 then 
MsgShow = 'متفاعل 💐' 
elseif NumMsg < 9000 then 
MsgShow = 'قوي جدا ⚡️' 
elseif NumMsg < 10000 then 
MsgShow = 'قمه التفاعل ✨' 
elseif NumMsg < 100000 then 
MsgShow = 'اقوى تفاعل 🔥' 
elseif NumMsg > 150000 then 
MsgShow = 'اقوى تفاعل 🔥' 
end
return MsgShow 
end

function Getrtba(UserID,ChatID)
if UserID == our_id then 
var = 'هذا البوت 🙄☝🏿' 
elseif UserID == 819385837 or UserID == 60809019  then 
var = 'مطور السورس'
elseif  UserID == SUDO_ID then
var = redis:get(abaza..":RtbaNew1:"..ChatID) or 'مطور اساسي 👨🏻‍✈️' 
elseif redis:sismember(abaza..':SUDO_BOT:',UserID) then
var = redis:get(abaza..":RtbaNew2:"..ChatID) or 'مطور البوت 👨🏽‍💻' 
elseif redis:sismember(abaza..':MONSHA_Group:'..ChatID,UserID) then
var = redis:get(abaza..":RtbaNew3:"..ChatID) or ' المنشىء اساسي👷🏽' 
elseif redis:sismember(abaza..':MONSHA_BOT:'..ChatID,UserID) then
var = redis:get(abaza..":RtbaNew4:"..ChatID) or ' المنشىء 👷🏽' 
elseif redis:sismember(abaza..'owners:'..ChatID,UserID) then
var = redis:get(abaza..":RtbaNew5:"..ChatID) or 'مدير البوت 👨🏼‍⚕️' 
elseif redis:sismember(abaza..'admins:'..ChatID,UserID) then
var = redis:get(abaza..":RtbaNew6:"..ChatID) or 'ادمن في البوت 👨🏼‍🎓' 
elseif redis:sismember(abaza..'whitelist:'..ChatID,UserID) then
var = redis:get(abaza..":RtbaNew7:"..ChatID) or 'عضو مميز ⭐️' 
else
var = 'فقط عضو 🙍🏼‍♂️' 
end
return var
end

function convert_Klmat(msg,data,Replay,MD)
local edited = (redis:get(abaza..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local points = redis:get(abaza..':User_Points:'..msg.chat_id_..msg.sender_user_id_) or 0
local NameUser = ResolveName(data)
local Emsgs = redis:get(abaza..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 1
if data.username_ then UserNameID = "@"..data.username_ else UserNameID = "لا يوجد" end  
if Replay then
Replay = Replay:gsub("{الاسم}",NameUser)
Replay = Replay:gsub("{الايدي}",msg.sender_user_id_)
Replay = Replay:gsub("{المعرف}",UserNameID)
Replay = Replay:gsub("{الرتبه}",msg.TheRank)
Replay = Replay:gsub("{التفاعل}",Get_Ttl(Emsgs))
Replay = Replay:gsub("{الرسائل}",Emsgs)
Replay = Replay:gsub("{التعديل}",edited)
Replay = Replay:gsub("{النقاط}",points)
Replay = Replay:gsub("{البوت}",redis:get(abaza..':NameBot:'))
Replay = Replay:gsub("{المطور}",SUDO_USER)
else
Replay =""
end
if MD then
return Replay
else
return Replay
end
end


function SaveNumMsg(msg)
if msg.edited then
redis:incr(abaza..':edited:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.text and not msg.forward_info_ then
redis:incr(abaza..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_)
elseif msg.content_.ID == "MessageChatAddMembers" then 
redis:incr(abaza..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessagePhoto" then
redis:incr(abaza..':photo:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageSticker" then
redis:incr(abaza..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageVoice" then
redis:incr(abaza..':voice:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageAudio" then
redis:incr(abaza..':audio:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageVideo" then
redis:incr(abaza..':video:'..msg.chat_id_..':'..msg.sender_user_id_)
elseif msg.content_.ID == "MessageAnimation" then
redis:incr(abaza..':animation:'..msg.chat_id_..':'..msg.sender_user_id_)
end
end


--================================{{  We Sudoer  }} ===================================

function we_sudo(msg)
if msg.sender_user_id_ == SUDO_ID then
return true 
else
return false
end 
end


--================================{{  List Sudoer  }} ===================================

function TagAll(msg)
message = "قائمه الأداريين : \n\n"
local monshaas = redis:smembers(abaza..':MONSHA_Group:'..msg.chat_id_)
local monsha = redis:smembers(abaza..':MONSHA_BOT:'..msg.chat_id_)
local Owners = redis:smembers(abaza..'owners:'..msg.chat_id_)
local Admins = redis:smembers(abaza..'admins:'..msg.chat_id_)
local mmez = redis:smembers(abaza..'whitelist:'..msg.chat_id_)
if #monshaas==0 and #monsha==0 and #Owners==0 and #Admins==0 and #mmez==0 then return "* لا يوجد قائمه حاليا \n📛 *" end
i = 1
for k,v in pairs(mmez) do
if not message:match(v) then
local info  = redis:hgetall(abaza..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."-l ["..info.username..'] \n'
else
message = message ..i.. '-l ['..info.username..'](t.me/TH3bs) \n'
end

i=i+1
end 
end 
for k,v in pairs(Admins) do
if not message:match(v) then
local info  = redis:hgetall(abaza..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."-l ["..info.username..'] \n'
else
message = message ..i.. '-l ['..info.username..'](t.me/TH3bs) \n'
end
i=i+1
end 
end 
for k,v in pairs(Owners) do
if not message:match(v) then
local info  = redis:hgetall(abaza..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."-l ["..info.username..'] \n'
else
message = message ..i.. '-l ['..info.username..'](t.me/TH3bs) \n'
end
i=i+1
end 
end
for k,v in pairs(monsha) do
if not message:match(v) then
local info  = redis:hgetall(abaza..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."-l ["..info.username..'] \n'
else
message = message ..i.. '-l ['..info.username..'](t.me/TH3bs) \n'
end
i=i+1
end 
end 

for k,v in pairs(monshaas) do
if not message:match(v) then
local info  = redis:hgetall(abaza..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..i.."-l ["..info.username..'] \n'
else
message = message ..i.. '-l ['..info.username..'](t.me/TH3bs) \n'
end
i=i+1
end 
end 
return message
end

function sudolist(msg)
local list = redis:smembers(abaza..':SUDO_BOT:')
message = '👨🏽‍💻*¦* قائمه الـمـطـوريـن : \n\n`★`*_* ['..SUDO_USER..'] ➣ (' ..SUDO_ID.. '){'..redis:scard(abaza..'mtwr_count'..SUDO_ID)..'}\n*----------------------------------*\n'
if #list==0 then  message = message.."* لا يوجد مطورين حاليا \n📛 *"
else
for k,v in pairs(list) do
local info  = redis:hgetall(abaza..'username:'..v)
local count = redis:scard(abaza..'mtwr_count'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.."-l ["..info.username..'] » (`' ..v.. '`){'..count..'} \n'
else
message = message ..k.. '-l ['..info.username..'](t.me/TH3bs) l » (`' ..v.. '`){'..count..'} \n'
end
end 
end
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض الردود بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{  List Constructor  }} ===================================
function conslist(msg)



message = '*⭐️¦ المنشئيين الاساسيين:*\n\n'
local monsha = redis:smembers(abaza..':MONSHA_Group:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."📛| Not Super Creator ~⪼  لا يوجد منشئيين ااساسيين !\n"
else
for k,v in pairs(monsha) do
local info = redis:hgetall(abaza..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.."-l ["..info.username..'] » (`' ..v.. '`) \n'
else
message = message ..k.. '-l ['..info.username..'](t.me/TH3bs) l » (`' ..v.. '`) \n'
end
end
end

message = message..'\n\n\n*🔅¦ المنشئيين :*\n\n'
local monsha = redis:smembers(abaza..':MONSHA_BOT:'..msg.chat_id_)
if #monsha == 0 then 
message = message .."📛| Not Creator ~⪼ لا يوجد منشئيين !\n"
else
for k,v in pairs(monsha) do
local info = redis:hgetall(abaza..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.."-l ["..info.username..'] » (`' ..v.. '`) \n'
else
message = message ..k.. '-l ['..info.username..'](t.me/TH3bs) l » (`' ..v.. '`) \n'
end
end
end
return message
end
--================================{{  List owner  }} ===================================

function ownerlist(msg)
message = '*📋¦ قائمه المدراء :*\n\n'
local list = redis:smembers(abaza..'owners:'..msg.chat_id_)
if #list == 0 then  
message = message.."📛| Not Director ~⪼ لا يوجد مدراء !\n" 
else
for k,v in pairs(list) do
local info = redis:hgetall(abaza..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-l ['..(info.username or '')..'] » (`' ..v.. '`) \n'
else
message = message ..k.. '-l ['..info.username..'](t.me/TH3bs) l » (`' ..v.. '`) \n'
end
end
end
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض المدراء بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{ List Admins  }} ===================================

function GetListAdmin(msg)
local list = redis:smembers(abaza..'admins:'..msg.chat_id_)
if #list==0 then  return  "📛*¦* لا يوجد ادمن في هذه المجموعه \n❕" end
message = '📋*¦ قائمه الادمنيه :*\n\n'
for k,v in pairs(list) do
local info = redis:hgetall(abaza..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-l ['..info.username..'] » (`' ..v.. '`) \n'
else
message = message ..k.. '-l ['..info.username..'](t.me/TH3bs) l » (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض الادمنيه بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{  List WhiteList  }} ===================================

function whitelist(msg)
local list = redis:smembers(abaza..'whitelist:'..msg.chat_id_)
if #list == 0 then return "*📛¦ لا يوجد مميزين في القائمه *" end
message = '📋*¦* قائمه الاعضاء المميزين :\n'   
for k,v in pairs(list) do
local info = redis:hgetall(abaza..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-l ['..info.username..'] » (`' ..v.. '`) \n'
else
message = message ..k.. '-l ['..info.username..'](t.me/TH3bs) l » (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض المميزين بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{  Mute User And List Mute User   }} ===================================

function MuteUser(Group, User)
if redis:sismember(abaza..'is_silent_users:'..Group,User) then 
return true 
else
return false
end 
end


function MuteUser_list(msg)
local list = redis:smembers(abaza..'is_silent_users:'..msg.chat_id_)
if #list==0 then return "📋*¦*  لايوجد اعضاء مكتومين " end
message = '📋*¦*  قائمه الاعضاء المكتومين :\n'
for k,v in pairs(list) do
local info = redis:hgetall(abaza..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-l ['..info.username..'] » (`' ..v.. '`) \n'
else
message = message ..k.. '-l ['..info.username..'](t.me/TH3bs) l » (`' ..v.. '`) \n'
end
end
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض المكتومين بسبب القائمه كبيره جدا ."
else
return message
end
end


--================================{{  Check Banned And List Banned  }} ===================================


function Check_Banned(Group,User)
if redis:sismember(abaza..'banned:'..Group,User) then 
return true 
else
return false
end 
end

function GetListBanned(msg)
local list = redis:smembers(abaza..'banned:'..msg.chat_id_)
if #list==0 then return "📋*¦* لايوجد أعضاء محظورين " end
message = '📋*¦* قائمه الاعضاء المحظورين :\n'
for k,v in pairs(list) do
local info = redis:hgetall(abaza..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-l ['..info.username..'] » (`' ..v.. '`) \n'
else
message = message ..k.. '-l ['..info.username..'](t.me/TH3bs) l » (`' ..v.. '`) \n'
end 
end 
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض المحظورين بسبب القائمه كبيره جدا ."
else
return message
end
end



--================================{{  Sudoer  }} ===================================
function GeneralBanned(User)
if redis:sismember(abaza..'gban_users',User) then 
return true 
else
return false
end 
end

function GetListGeneralBanned(msg)
local list = redis:smembers(abaza..'gban_users')
if #list==0 then return  "*📛¦ لايوجد اعضاء محظورين عام*" end
message = '🛠*¦* قائمه المحظورين عام :\n'
for k,v in pairs(list) do
local info = redis:hgetall(abaza..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
message = message ..k.. '-l ['..info.username..'] » (`' ..v.. '`) \n'
else
message = message ..k.. '-l ['..info.username..'](t.me/TH3bs) l » (`' ..v.. '`) \n'
end
end 
if utf8.len(message) > 4096 then
return "📛| لا يمكن عرض المحظورين بسبب القائمه كبيره جدا ."
else
return message
end
end

--================================{{  Filter Words  }} ===================================

function FilterX(msg,text)
text = tostring(text)
local var = false
if not msg.Admin and not msg.Special then -- للاعضاء فقط  
local list = redis:smembers(abaza..':Filter_Word:'..msg.chat_id_)
if #list ~=0 then
for k,word in pairs(list) do
if text:match('^('..word..')$') or text:match(word..' .*') or text:match('.* '..word) then
Del_msg(msg.chat_id_,msg.id_)
print("Word is Del")
var = true
else
var = false
end
end
else
var = false
end 
end 
return var
end


function FilterXList(msg)
local list = redis:smembers(abaza..':Filter_Word:'..msg.chat_id_)
if #list == 0 then return "🛠*¦* قائمه الكلمات الممنوعه فارغه" end
filterlist = '🛠*¦* قائمه الكلمات الممنوعه :\n'    
for k,v in pairs(list) do
filterlist = filterlist..'*'..k..'* -  '..Flter_Markdown(v)..'\n'
end
if utf8.len(filterlist) > 4096 then
return "📛| لا يمكن عرض الممنوعين بسبب القائمه كبيره جدا ."
else
return filterlist
end
end

function AddFilter(msg, word)
if redis:sismember(abaza..':Filter_Word:'..msg.chat_id_,word) then 
return  "📝*¦* الكلمه *{"..word.."}* هي بالتأكيد من قائمه المنع✓️" 
else
redis:sadd(abaza..':Filter_Word:'..msg.chat_id_,word) 
return  "📝*¦* الكلمه *{"..word.."}* تمت اضافتها الى قائمه المنع ✓️"
end
end

function RemFilter(msg, word)
if redis:sismember(abaza..':Filter_Word:'..msg.chat_id_,word) then 
redis:srem(abaza..':Filter_Word:'..msg.chat_id_,word) 
return  "📝*¦* الكلمه *{"..word.."}* تم السماح بها ✓️" 
else
return  "📝*¦* الكلمه *{"..word.."}* هي بالتأكيد مسموح بها✓️" 
end
end

------------------------------------------

function CheckFlood(User,ChatID)
local NumberFlood = tonumber(redis:get(abaza..':Flood_Spam:'..User..':'..ChatID..':msgs') or 0)
if NumberFlood >= 5 then 
result = false
else
redis:setex(abaza..':Flood_Spam:'..User..':'..ChatID..':msgs',2,NumberFlood+1)
result = true
end
return result
end


function buck_up_groups(msg)

json_data = '{"BotID": '..abaza..',"UserBot": "'..Bot_User..'","Groups" : {'
local All_Groups_ID = redis:smembers(abaza..'group:ids')
for key,GroupS in pairs(All_Groups_ID) do
local NameGroup = (redis:get(abaza..'group:name'..GroupS) or '')
NameGroup = NameGroup:gsub('"','')
NameGroup = NameGroup:gsub([[\]],'')
if key == 1 then
json_data =  json_data ..'"'..GroupS..'":{"Title":"'..NameGroup..'"'
else
json_data =  json_data..',"'..GroupS..'":{"Title":"'..NameGroup..'"'
end

local admins = redis:smembers(abaza..'admins:'..GroupS)
if #admins ~= 0 then
json_data =  json_data..',"Admins" : {'
for key,value in pairs(admins) do
local info = redis:hgetall(abaza..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end

local creator = redis:smembers(abaza..':MONSHA_BOT:'..GroupS)
if #creator ~= 0 then
json_data =  json_data..',"Creator" : {'
for key,value in pairs(creator) do
local info = redis:hgetall(abaza..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end 
end
json_data =  json_data..'}'
end

local owner = redis:smembers(abaza..'owners:'..GroupS)
if #owner ~= 0 then
json_data =  json_data..',"Owner" : {'
for key,value in pairs(owner) do
local info = redis:hgetall(abaza..'username:'..value)
if info then 
UserName_ = (info.username or "")
UserName_ = UserName_:gsub([[\]],'')
UserName_ = UserName_:gsub('"','')
end 
if key == 1 then
json_data =  json_data..'"'..UserName_..'":'..value
else
json_data =  json_data..',"'..UserName_..'":'..value
end
end
json_data =  json_data..'}'
end

json_data =  json_data.."}"
end

local Save_Data = io.open("./inc/"..Bot_User..".json","w+")
Save_Data:write(json_data..'}}')
Save_Data:close()
sendDocument(msg.chat_id_,msg.id_,"./inc/"..Bot_User..".json","🚸| ملف النسخه الاحتياطيه ...\n🔖| المجموعات » { "..#All_Groups_ID.." }\n📋| للبوت » "..Bot_User.."\n📆| التاريخ » "..os.date("%Y/%m/%d").."\n",dl_cb,nil)
end

function chat_list(msg)
local list = redis:smembers(abaza..'group:ids')
message = '📋*¦* قائمه المجموعات :\n\n'
for k,v in pairs(list) do 
local info = redis:get(abaza..'group:name'..v)
if info then 
if utf8.len(info) > 25 then
info = utf8.escape(utf8.gsub(info,0,25))..'...'
end
message = message..k..'ـ '..Flter_Markdown(info).. ' \nــ •⊱ { `' ..v.. '` } ⊰•\n\n'
else 
message = message..k.. 'ـ '..' ☜ •⊱ { `' ..v.. '` } ⊰• \n'
end 
end
all_groups = '📋¦ قائمه المجموعات :<br><br>'
for k,v in pairs(list) do 
local info = redis:get(abaza..'group:name'..v)
if info then
all_groups = all_groups..' '..k..'- <span style="color: #bd2a2a;">'..info.. '</span> <br> ايدي ☜ (<span style="color:#078883;">' ..v.. '</span>)<br>'
else
all_groups = all_groups..' '..k.. '- '..' ☜ (<span style="color:#078883;">' ..v.. '</span>) <br>'
end 
end

if utf8.len(message) > 4096 then
sendMsg(msg.chat_id_,1,'🚸*¦* عذرا لديك الكثير من المجموعات\n👨🏽‍💻*¦* سوف ارسل لك ملف فيها قائمه مجموعات المفعله انتظر لحظه ...')
file = io.open("./inc/All_Groups.html", "w")
file:write([[
<html dir="rtl">
<head>
<title>قائمه المجموعات 🗣</title>
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/css?family=Harmattan" rel="stylesheet">

</head>
<style>*{font-family: 'Harmattan', sans-serif;font-weight: 600;text-shadow: 1px 1px 16px black;}</style>
<body>
<p style="color:#018bb6;font-size: 17px;font-weight: 600;" aligin="center">قائمه المجموعات 🗣</p>
<hr>
]]..all_groups..[[

</body>
</html>
]])
file:close()
return sendDocument(msg.chat_id_,msg.id_,'./inc/All_Groups.html','👨🏽‍✈️¦ قائمه المجموعات بالكامله ✓ \n🗃¦ يحتوي ('..#list..') مجموعه \n🖥¦افتح الملف في عارض HTML او بالمتصفح',dl_cb,nil)
else 
return sendMsg(msg.chat_id_,1,message) 
end 
end



function rem_data_group(id_group)
redis:del(
abaza..'group:add'..id_group,
abaza..'lock_link'..id_group, 
abaza..'lock_id'..id_group,
abaza..'lock_spam'..id_group, 
abaza..'lock_webpage'..id_group,
abaza..'lock_markdown'..id_group,
abaza..'lock_flood'..id_group,
abaza..'lock_bots'..id_group,
abaza..'mute_forward'..id_group,
abaza..'mute_contact'..id_group,
abaza..'mute_location'..id_group,
abaza..'mute_document'..id_group,
abaza..'mute_keyboard'..id_group,
abaza..'mute_game'..id_group,
abaza..'mute_inline'..id_group,
abaza..'lock_username'..id_group,
abaza..'num_msg_max'..id_group,
abaza..'mute_text'..id_group,
abaza..'admins:'..id_group,
abaza..':Filter_Word:'..id_group,
abaza..'banned:'..id_group,
abaza..'is_silent_users:'..id_group,
abaza..'whitelist:'..id_group,
abaza..':MONSHA_BOT:'..id_group,
abaza..'owners:'..id_group,
abaza..'replay'..id_group,
abaza..':MONSHA_Group:'..id_group
)
redis:srem(abaza..'group:ids',id_group)
end



function set_admins(msg) 
GetChannelAdministrators(msg.chat_id_,function(arg,data)
local NumAdmin = 0
for k,v in pairs(data.members_) do
if not data.members_[k].bot_info_ and data.members_[k].status_.ID == "ChatMemberStatusEditor" then
NumAdmin = NumAdmin + 1
if not redis:sismember(abaza..'admins:'..arg.chat_id_,v.user_id_) then
GetUserID(v.user_id_,function(arg,data)
redis:hset(abaza..'username:'..data.id_,'username',ResolveUserName(data))
redis:sadd(abaza..'admins:'..arg.chat_id_,data.id_)
end,{chat_id_=msg.chat_id_,id_=msg.id_})
end
end
end
if NumAdmin == 0 then 
return sendMsg(arg.chat_id_,arg.id_,"📮¦ لا يـوجـد أدمـنـيـه لكي يتـم رفعهم \n")
else
return sendMsg(arg.chat_id_,arg.id_,"📮¦ تم رفع  { *"..NumAdmin.."* } مـن آلآدمـنيهہ‌‏ في آلبوت \n✓️")
end
end,30,{chat_id_=msg.chat_id_,id_=msg.id_})
end




function modadd(msg)
if redis:get(abaza..'lock_service') then
lock_servicez = true
else
lock_servicez = false
end
if not msg.SudoUser and not lock_servicez then return '🚸¦ أنـت لـسـت الـمـطـور ⚙️' end
if msg.is_post_ then return "🚸¦ عذرا هذا بوت حمايه للمجموعات وليس للقنوات  " end
if msg.type ~= "channel" then return '🚸¦ البوت يعمل فقط في المجموعات العامه لذا يجب ترقية المجموعه ووضع معرف للمجموعه لتصبح عامه ⚙️' end


GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg 
local NameUser   = Hyper_Link_Name(data)
if redis:get(abaza..'group:add'..msg.chat_id_) then  return sendMsg(msg.chat_id_,msg.id_,'📬¦ المجموعه بالتأكيد ✓️ تم تفعيلها \n📮¦ بواسطه ⋙「 '..NameUser..' 」 \n') end
local UserChaneel = redis:get(abaza..":UserNameChaneel")
if UserChaneel and not msg.SudoBase then
local url , res = https.request(ApiToken..'/getchatmember?chat_id='..UserChaneel..'&user_id='..msg.sender_user_id_)
if res == 200 then
print(url) 
local Req = JSON.decode(url)
if Req.ok and Req.result and Req.result.status == "left" or Req.result.status == "kicked" then
return sendMsg(msg.chat_id_,msg.id_,"🚸| آشـترگ بآلقنآ‌‏هہ آولآ ["..UserChaneel.."] \n🔛| ثم آرجع آرسـل تفعيل .")
end
else
return "🚸| آشـترگ بآلقنآ‌‏هہ آولآ ["..UserChaneel.."] \n🔛| ثم آرجع آرسـل تفعيل ."
end
end



if redis:get(abaza..'lock_service') then
lock_servicez = true
else
lock_servicez = false
end

GetFullChat(msg.chat_id_,function(arg,data) 
local GroupUsers = tonumber(redis:get(abaza..':addnumberusers') or 0)
local Groupcount = tonumber(data.member_count_)
if GroupUsers  >= Groupcount and not arg.SudoBase then
return sendMsg(arg.chat_id_,arg.id_,'🚸*¦* لآ يمـگنني تفعيل آلبوت في آلمـجمـوعهہ‏ يجب آن يگون آگثر مـن *【'..GroupUsers..'】* عضـو 👤')
end
if data.channel_ and data.channel_.status_.ID  == "ChatMemberStatusMember" then
return sendMsg(arg.chat_id_,arg.id_,'📛*¦* عذرا البوت ليس ادمن  في المجموعه ♨️\n🔙*¦* يرجى رفعه ادمن لتتمكن من تفعيل البوت ✓️')
end
if arg.lock_servicez then 
sendMsg(arg.chat_id_,arg.id_,'📬¦ تـم تـفـعـيـل الـمـجـمـوعـه ✓️ \n👨🏽‍🔧¦ وتم رفع جمـيع آلآدمـنيهہ‏‏‏ آلگروب بآلبوت \n📮¦ بواسطه ⋙「 '..NameUser..' 」 \n')
else
sendMsg(arg.chat_id_,arg.id_,'📬¦ تـم تـفـعـيـل آلمـجمـوعهہ‏‏ \n📮¦ بواسطه ⋙「 '..NameUser..' 」 \n')
end

GetChannelAdministrators(arg.chat_id_,function(arg,data)
for k,v in pairs(data.members_) do
if data.members_[k].status_.ID == "ChatMemberStatusCreator" then
GetUserID(v.user_id_,function(arg,data)
redis:hset(abaza..'username:'..data.id_,'username', ResolveUserName(data))
redis:sadd(abaza..':MONSHA_Group:'..arg.chat_id_,data.id_)
end,{chat_id_=arg.chat_id_})
elseif arg.lock_servicez and not data.members_[k].bot_info_ and data.members_[k].status_.ID == "ChatMemberStatusEditor" then
if not redis:sismember(abaza..'admins:'..arg.chat_id_,v.user_id_) then
GetUserID(v.user_id_,function(arg,data)
redis:hset(abaza..'username:'..data.id_,'username',ResolveUserName(data))
redis:sadd(abaza..'admins:'..arg.chat_id_,data.id_)
end,{chat_id_=arg.chat_id_})
end
end
end
end,25,{chat_id_=arg.chat_id_,sender_user_id_=arg.sender_user_id_,lock_servicez=arg.lock_servicez})



GroupTitle(arg.chat_id_,function(arg,data)

redis:mset(
abaza..'group:add'..arg.chat_id_,true,
abaza..'lock_link'..arg.chat_id_,true, 
abaza..'lock_id'..arg.chat_id_,true,
abaza..'lock_spam'..arg.chat_id_,true,
abaza..'lock_webpage'..arg.chat_id_,true,
abaza..'lock_markdown'..arg.chat_id_,true,
abaza..'lock_flood'..arg.chat_id_,true,
abaza..'lock_bots'..arg.chat_id_,true,
abaza..'mute_forward'..arg.chat_id_,true,
abaza..'mute_contact'..arg.chat_id_,true,
abaza..'mute_location'..arg.chat_id_,true,
abaza..'mute_document'..arg.chat_id_,true,
abaza..'mute_keyboard'..arg.chat_id_,true,
abaza..'mute_game'..arg.chat_id_,true,
abaza..'mute_inline'..arg.chat_id_,true,
abaza..'lock_username'..arg.chat_id_,true,
abaza..'num_msg_max'..arg.chat_id_,5, 
abaza..'lock_edit'..arg.chat_id_,true,
abaza..'replay'..arg.chat_id_,true,
abaza..'lock_rdodSource'..arg.chat_id_,true,
abaza.."lock_KickBan"..msg.chat_id_,true,
abaza.."lock_mmno3"..msg.chat_id_,true,
abaza.."lock_KickBan"..msg.chat_id_,true,
abaza.."lock_RandomRdod"..msg.chat_id_,true,
abaza.."lock_linkk"..msg.chat_id_,true
)
redis:sadd(abaza..'group:ids',arg.chat_id_) 
redis:sadd(abaza..'mtwr_count'..arg.sender_user_id_,arg.chat_id_)

local NameGroup = data.title_
redis:set(abaza..'group:name'..arg.chat_id_,NameGroup)
if not arg.invite_link_ then
Gp_Link = ExportLink(arg.chat_id_)
if Gp_Link and Gp_Link.result then
Gp_Link = Gp_Link.result
else
Gp_Link = ""
end
else
Gp_Link = arg.invite_link_
end
redis:set(abaza..'linkGroup'..arg.chat_id_,Gp_Link)
if arg.sender_user_id_ == SUDO_ID then return false end
GetUserID(arg.sender_user_id_,function(arg,datai)
if datai.username_ then 
USERNAME_T = '🎟*¦* الـمعرف  •⊱ @['..datai.username_..'] ⊰•\n'
else 
USERNAME_T = ''
end
send_msg(SUDO_ID,'👮🏽*¦* قام شخص بتفعيل البوت ...\n\nــــــــــــــــــــــــــــــــــــــــــ\n📑¦ معلومات المجموعه\n'
..'🗯¦ الاسم •⊱ ['..arg.NameGroup..']('..arg.Gp_Link..') ⊰• \n'
..'📛¦ الايدي •⊱`'..arg.chat_id_..'`⊰•\n'
..'🙋🏻‍♂¦ ألاعـضـاء •⊱{ *'..arg.Groupcount..'* }⊰• \nــــــــــــــــــــــــــــــــــــــــــ\n⚖️¦ معلومات الشخص \n'
..'👨🏽‍💻*¦* الاسـم •⊱{ ['..FlterName(datai.first_name_..' '..(datai.last_name_ or ""),23)..'](tg://user?id='..arg.sender_user_id_..') }⊰•\n\n'
..USERNAME_T..'📆¦ التاريخ •⊱* '..os.date("%Y/%m/%d")
..' *⊰•\n⏱¦ الساعه •⊱* '..os.date("%I:%M%p")..' *⊰•')
end,{chat_id_=arg.chat_id_,sender_user_id_=arg.sender_user_id_,NameGroup=NameGroup,Gp_Link=Gp_Link,Groupcount=arg.Groupcount})
end,{chat_id_=arg.chat_id_,sender_user_id_=arg.sender_user_id_,Groupcount=Groupcount,invite_link_=data.invite_link_})


end,{chat_id_=msg.chat_id_,id_=msg.id_,sender_user_id_=msg.sender_user_id_,lock_servicez=lock_servicez})
end,{msg=msg})
return false
end


function action_by_id(arg, data)
local cmd = arg.cmd
local ChatID = arg.msg.chat_id_
local MsgID = arg.msg.id_
local msg = arg.msg or ""
if not data.id_ then 
sendMsg(ChatID,MsgID,"📛*¦* العضو لا يوجد\n❕") 
return false
end
local UserID = data.id_
local Resolv = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if data.username_ then 
USERNAME = '@'..data.username_
else 
USERNAME = FlterName(data.first_name_..' '..(data.last_name_ or ""),20) 
end
USERCAR = utf8.len(USERNAME)

if cmd == "tqeed" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المطور الاساسي\n🛠") 
elseif UserID == 819385837 or UserID == 60809019 then 
return sendMsg(ChatID,MsgID,"⚜️*¦* لا يمكنك طرد مطور السورس\n🛠") 
elseif redis:sismember(abaza..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المطور\n🛠") 
elseif redis:sismember(abaza..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المنشئ\n🛠") 
elseif redis:sismember(abaza..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المنشئ الاساسي\n🛠") 
elseif redis:sismember(abaza..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المدير\n🛠") 
elseif redis:sismember(abaza..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد الادمن\n🛠") 
elseif  redis:sismember(abaza..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المميز\n🛠") 
end
Restrict(ChatID,UserID,1)
redis:hset(abaza..'username:'..UserID, 'username', Resolv)
redis:sadd(abaza..':tqeed:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم تقييده بنجاح \n✓")
end 
if cmd =="fktqeed" then
Restrict(ChatID,UserID,2)
redis:srem(abaza..':tqeed:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم فك تقييده بنجاح \n✓")
end
if cmd == "setwhitelist" then
if redis:sismember(abaza..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه مميز  في المجموعه \n✓") 
end
redis:hset(abaza..'username:'..UserID, 'username', Resolv)
redis:sadd(abaza..'whitelist:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه مميز  في المجموعه \n✓") 
end
if cmd == "remwhitelist" then
if not redis:sismember(abaza..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله مميز  في المجموعه \n✓") 
end
redis:srem(abaza..'whitelist:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله مميز  في المجموعه \n✓") 
end
if cmd == "setmnsha" then
if redis:sismember(abaza..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه منشئ  في المجموعه \n✓") 
end
redis:hset(abaza..'username:'..UserID, 'username', Resolv)
redis:sadd(abaza..':MONSHA_BOT:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه منشئ  في المجموعه \n✓") 
end
if cmd == "remmnsha" then
if not redis:sismember(abaza..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله منشئ  في المجموعه \n✓") 
end
redis:srem(abaza..':MONSHA_BOT:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله منشى  في المجموعه \n✓") 
end

if cmd == "setowner" then
if redis:sismember(abaza..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه مدير  في المجموعه \n✓") 
end
Resolv = Resolv:gsub([[\_]],"_")
redis:hset(abaza..'username:'..UserID, 'username', Resolv)
redis:sadd(abaza..'owners:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه مدير  في المجموعه \n✓") 
end
if cmd == "remowner" then
if not redis:sismember(abaza..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله مدير  في المجموعه \n✓") 
end
redis:srem(abaza..'owners:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله مدير  في المجموعه \n✓") 
end
if cmd == "promote" then
if redis:sismember(abaza..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه ادمن  في المجموعه \n✓") 
end
Resolv = Resolv:gsub([[\_]],"_")
redis:hset(abaza..'username:'..UserID, 'username', Resolv)
redis:sadd(abaza..'admins:'..ChatID,UserID) 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه ادمن  في المجموعه \n✓") 
end
if cmd == "demote" then
if not redis:sismember(abaza..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله ادمن  في المجموعه \n✓") 
end
redis:srem(abaza..'admins:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله ادمن  في المجموعه \n✓") 
end
if cmd == "whois" then
GetChatMember(ChatID,UserID,function(arg,data1)
local namei = data.first_name_..' '..(data.last_name_ or "")
if data.username_ then useri = '@'..data.username_ else useri = " لا يوجد " end
return SendMention(ChatID,UserID,MsgID,'🤵🏼¦ الاسم » '..namei..'\n'
..'🎫¦ الايدي » {'..UserID..'} \n'
..'🎟¦ المعرف » '..useri..'\n'
..'📮¦ الرتبه » '..Getrtba(UserID,ChatID)..'\n'
..'🕵🏻️‍♀️¦ نوع الكشف » بالايدي\n➖',13,utf8.len(namei))
end)
end

if cmd == "Upmonsh" then
if redis:sismember(abaza..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه منشئ اساسي  في المجموعه \n✓") 
end
redis:hset(abaza..'username:'..UserID,'username',USERNAME)
redis:sadd(abaza..':MONSHA_Group:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه منشئ اساسي  في المجموعه \n✓") 
end

if cmd == "Dwmonsh" then
if not redis:sismember(abaza..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله منشئ اساسي  في المجموعه \n✓") 
end
redis:srem(abaza..':MONSHA_Group:'..ChatID,UserID) 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله منشئ اساسي  في المجموعه \n✓") 
end

if cmd == "up_sudo" then
if redis:sismember(abaza..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه مطور  في البوت \n✓") 
end
redis:hset(abaza..'username:'..UserID, 'username', USERNAME)
redis:sadd(abaza..':SUDO_BOT:',UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه مطور  في البوت \n✓") 
end

if cmd == "dn_sudo" then
if not redis:sismember(abaza..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله مطور  في البوت \n✓") 
end
redis:srem(abaza..':SUDO_BOT:',UserID) 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله مطور  في البوت \n✓") 
end

if cmd == "ban" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر البوت\n🛠") 
elseif UserID == 819385837 or UserID == 60809019 then 
return sendMsg(ChatID,MsgID,"⚜️*¦* لا يمكنك حظر مطور السورس\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المطور الاساسي\n🛠") 
elseif redis:sismember(abaza..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المطور\n🛠") 
elseif redis:sismember(abaza..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المنشئ\n🛠") 
elseif redis:sismember(abaza..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المنشئ الاساسي\n🛠") 
elseif redis:sismember(abaza..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المدير\n🛠") 
elseif redis:sismember(abaza..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر الادمن\n🛠")
elseif  redis:sismember(abaza..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المميز\n🛠") 
end
if Check_Banned(ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد حظره  من المجموعه \n✓") 
end
redis:hset(abaza..'username:'..UserID, 'username', Resolv)
redis:sadd(abaza..'banned:'..ChatID,UserID)
kick_user(UserID, ChatID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم حظره  من المجموعه \n✓") 
end

if cmd == "kick" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد البوت\n🛠") 
elseif UserID == 819385837 or UserID == 60809019 then 
return sendMsg(ChatID,MsgID,"⚜️*¦* لا يمكنك طرد مطور السورس\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المطور الاساسي\n🛠") 
elseif redis:sismember(abaza..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المطور\n🛠") 
elseif redis:sismember(abaza..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المنشئ\n🛠") 
elseif redis:sismember(abaza..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المنشئ الاساسي\n🛠") 
elseif redis:sismember(abaza..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المدير\n🛠") 
elseif redis:sismember(abaza..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد الادمن\n🛠") 
elseif  redis:sismember(abaza..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك طرد المميز\n🛠") 
end
kick_user(UserID, ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(ChatID,MsgID,'📛*¦* لا يمكنني طرد العضو .\n🎟*¦* لانه مشرف في المجموعه \n ❕')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(ChatID,MsgID,'📛*¦* لا يمكنني طرد العضو .\n🎟*¦* ليس لدي صلاحيه الحظر او لست مشرف\n ❕')    
end
StatusLeft(ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم طرده  من المجموعه \n✓") 
end)
end

if cmd == "uban" then
if not Check_Banned(ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد الغاء حظره  من المجموعه \n✓") 
else
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم الغاء حظره  من المجموعه \n✓") 
end
redis:hset(abaza..'username:'..UserID, 'username', Resolv)
redis:srem(abaza..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
return false
end

if cmd == "ktm" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم البوت\n🛠") 
elseif UserID == 819385837 or UserID == 60809019 then 
return sendMsg(ChatID,MsgID,"⚜️*¦* لا يمكنك كتم مطور السورس\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم المطور الاساسي\n🛠") 
elseif redis:sismember(abaza..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم المطور\n🛠") 
elseif redis:sismember(abaza..':MONSHA_BOT:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم المنشئ\n🛠") 
elseif redis:sismember(abaza..':MONSHA_Group:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم المنشئ الاساسي\n🛠") 
elseif redis:sismember(abaza..'owners:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم المدير\n🛠") 
elseif redis:sismember(abaza..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم الادمن\n🛠") 
elseif  redis:sismember(abaza..'whitelist:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم المميز\n🛠") 
end
if redis:sismember(abaza..'admins:'..ChatID,UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك كتم المدراء او الادمنيه\n🛠") 
end
if MuteUser(ChatID, UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد كتمه  من المجموعه \n✓") 
end
redis:hset(abaza..'username:'..UserID, 'username', Resolv)
redis:sadd(abaza..'is_silent_users:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم كتمه  من المجموعه \n✓") 
end

if cmd == "unktm" then
if not MuteUser(ChatID, UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد الغاء كتمه  من المجموعه \n✓") 
end
redis:hset(abaza..'username:'..UserID, 'username', Resolv)
redis:srem(abaza..'is_silent_users:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم الغاء كتمه  من المجموعه \n✓") 
end

if cmd == "upMshrf" then
redis:hset(abaza..'username:'..UserID,'username',Resolv)
redis:setex(abaza..":uploadingsomeon:"..ChatID..msg.sender_user_id_,500,NameUser)
redis:setex(abaza..":uploadingsomeon2:"..ChatID..msg.sender_user_id_,500,UserID)
sendMsg(ChatID,MsgID,"📇|  » حسننا الان ارسل صلاحيات المشرف :\n\n|1- صلاحيه تغيير المعلومات\n|2- صلاحيه حذف الرسائل\n|3- صلاحيه دعوه مستخدمين\n|4- صلاحيه حظر وتقيد المستخدمين \n|5- صلاحيه تثبيت الرسائل \n|6- صلاحيه رفع مشرفين اخرين\n\n|[*]- لرفع كل الصلاحيات ما عدا رفع المشرفين \n|[**] - لرفع كل الصلاحيات مع رفع المشرفين \n\n🚸| يمكنك اختيار الارقام معا وتعيين الكنيه للمشرف في ان واحد مثلا : \n\n| 136 الزعيم\n📬") 
return false
end

if cmd == "DwonMshrf" then
ResAdmin = UploadAdmin(ChatID,UserID,"")  
if ResAdmin == '{"ok":false,"error_code":400,"description":"Bad Request: CHAT_ADMIN_REQUIRED"}' then return sendMsg(ChatID,MsgID,"👤*¦*لا يمكنني تنزيله لانه مرفوع من قبل منشئ اخر \n📛")  end
redis:srem(abaza..':MONSHA_BOT:'..ChatID,UserID)
redis:srem(abaza..'owners:'..ChatID,UserID)
redis:srem(abaza..'admins:'..ChatID,UserID)
redis:srem(abaza..'whitelist:'..ChatID,UserID)
sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله من مشرفين المجموعه \n✓")
return false
end

if cmd == "bandall" then
if UserID == our_id then   
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر البوت\n🛠") 
elseif UserID == 819385837 or UserID == 60809019 then 
return sendMsg(ChatID,MsgID,"⚜️*¦* لا يمكنك حظر مطور السورس\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المطور الاساسي\n🛠")
elseif redis:sismember(abaza..':SUDO_BOT:',UserID) then 
return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك حظر المطور\n🛠") 
end
if GeneralBanned(UserID) then 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد حظره عام  من المجموعات \n✓") 
end
redis:hset(abaza..'username:'..UserID, 'username', Resolv)
redis:sadd(abaza..'gban_users',UserID)
kick_user(UserID,ChatID) 
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم حظره عام  من المجموعات \n✓") 
end

if cmd == "unbandall" then  
if not GeneralBanned(UserID) then
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد الغاء حظره العام  من المجموعات \n✓") 
end
redis:srem(abaza..'gban_users',UserID)
StatusLeft(ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم الغاء حظره العام  من المجموعات \n✓") 
end

if cmd == "tfa3l" then  
local maseegs = redis:get(abaza..'msgs:'..UserID..':'..ChatID) or 1
local edited = redis:get(abaza..':edited:'..ChatID..':'..UserID) or 0
local content = redis:get(abaza..':adduser:'..ChatID..':'..UserID) or 0
if data.username_ then UserNameID = "@"..data.username_ else UserNameID = "لا يوجد" end  

sendMsg(ChatID,MsgID,"🎫┇ايديه » `"..UserID.."`\n📨┇رسائله » "..maseegs.."\n🎟┇معرفه » ["..UserNameID.."]\n📈┇تفاعله » "..Get_Ttl(maseegs).."\n📮┇رتبته » "..Getrtba(UserID,ChatID).."\n⚡️┇تعديلاته » "..edited.."\n☎️┇جهاته » "..content.."") 
end

if cmd == "rfaqud" then  
if UserID == our_id then return sendMsg(ChatID,MsgID,"👤*¦* لا يمكنك تنفيذ الامر بالرد ع رسالة البوت \n📛") end
Restrict(ChatID,UserID,2)
redis:srem(abaza..'banned:'..ChatID,UserID)
StatusLeft(ChatID,UserID)
redis:srem(abaza..'is_silent_users:'..ChatID,UserID)
return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n  تم رفع القيود ان وجد\n✓") 
end

--========================================================================
if cmd == "DwnAll" then ----------- تنزيل الكل
print(UserID..":"..SUDO_ID)
if UserID == our_id then return sendMsg(ChatID,MsgID,"📛*¦* لآ يمكنك تنفيذ الامر مع البوت\n❕") end
if UserID == 819385837 or UserID == 60809019 then return sendMsg(ChatID,MsgID,"📛*¦* لآ يمكنك تنفيذ الامر ضد مطور السورس \n❕") end

if UserID == SUDO_ID then 
rinkuser = 1
elseif redis:sismember(abaza..':SUDO_BOT:',UserID) then 
rinkuser = 2
elseif redis:sismember(abaza..':MONSHA_Group:'..ChatID,UserID) then 
rinkuser = 3
elseif redis:sismember(abaza..':MONSHA_BOT:'..ChatID,UserID) then 
rinkuser = 4
elseif redis:sismember(abaza..'owners:'..ChatID,UserID) then 
rinkuser = 5
elseif redis:sismember(abaza..'admins:'..ChatID,UserID) then 
rinkuser = 6
elseif redis:sismember(abaza..'whitelist:'..ChatID,UserID) then 
rinkuser = 7
else
rinkuser = 8
end
local DonisDown = "\n📛¦ تم تنزيله من الرتب الاتيه : \n\n "
if redis:sismember(abaza..':SUDO_BOT:',UserID) then 
DonisDown = DonisDown.."❌¦  تم تنزيله من المطور ✓️\n"
end 
if redis:sismember(abaza..':MONSHA_Group:'..ChatID,UserID) then 
DonisDown = DonisDown.."❌¦  تم تنزيله من المنشئ الاساسي ✓️\n"
end 
if redis:sismember(abaza..':MONSHA_BOT:'..ChatID,UserID) then 
DonisDown = DonisDown.."❌¦  تم تنزيله من المنشئ ✓️\n"
end 
if redis:sismember(abaza..'owners:'..ChatID,UserID) then 
DonisDown = DonisDown.."❌¦  تم تنزيله من المدير ✓️\n"
end 
if redis:sismember(abaza..'admins:'..ChatID,UserID) then 
DonisDown = DonisDown.."❌¦  تم تنزيله من الادمن ✓️\n"
end 
if redis:sismember(abaza..'whitelist:'..ChatID,UserID) then
DonisDown = DonisDown.."❌¦  تم تنزيله من العضو مميز ✓️\n"
end

function senddwon()  sendMsg(ChatID,MsgID,"📛*¦* عذرا المستخدم رتبته اعلى منك لا يمكن تنزيله \n❕") end
function sendpluse() sendMsg(ChatID,MsgID,"📛*¦* عذرا لا يمكن تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." \n❕") end

if rinkuser == 8 then return sendMsg(ChatID,MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」   \nانه بالتأكيد عضو \n✓️")  end
huk = false
if msg.SudoBase then 
redis:srem(abaza..':SUDO_BOT:',UserID)
redis:srem(abaza..':MONSHA_Group:'..ChatID,UserID)
redis:srem(abaza..':MONSHA_BOT:'..ChatID,UserID)
redis:srem(abaza..'owners:'..ChatID,UserID)
redis:srem(abaza..'admins:'..ChatID,UserID)
redis:srem(abaza..'whitelist:'..ChatID,UserID)
elseif msg.SudoUser then 
if rinkuser == 2 then return sendpluse() end
if rinkuser < 2 then return senddwon() end
redis:srem(abaza..':MONSHA_Group:'..ChatID,UserID)
redis:srem(abaza..':MONSHA_BOT:'..ChatID,UserID)
redis:srem(abaza..'owners:'..ChatID,UserID)
redis:srem(abaza..'admins:'..ChatID,UserID)
redis:srem(abaza..'whitelist:'..ChatID,UserID)
elseif msg.SuperCreator then 
if rinkuser == 3 then return sendpluse() end
if rinkuser < 3 then return senddwon() end
redis:srem(abaza..':MONSHA_BOT:'..ChatID,UserID)
redis:srem(abaza..'owners:'..ChatID,UserID)
redis:srem(abaza..'admins:'..ChatID,UserID)
redis:srem(abaza..'whitelist:'..ChatID,UserID)
elseif msg.Creator then 
if rinkuser == 4 then return sendpluse() end
if rinkuser < 5 then return senddwon() end
redis:srem(abaza..'owners:'..ChatID,UserID)
redis:srem(abaza..'admins:'..ChatID,UserID)
redis:srem(abaza..'whitelist:'..ChatID,UserID)
elseif msg.Director then 
if rinkuser == 5 then return sendpluse() end
if rinkuser < 5 then return senddwon() end
redis:srem(abaza..'admins:'..ChatID,UserID)
redis:srem(abaza..'whitelist:'..ChatID,UserID)
elseif msg.Admin then 
if rinkuser == 6 then return sendpluse() end
if rinkuser < 6 then return senddwon() end
redis:srem(abaza..'admins:'..ChatID,UserID)
redis:srem(abaza..'whitelist:'..ChatID,UserID)
else
huk = true
end

if not huk then sendMsg(ChatID,UserID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n"..DonisDown.."\n✓️") end

end

end

function settingsall(msg)

list_settings = "*👮🏾¦*` اعدادات المجموعه :` \n"
.."\n📝¦ التعديل » "..(redis:get(abaza..'lock_edit'..msg.chat_id_) or 'false')
.."\n🔗¦ الروابط » "..(redis:get(abaza..'lock_link'..msg.chat_id_) or 'false')
.."\n#️⃣¦ التاك » "..(redis:get(abaza..'lock_tag'..msg.chat_id_) or 'false')
.."\n©¦ المعرفات » "..(redis:get(abaza..'lock_username'..msg.chat_id_) or 'false')
.."\n\n💱¦ التكرار » "..(redis:get(abaza..'lock_flood'..msg.chat_id_) or 'false')
.."\n📑¦ الكلايش » "..(redis:get(abaza..'lock_spam'..msg.chat_id_) or 'false')
.."\n🌐¦ الويب » "..(redis:get(abaza..'lock_webpage'..msg.chat_id_) or 'false')
.."\n⚜️¦ الماركدوان » "..(redis:get(abaza..'lock_markdown'..msg.chat_id_) or 'false')
.."\n🏌🏻¦ البوتات بالطرد » "..(redis:get(abaza..'lock_bots_by_kick'..msg.chat_id_) or 'false')
.."\n🤖¦ البوتات » "..(redis:get(abaza..'lock_bots'..msg.chat_id_) or 'false')
.."\n➕¦ عدد التكرار » "..(redis:get(abaza..'num_msg_max'..msg.chat_id_) or 'false')
.."\n⏰¦ وقت التنظيف » "..(redis:get(abaza..':Timer_Cleaner:'..msg.chat_id_) or '6').." ساعة ."
.."\n\n🎬¦` اعدادات الوسائط :`\n"
.."\n🤹*¦* المتحركه » "..(redis:get(abaza..'mute_gif'..msg.chat_id_) or 'false')
.."\n💭¦ الدردشه » "..(redis:get(abaza..'mute_text'..msg.chat_id_) or 'false')
.."\n◽️¦ الانلاين » "..(redis:get(abaza..'mute_inline'..msg.chat_id_) or 'false')
.."\n🎮¦ الالعاب » "..(redis:get(abaza..'mute_game'..msg.chat_id_) or 'false')
.."\n🏞¦ الصور » "..(redis:get(abaza..'mute_photo'..msg.chat_id_) or 'false')
.."\n🎥¦ الفيديو » "..(redis:get(abaza..'mute_video'..msg.chat_id_) or 'false')
.."\n🎙¦ الصوت » "..(redis:get(abaza..'mute_audio'..msg.chat_id_) or 'false')
.."\n\n🔉¦ البصمات » "..(redis:get(abaza..'mute_voice'..msg.chat_id_) or 'false')
.."\n🎎¦ الملصقات » "..(redis:get(abaza..'mute_sticker'..msg.chat_id_) or 'false')
.."\n📞¦ الجهات » "..(redis:get(abaza..'mute_contact'..msg.chat_id_) or 'false')
.."\n💱¦ التوجيه » "..(redis:get(abaza..'mute_forward'..msg.chat_id_) or 'false')
.."\n🌐¦ الموقع » "..(redis:get(abaza..'mute_location'..msg.chat_id_) or 'false')
.."\n🗂¦ الملفات » "..(redis:get(abaza..'mute_document'..msg.chat_id_) or 'false')
.."\n🔅¦ الاشعارات » "..(redis:get(abaza..'mute_tgservice'..msg.chat_id_) or 'false')
.."\n🔒¦ الفشار » "..(redis:get(abaza..'lock_mmno3'..msg.chat_id_) or 'false')
.."\n🔒¦ الفارسيه » "..(redis:get(abaza..'lock_pharsi'..msg.chat_id_) or 'false')
.."\n🔒¦ الانكليزيه » "..(redis:get(abaza..'lock_lang'..msg.chat_id_) or 'false')
.."\n🔒¦ الاضافه » "..(redis:get(abaza..'lock_Add'..msg.chat_id_) or 'false')

local eueuf = "\n\n*⚒¦*` اعدادات اخرى : `"
.."\n*🙋🏼‍♂️¦* الترحيب » "..(redis:get(abaza..'welcome:get'..msg.chat_id_) or 'false')
.."\n*📋¦*  الردود » "..(redis:get(abaza..'replay'..msg.chat_id_) or 'false')
.."\n*📋¦*  الردود العشوائيه » "..(redis:get(abaza.."lock_RandomRdod"..msg.chat_id_) or 'false')
.."\n*🚸¦*  التحذير » "..(redis:get(abaza..'lock_woring'..msg.chat_id_) or 'false')
.."\n*📝¦* الايدي » "..(redis:get(abaza..'lock_id'..msg.chat_id_) or 'false')
.."\n*💬¦* الرابط » "..(redis:get(abaza..'lock_linkk'..msg.chat_id_) or 'false')
.."\n*📮¦* المغادره » "..(redis:get(abaza..'lock_leftgroup'..msg.chat_id_) or 'false')
.."\n*🗳¦* الحظر » "..(redis:get(abaza..'lock_KickBan'..msg.chat_id_) or 'false')
.."\n*🔍¦* الحمايه » "..(redis:get(abaza..'antiedit'..msg.chat_id_) or 'false')
.."\n*📋¦* التاك للكل » "..(redis:get(abaza..'lock_takkl'..msg.chat_id_) or 'false')
.."\n*📒¦* الايدي بالصوره » "..(redis:get(abaza..'idphoto'..msg.chat_id_) or 'false')
.."\n*🔐¦* التحقق » "..(redis:get(abaza.."lock_check"..msg.chat_id_) or 'false')
.."\n*🗑¦* التنظيف التلقائي » "..(redis:get(abaza.."lock_cleaner"..msg.chat_id_) or 'false')
.."\n*📂¦* ردود السورس » "..(redis:get(abaza.."lock_rdodSource"..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', '{ مقفول }')
list_settings = list_settings:gsub('false', '{ مفتوح }')
eueuf = eueuf:gsub('true', '{ مفعل }')
eueuf = eueuf:gsub('false', '{ معطل }')
return sendMsg(msg.chat_id_,1,'➖\n'..list_settings..eueuf..'\n')
end

function settings(msg)
list_settings = "👮🏾¦` اعدادات المجموعه :` "
.."\n\n*#️⃣¦* التاك » "..(redis:get(abaza..'lock_tag'..msg.chat_id_) or 'false')
.."\n*©¦* المعرفات » "..(redis:get(abaza..'lock_username'..msg.chat_id_) or 'false')
.."\n*📝¦* التعديل » "..(redis:get(abaza..'lock_edit'..msg.chat_id_) or 'false')
.."\n*🔗¦* الروابط » "..(redis:get(abaza..'lock_link'..msg.chat_id_) or 'false')
.."\n\n*💱¦* التكرار » "..(redis:get(abaza..'lock_flood'..msg.chat_id_) or 'false')
.."\n*📑¦* الكلايش » "..(redis:get(abaza..'lock_spam'..msg.chat_id_) or 'false')
.."\n\n*🌐¦* الويب » "..(redis:get(abaza..'lock_webpage'..msg.chat_id_) or 'false')
.."\n*⚜️¦* الماركدوان » "..(redis:get(abaza..'lock_markdown'..msg.chat_id_) or 'false')
.."\n*🏌🏻¦* البوتات بالطرد » "..(redis:get(abaza..'lock_bots_by_kick'..msg.chat_id_) or 'false')
.."\n*🤖¦* البوتات » "..(redis:get(abaza..'lock_bots'..msg.chat_id_) or 'false')
.."\n*➕¦* عدد التكرار » "..(redis:get(abaza..'num_msg_max'..msg.chat_id_) or 'false')
.."\n\n*💱¦*` اعدادات التقـييد :`\n"
.."\n*💢¦* التقييد بالتوجيه » "..(redis:get(abaza..':tqeed_fwd:'..msg.chat_id_) or 'false')
.."\n*📸¦* التقييد بالصور » "..(redis:get(abaza..':tqeed_photo:'..msg.chat_id_) or 'false')
.."\n*🔗¦* التقييد بالروابط » "..(redis:get(abaza..':tqeed_link:'..msg.chat_id_) or 'false')
.."\n*🎉¦* التقييد بالمتحركه » "..(redis:get(abaza..':tqeed_gif:'..msg.chat_id_) or 'false')
.."\n*🎥¦* التقييد الفيديو » "..(redis:get(abaza..':tqeed_video:'..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', '{ مقفول }')
list_settings = list_settings:gsub('false', '{ مفتوح }')
return sendMsg(msg.chat_id_, msg.id_,'➖\n'..list_settings..'\n')
end

function media(msg)
list_settings = "*👮🏾¦*` اعدادات الوسائط:`\n"
.."\n*🎑¦* المتحركه » "..(redis:get(abaza..'mute_gif'..msg.chat_id_) or 'false')
.."\n*💭¦* الدردشه » "..(redis:get(abaza..'mute_text'..msg.chat_id_) or 'false')
.."\n*◽️¦* الانلاين » "..(redis:get(abaza..'mute_inline'..msg.chat_id_) or 'false')
.."\n*🎮¦* الالعاب » "..(redis:get(abaza..'mute_game'..msg.chat_id_) or 'false')
.."\n*🏞¦* الصور » "..(redis:get(abaza..'mute_photo'..msg.chat_id_) or 'false')
.."\n*🎥¦* الفيديو » "..(redis:get(abaza..'mute_video'..msg.chat_id_) or 'false')
.."\n*🎙¦* الصوت » "..(redis:get(abaza..'mute_audio'..msg.chat_id_) or 'false')
.."\n\n*🔉¦* البصمات » "..(redis:get(abaza..'mute_voice'..msg.chat_id_) or 'false')
.."\n*🎎¦* الملصقات » "..(redis:get(abaza..'mute_sticker'..msg.chat_id_) or 'false')
.."\n*📞¦* الجهات » "..(redis:get(abaza..'mute_contact'..msg.chat_id_) or 'false')
.."\n*💱¦* التوجيه » "..(redis:get(abaza..'mute_forward'..msg.chat_id_) or 'false')
.."\n*🌐¦* الموقع » "..(redis:get(abaza..'mute_location'..msg.chat_id_) or 'false')
.."\n*🗂¦* الملفات » "..(redis:get(abaza..'mute_document'..msg.chat_id_) or 'false')
.."\n*🔅¦* الاشعارات » "..(redis:get(abaza..'mute_tgservice'..msg.chat_id_) or 'false')
.."\n*🔒¦* الكيبورد » "..(redis:get(abaza..'mute_keyboard'..msg.chat_id_) or 'false')
list_settings = list_settings:gsub('true', '{ مقفول }')
list_settings = list_settings:gsub('false', '{ مفتوح }')
return sendMsg(msg.chat_id_,msg.id_,'➖\n'..list_settings..'\n')
end
