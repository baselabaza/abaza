--[[
#    ▀█████████▄   ▄██████▄     ▄████████    ▄████████
#      ███    ███ ███    ███   ███    ███   ███    ███
#      ███    ███ ███    ███   ███    █▀    ███    █▀
#     ▄███▄▄▄██▀  ███    ███   ███          ███
#    ▀▀███▀▀▀██▄  ███    ███ ▀███████████ ▀███████████ ¦ Dev : @TH3BOSS
#      ███    ██▄ ███    ███          ███          ███ ¦ Dev : @OMMMM
#      ███    ███ ███    ███    ▄█    ███    ▄█    ███
#    ▄█████████▀   ▀██████▀   ▄████████▀   ▄████████▀  ¦ Source TH3BOSS BY @TH3BS
#---------------------------------------------------------------------
]]
local function iBoss(msg,MsgText)

if msg.forward_info_ then return false end


if msg.Director 
and (redis:get(boss..":Witting_changeamr:"..msg.chat_id_..msg.sender_user_id_) 
or redis:get(boss..":Witting_changeamr2:"..msg.chat_id_..msg.sender_user_id_) 
or redis:get(boss..":Witting_AmrDel:"..msg.chat_id_..msg.sender_user_id_) 
or redis:get(boss..":firstAmrOld:"..msg.chat_id_..msg.sender_user_id_)) and MsgText[1] ~= "الغاء" then 
return false end 

if msg.type ~= 'pv' then if MsgText[1] == "تفعيل" and not MsgText[2] then
return modadd(msg)  
end

if MsgText[1] == "تعطيل" and not MsgText[2] then
if not msg.SudoUser then return '🛠*¦* أنـت لـسـت الـمـطـور ⚙️'end
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg 
local NameUser   = Hyper_Link_Name(data)
if not redis:get(boss..'group:add'..msg.chat_id_) then return sendMsg(msg.chat_id_,msg.id_,'📬¦ المجموعه بالتأكيد ✓️ تم تعطيلها \n📮¦ بواسطه ⋙「 '..NameUser..' 」 \n') end  
rem_data_group(msg.chat_id_)
sendMsg(msg.chat_id_,msg.id_,'📛¦ تـم تـعـطـيـل الـمـجـمـوعـه ⚠️\n📮¦ بواسطه ⋙「 '..NameUser..' 」 \n')
end,{msg=msg})
end

end 


if msg.type ~= 'pv' and msg.GroupActive then 

if MsgText[1] == "ايدي" or MsgText[1]:lower() == "id" then
if not MsgText[2] and not msg.reply_id then
if redis:get(boss..'lock_id'..msg.chat_id_) then

GetUserID(msg.sender_user_id_,function(arg,data)

local msgs = redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 1
if data.username_ then UserNameID = "🎫¦ مـعرفك •⊱ @"..data.username_.." ⊰•\n" else UserNameID = "" end
if data.username_ then UserNameID1 = "@"..data.username_ else UserNameID1 = "لا يوجد" end
if data.last_name_ then Name = data.first_name_ .." "..data.last_name_ else Name = data.first_name_ end
local Namei = FlterName(data,20)
if data.status_.ID == "UserStatusEmpty" then
sendMsg(arg.chat_id_,data.id_,'📛¦ لا يمكنني عرض صورة بروفايلك لانك قمت بحظر البوت ... !\n\n')
else

GetPhotoUser(data.id_,function(arg,data)
local edited = (redis:get(boss..':edited:'..arg.chat_id_..':'..arg.sender_user_id_) or 0)

local KleshaID = '👤¦ أســمـك •⊱ { '..arg.Namei..' } ⊰•\n'
..'🎟¦ ايديــك •⊱ {'..arg.sender_user_id_..'} ⊰•\n'
..arg.UserNameID
..'📡¦ رتبتـــك •⊱ '..arg.TheRank..' ⊰•\n'
..'⭐️¦ تفاعـلك •⊱ '..Get_Ttl(arg.msgs)..'⊰•\n'
..'📋¦ رسائلك •⊱ {'..arg.msgs..'} ⊰•\n➖'
local Kleshaidinfo = redis:get(boss..":infoiduser_public:"..arg.chat_id_) or redis:get(boss..":infoiduser")  

if Kleshaidinfo then 
local points = redis:get(boss..':User_Points:'..arg.chat_id_..arg.sender_user_id_) or 0
KleshaID = Kleshaidinfo:gsub("{الاسم}",arg.Namei)
KleshaID = KleshaID:gsub("{الايدي}",arg.sender_user_id_)
KleshaID = KleshaID:gsub("{المعرف}",arg.UserNameID1)
KleshaID = KleshaID:gsub("{الرتبه}",arg.TheRank)
KleshaID = KleshaID:gsub("{التفاعل}",Get_Ttl(arg.msgs))
KleshaID = KleshaID:gsub("{الرسائل}",arg.msgs)
KleshaID = KleshaID:gsub("{التعديل}",edited)
KleshaID = KleshaID:gsub("{النقاط}",points)
KleshaID = KleshaID:gsub("{البوت}",redis:get(boss..':NameBot:'))
KleshaID = KleshaID:gsub("{المطور}",SUDO_USER)
end
if redis:get(boss.."idphoto"..msg.chat_id_) then
if data.photos_ and data.photos_[0] then 
sendPhoto(arg.chat_id_,arg.id_,data.photos_[0].sizes_[1].photo_.persistent_id_,KleshaID,dl_cb,nil)
else
sendMsg(arg.chat_id_,arg.id_,'🚸¦ لا يوجد صوره في بروفايلك ... !\n\n'..Flter_Markdown(KleshaID))
end
else
sendMsg(arg.chat_id_,arg.id_,Flter_Markdown(KleshaID))
end

end,{chat_id_=arg.chat_id_,id_=arg.id_,TheRank=arg.TheRank,sender_user_id_=data.id_,msgs=msgs,Namei=Namei,UserNameID=UserNameID,UserNameID1=UserNameID1})


end

end,{chat_id_=msg.chat_id_,id_=msg.id_,TheRank=msg.TheRank})

end
end




if msg.reply_id and not MsgText[2] then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data)
USERNAME = USERNAME:gsub([[\_]],"_")
USERCAR = utf8.len(USERNAME) 
SendMention(arg.ChatID,arg.UserID,arg.MsgID,"🧟‍♂¦ آضـغط على آلآيدي ليتم آلنسـخ\n\n "..USERNAME.." ~⪼ { "..arg.UserID.." }",37,USERCAR)
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
UserName = Flter_Markdown(arg.UserName)
sendMsg(arg.ChatID,arg.MsgID,"🧟‍♂*¦* آضـغط على آلآيدي ليتم آلنسـخ\n\n "..UserName.." ~⪼ ( `"..UserID.."` )")
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 
return false
end


if MsgText[1] == "تعديلاتي" or MsgText[1] == "سحكاتي" then    
local numvv = redis:get(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0
return "- عدد سحكاتك هو : "..numvv
end




if MsgText[1] == "تغير الرتبه" then
if not msg.SuperCreator  then return "📪¦ هذا الامر يخص {المنشئ الاساسي,المطور} فقط  \n" end
redis:setex(boss..":Witing_NewRtba:"..msg.chat_id_..msg.sender_user_id_,1000,true)
redis:del(boss..":Witting_NewRtba2:"..msg.chat_id_..msg.sender_user_id_)
return "- ارسل الرتبه المراد تغييرها :\n\n• مطور اساسي \n• مطور \n• منشئ اساسي \n• منشئ \n• مدير \n• ادمن \n• مميز \n"
end


if MsgText[1] == "مسح الرتبه" then
if not msg.SuperCreator  then return "📪¦ هذا الامر يخص {المنشئ الاساسي,المطور} فقط  \n" end
redis:setex(boss..":Witing_DelNewRtba:"..msg.chat_id_..msg.sender_user_id_,1000,true)
return "- ارسل الرتبه المراد حذفها :\n\n• مطور اساسي \n• مطور \n• منشئ اساسي \n• منشئ \n• مدير \n• ادمن \n• مميز \n"
end
if MsgText[1] == "مسح قائمه الرتب" then
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end
redis:del(boss..":RtbaNew1:"..msg.chat_id_)
redis:del(boss..":RtbaNew2:"..msg.chat_id_)
redis:del(boss..":RtbaNew3:"..msg.chat_id_)
redis:del(boss..":RtbaNew4:"..msg.chat_id_)
redis:del(boss..":RtbaNew5:"..msg.chat_id_)
redis:del(boss..":RtbaNew6:"..msg.chat_id_)
redis:del(boss..":RtbaNew7:"..msg.chat_id_)
return "- تم حذف القائمه بالكامل ."
end



if MsgText[1] == "قائمه الرتب" then
if not msg.SuperCreator  then return "📪¦ هذا الامر يخص {المنشئ الاساسي,المطور} فقط  \n" end

local Rtba1 = redis:get(boss..":RtbaNew1:"..msg.chat_id_) or " لايوجد "
local Rtba2 = redis:get(boss..":RtbaNew2:"..msg.chat_id_) or " لايوجد "
local Rtba3 = redis:get(boss..":RtbaNew3:"..msg.chat_id_) or " لايوجد "
local Rtba4 = redis:get(boss..":RtbaNew4:"..msg.chat_id_) or " لايوجد "
local Rtba5 = redis:get(boss..":RtbaNew5:"..msg.chat_id_) or " لايوجد "
local Rtba6 = redis:get(boss..":RtbaNew6:"..msg.chat_id_) or " لايوجد "
local Rtba7 = redis:get(boss..":RtbaNew7:"..msg.chat_id_) or " لايوجد "

return "| قائمه الرتب الجديده ...\n\n• مطور اساسي 》 ["..Rtba1.."]\n• منشئ اساسي  》 ["..Rtba3.."]\n• مطور  》 ["..Rtba2.."]\n• منشئ  》 ["..Rtba4.."]\n• مدير  》 ["..Rtba5.."]\n• ادمن  》 ["..Rtba6.."]\n• مميز  》 ["..Rtba7.."]\n"
end



if MsgText[1] == "المالك"  or MsgText[1] == "المنشئ" or  MsgText[1] == "المنشى" then
local url , res = https.request(ApiToken..'/getChatAdministrators?chat_id='..msg.chat_id_)
local get = JSON.decode(url)
for k,v in pairs(get.result) do
if v.status == "creator" and v.user.first_name ~= "" then
return sendMsg(msg.chat_id_,msg.id_,"المالك :\n["..v.user.first_name.."](t.me/"..(v.user.username or "TH3BS"))
end
end

message = ""
local monsha = redis:smembers(boss..':MONSHA_Group:'..msg.chat_id_)
if #monsha == 0 then 
sendMsg(msg.chat_id_,msg.id_,"📛| لا يوجد مالك !\n")
else
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v)
if info and info.username and info.username:match("@[%a%d_]+") then
GetUserName(info.username,function(arg,data)

mmmmm = arg.UserName:gsub("@","")
sendMsg(arg.ChatID,arg.MsgID,"المالك :\n["..data.title_.."](t.me/"..mmmmm..")")
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=info.username})
else
sendMsg(msg.chat_id_,msg.id_,'المالك :\n['..info.username..'](t.me/TH3BS)  \n')
end

break

end
end
end

if MsgText[1] == "المجموعه" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
GetFullChat(msg.chat_id_,function(arg,data)
local GroupName = (redis:get(boss..'group:name'..arg.ChatID) or '')
redis:set(boss..'linkGroup'..arg.ChatID,(data.invite_link_ or ""))
sendMsg(arg.ChatID,arg.MsgID,
"ـ  •⊱ { مـعـلومـات الـمـجـموعـه } ⊰•\n\n"
.."*👥¦* عدد الاعـضـاء •⊱ { *"..data.member_count_.."* } ⊰•"
.."\n*📛¦* عدد المحظـوريـن •⊱ { *"..data.kicked_count_.."* } ⊰•"
.."\n*🗣¦* عدد الادمـنـيـه •⊱ { *"..data.administrator_count_.."* } ⊰•"
.."\n*🔚¦* الايــدي •⊱ { `"..arg.ChatID.."` } ⊰•"
.."\n\nـ •⊱ {  ["..FlterName(GroupName).."]("..(data.invite_link_ or "")..")  } ⊰•\n"
)
end,{ChatID=msg.chat_id_,MsgID=msg.id_}) 
return false
end



if MsgText[1] == "تثبيت" and msg.reply_id then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
local GroupID = msg.chat_id_:gsub('-100','')
if not msg.Director and redis:get(boss..'lock_pin'..msg.chat_id_) then
return "لا يمكنك التثبيت الامر مقفول من قبل الاداره"
else
tdcli_function({
ID="PinChannelMessage",
channel_id_ = GroupID,
message_id_ = msg.reply_id,
disable_notification_ = 1},
function(arg,data)
if data.ID == "Ok" then
redis:set(boss..":MsgIDPin:"..arg.ChatID,arg.reply_id)
sendMsg(arg.ChatID,arg.MsgID,"🙋🏼‍♂️*¦* أهلا عزيزي "..arg.TheRankCmd.." \n📌*¦* تم تثبيت الرساله \n✓")
elseif data.ID == "Error" and data.code_ == 6 then
sendMsg(arg.ChatID,arg.MsgID,'📛*¦* عذرا لا يمكنني التثبيت .\n🎟*¦* لست مشرف او لا املك صلاحيه التثبيت \n ❕')    
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,reply_id=msg.reply_id,TheRankCmd=msg.TheRankCmd})
end
return false
end

if MsgText[1] == "الغاء التثبيت" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if not msg.Director and redis:get(boss..'lock_pin'..msg.chat_id_) then return "لا يمكنك الغاء التثبيت الامر مقفول من قبل الاداره" end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
sendMsg(arg.ChatID,arg.MsgID,"🙋🏼‍♂️*¦* أهلا عزيزي "..arg.TheRankCmd.."  \n🛑*¦* تم الغاء تثبيت الرساله \n✓")    
elseif data.ID == "Error" and data.code_ == 6 then
sendMsg(arg.ChatID,arg.MsgID,'📛*¦* عذرا لا يمكنني الغاء التثبيت .\n🎟*¦* لست مشرف او لا املك صلاحيه التثبيت \n ❕')    
elseif data.ID == "Error" and data.code_ == 400 then
sendMsg(arg.ChatID,arg.MsgID,'📛*¦* عذرا عزيزي '..arg.TheRankCmd..' .\n🎟*¦* لا توجد رساله مثبته لاقوم بازالتها \n ❕')    
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,TheRankCmd=msg.TheRankCmd})
return false
end

if MsgText[1] == "تقييد" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if not MsgText[2] and msg.reply_id then  -- By Replay 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then  
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكن تقييد البوت  \n📛") 
elseif UserID == 819385837 or UserID == 60809019  then  
return sendMsg(arg.ChatID,arg.MsgID,"⚜️*¦* لا يمكنك تقييد مطور السورس\n📛") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد المطور الاساسي\n🛠") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد المطور\n🛠") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد المنشئ\n🛠") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد المنشئ الاساسي\n🛠") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد المدير\n🛠") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد الادمن\n🛠") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد المميز\n🛠") 
end
GetChatMember(arg.ChatID,UserID,function(arg,data)
if data.status_.ID == "ChatMemberStatusMember" then
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم تقييده  من المجموعه") 
end,{ChatID=arg.ChatID,UserID=arg.UserID,MsgID=arg.MsgID})
Restrict(arg.ChatID,arg.UserID,1)
redis:set(boss..":TqeedUser:"..arg.ChatID..arg.UserID,true)
elseif data.status_.ID == "ChatMemberStatusLeft" then
sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنني تقيد العضو لانه مغادر المجموعة \n🛠") 
else
sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنني تقييد المشرف\n🛠") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then  -- By Username 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا هذا معرف قناة وليس حساب \n📛") end
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد البوت\n🛠") 
elseif  UserID == 819385837 or UserID == 60809019  then 
return sendMsg(arg.ChatID,arg.MsgID,"⚜️*¦* لا يمكنك تقييد مطور السورس\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد المطور الاساسي\n🛠") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد المطور\n🛠") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد المنشئ\n🛠") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد المنشئ الاساسي\n🛠") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد المدير\n🛠") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد الادمن\n🛠") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تقييد المميز\n🛠") 
end
GetChatMember(arg.ChatID,our_id,function(arg,data)
if data.status_.ID == "ChatMemberStatusEditor" then 
GetChatMember(arg.ChatID,arg.UserID,function(arg,data)
if data.status_.ID == "ChatMemberStatusMember" then 
Restrict(arg.ChatID,arg.UserID,1)  
redis:set(boss..":TqeedUser:"..arg.ChatID..arg.UserID,true)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..arg.NameUser.." 」 \n⛔️¦ تم تقييده  من المجموعه") 
else
sendMsg(arg.ChatID,arg.MsgID,'📛*¦* لا يمكنني تقييد العضو .\n🎟* لانه مشرف في المجموعه \n ❕')    
end
end,{ChatID=arg.ChatID,MsgID=arg.MsgID,UserName=arg.UserName,UserID=arg.UserID,NameUser=arg.NameUser})
else
sendMsg(arg.ChatID,arg.MsgID,'📛*¦* لا يمكنني تقييد العضو .\n🎟* لانني لست مشرف في المجموعه \n ❕')    
end
end,{ChatID=arg.ChatID,MsgID=arg.MsgID,UserName=arg.UserName,UserID=UserID,NameUser=NameUser})
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]}) 
elseif MsgText[2] and MsgText[2]:match('^%d+$') then  -- By UserID
UserID =  MsgText[2] 
if UserID == our_id then   
return sendMsg(msg.chat_id_,msg.id_,"👤*¦* لا يمكنك تقييد البوت\n🛠") 
elseif UserID == "819385837" or UserID == "60809019" then 
return sendMsg(msg.chat_id_,msg.id_,"⚜️*¦* لا يمكنك تقييد مطور السورس\n🛠") 
elseif UserID == tostring(SUDO_ID) then 
return sendMsg(msg.chat_id_,msg.id_,"👤*¦* لا يمكنك تقييد المطور الاساسي\n🛠") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(msg.chat_id_,msg.id_,"👤*¦* لا يمكنك تقييد المطور\n🛠") 
elseif redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
return sendMsg(msg.chat_id_,msg.id_,"👤*¦* لا يمكنك تقييد المنشئ\n🛠") 
elseif redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,UserID) then 
return sendMsg(msg.chat_id_,msg.id_,"👤*¦* لا يمكنك نقييد المنشئ الاساسي\n🛠") 
elseif redis:sismember(boss..'owners:'..msg.chat_id_,UserID) then 
return sendMsg(msg.chat_id_,msg.id_,"👤*¦* لا يمكنك تقييد المدير\n🛠") 
elseif redis:sismember(boss..'admins:'..msg.chat_id_,UserID) then 
return sendMsg(msg.chat_id_,msg.id_,"👤*¦* لا يمكنك تقييد الادمن\n🛠") 
end
GetUserID(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد حساب بهذا الايدي  \n❕") end 
if data.username_ then 
UserName = '@'..data.username_
else 
UserName = FlterName(data.first_name_..' '..(data.last_name_ or ""),20) 
end
NameUser = Hyper_Link_Name(data)
GetChatMember(arg.ChatID,our_id,function(arg,data)
if data.status_.ID ~= "ChatMemberStatusEditor" then 
return sendMsg(arg.ChatID,arg.MsgID,'📛*¦* لا يمكنني تقييد العضو .\n🎟* لانني لست مشرف في المجموعه \n ❕')    
end
Restrict(arg.ChatID,arg.UserID,1)
redis:set(boss..":TqeedUser:"..arg.ChatID..arg.UserID,true)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم تقييده  من المجموعه") 
end,{ChatID=arg.ChatID,MsgID=arg.MsgID,UserName=UserName,UserID=data.id_})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end 
return false
end

if MsgText[1] == "فك التقييد" or MsgText[1] == "فك تقييد" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تنفيذ الامر بالرد ع رسالة البوت \n📛") end
Restrict(arg.ChatID,UserID,2)
redis:del(boss..":TqeedUser:"..arg.ChatID..UserID)
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم فك تقييده  من المجموعه") 
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_}) 


elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then  -- BY Username
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا هذا معرف قناة وليس حساب \n📛") end
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
GetChatMember(arg.ChatID,our_id,function(arg,data)
if data.status_.ID ~= "ChatMemberStatusEditor" then 
return sendMsg(arg.ChatID,arg.MsgID,'📛*¦* لا يمكنني تقييد العضو .\n🎟* لانني لست مشرف في المجموعه \n ❕')    
end
Restrict(arg.ChatID,arg.UserID,2)  
redis:del(boss..":TqeedUser:"..arg.ChatID..arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم فك تقييده  من المجموعه") 
end,{ChatID=arg.ChatID,MsgID=arg.MsgID,UserID=UserID,NameUser=NameUser})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد حساب بهذا الايدي  \n❕") end 
NameUser = Hyper_Link_Name(data)
if data.id_ == our_id then  
return sendMsg(ChatID,MsgID,"📛*¦* البوت ليس مقييد \n❗️ ") 
end
GetChatMember(arg.ChatID,our_id,function(arg,data)
if data.status_.ID ~= "ChatMemberStatusEditor" then 
return sendMsg(arg.ChatID,arg.MsgID,'📛*¦* لا يمكنني قك تقييد العضو .\n🎟* لانني لست مشرف في المجموعه \n ❕')    
end
redis:del(boss..":TqeedUser:"..arg.ChatID..arg.UserID)
Restrict(arg.ChatID,arg.UserID,2)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم فك تقييده  من المجموعه") 
end,{ChatID=arg.ChatID,MsgID=arg.MsgID,UserID=data.id_,NameUser=NameUser})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end 
return false
end

if MsgText[1] == "رفع مميز" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تنفيذ الامر بالرد ع رسالة البوت \n📛") end
GetUserID(UserID,function(arg,data)
ReUsername = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..'whitelist:'..arg.ChatID,arg.UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه مميز  في المجموعه") 
else
redis:hset(boss..'username:'..arg.UserID,'username',ReUsername)
redis:sadd(boss..'whitelist:'..arg.ChatID,arg.UserID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه مميز  في المجموعه") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})


elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then  --BY USERNAME
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
if data.type_.user_ and data.type_.user_.type_.ID == "UserTypeBot" then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لا يمكنني رفع حساب بوت \n❕") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if UserID == our_id then
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا لا يمكنني رفع البوت \n📛") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا هذا معرف قناة وليس حساب \n📛") 
end
UserName = arg.UserName
if redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه مميز  في المجموعه") 
end
redis:hset(boss..'username:'..UserID,'username',UserName)
redis:sadd(boss..'whitelist:'..arg.ChatID,UserID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه مميز  في المجموعه") 
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="setwhitelist"})
end 
return false
end

if MsgText[1] == "تنزيل مميز" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تنفيذ الامر بالرد ع رسالة البوت \n📛") end
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data):gsub([[\_]],"_")
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..'whitelist:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله مميز  في المجموعه") 
else
redis:srem(boss..'whitelist:'..arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله مميز  في المجموعه") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})


elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
UserName = Flter_Markdown(arg.UserName)
if not redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله مميز  في المجموعه")
else
redis:srem(boss..'whitelist:'..arg.ChatID,UserID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله مميز  في المجموعه") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="remwhitelist"})
end 
return false
end

if (MsgText[1] == "رفع المدير"  or MsgText[1] == "رفع مدير" ) then
if not msg.Creator then return "📪¦ هذا الامر يخص {المطور,المنشئ} فقط  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تنفيذ الامر بالرد ع رسالة البوت \n📛") end
GetUserID(UserID,function(arg,data)
ReUsername = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)

if redis:sismember(boss..'owners:'..arg.ChatID,arg.UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه مدير  في المجموعه")
else
redis:hset(boss..'username:'..arg.UserID,'username',ReUsername)
redis:sadd(boss..'owners:'..arg.ChatID,UserID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه مدير  في المجموعه") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
if data.type_.user_ and data.type_.user_.type_.ID == "UserTypeBot" then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لا يمكنني رفع حساب بوت \n❕") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if UserID == our_id then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا لا يمكنني رفع البوت \n📛") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا هذا معرف قناة وليس حساب \n📛") 
end
UserName = arg.UserName
if redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه مدير  في المجموعه")
else
redis:hset(boss..'username:'..UserID, 'username',UserName)
redis:sadd(boss..'owners:'..arg.ChatID,UserID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه مدير  في المجموعه")
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="setowner"})
end 
return false
end

if (MsgText[1] == "تنزيل المدير" or MsgText[1] == "تنزيل مدير" ) then
if not msg.Creator then return "📪¦ هذا الامر يخص {المطور,المنشئ} فقط  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تنفيذ الامر بالرد ع رسالة البوت \n📛") end
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..'owners:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله مدير  في المجموعه") 
else
redis:srem(boss..'owners:'..arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله مدير  في المجموعه") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})


elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
UserName = Flter_Markdown(arg.UserName)
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله مدير  في المجموعه")  
else
redis:srem(boss..'owners:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله مدير  في المجموعه") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="remowner"}) 
end 
return false
end

if (MsgText[1] == "رفع منشى" or MsgText[1] == "رفع منشئ") then
if not msg.SuperCreator then return "📪¦ هذا الامر يخص {المطور,المطور الاساسي} فقط  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تنفيذ الامر بالرد ع رسالة البوت \n📛") end
GetUserID(UserID,function(arg,data)
ReUsername = ResolveUserName(data):gsub([[\_]],"_")
NameUser = Hyper_Link_Name(data)

if redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,arg.UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه منشئ  في المجموعه") 
else
redis:hset(boss..'username:'..arg.UserID,'username',ReUsername)
redis:sadd(boss..':MONSHA_BOT:'..arg.ChatID,arg.UserID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه منشئ  في المجموعه") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})


elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
if data.type_.user_ and data.type_.user_.type_.ID == "UserTypeBot" then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لا يمكنني رفع حساب بوت \n❕") end 
NameUser = Hyper_Link_Name(data)
local UserID = data.id_
if UserID == our_id then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا لا يمكنني رفع البوت \n📛") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا هذا معرف قناة وليس حساب \n📛") 
end
UserName = arg.UserName
if redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه منشئ  في المجموعه") 
else
redis:hset(boss..'username:'..UserID,'username',UserName)
redis:sadd(boss..':MONSHA_BOT:'..arg.ChatID,UserID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه منشئ  في المجموعه") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="setmnsha"})
end  
return false
end

if (MsgText[1] == "تنزيل منشى" or MsgText[1] == "تنزيل منشئ" ) then
if not msg.SuperCreator then return "📪¦ هذا الامر يخص {المطور,المطور الاساسي} فقط  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
local MsgID = arg.MsgID
local ChatID = arg.ChatID
if not data.sender_user_id_ then return sendMsg(ChatID,MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تنفيذ الامر بالرد ع رسالة البوت \n📛") end
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data):gsub([[\_]],"_")
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,arg.UserID) then
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله منشئ  في المجموعه") 
else
redis:srem(boss..':MONSHA_BOT:'..arg.ChatID,arg.UserID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله منشئ  في المجموعه") 
end
end,{ChatID=ChatID,UserID=UserID,MsgID=MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
UserName = Flter_Markdown(arg.UserName)
if not redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله منشئ  في المجموعه") 
else
redis:srem(boss..':MONSHA_BOT:'..arg.ChatID,UserID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله منشئ  في المجموعه") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="remmnsha"})
end 
return false
end

if MsgText[1] == "رفع ادمن" then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تنفيذ الامر بالرد ع رسالة البوت \n📛") end
GetUserID(UserID,function(arg,data)
ReUsername = ResolveUserName(data)
NameUser   = Hyper_Link_Name(data)
if redis:sismember(boss..'admins:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه ادمن  في المجموعه") 
else
redis:hset(boss..'username:'..arg.UserID,'username',ReUsername)
redis:sadd(boss..'admins:'..arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه ادمن  في المجموعه") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})



elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
if data.type_.user_ and data.type_.user_.type_.ID == "UserTypeBot" then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لا يمكنني رفع حساب بوت \n❕") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if UserID == our_id then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا لا يمكنني رفع البوت \n📛") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا هذا معرف قناة وليس حساب \n📛") 
end
UserName = arg.UserName
if redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه ادمن  في المجموعه") 
else
redis:hset(boss..'username:'..UserID,'username',UserName)
redis:sadd(boss..'admins:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه ادمن  في المجموعه") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="promote"})
end 
return false
end

if MsgText[1] == "تنزيل ادمن" then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تنفيذ الامر بالرد ع رسالة البوت \n📛") end
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data):gsub([[\_]],"_")
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..'admins:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله ادمن  في المجموعه") 
else
redis:srem(boss..'admins:'..arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله ادمن  في المجموعه") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
NameUser = Hyper_Link_Name(data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
UserName = Flter_Markdown(arg.UserName)
if not redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله ادمن  في المجموعه") 
else
redis:srem(boss..'admins:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله ادمن  في المجموعه") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="demote"})
end 
return false
end

if MsgText[1] == "التفاعل" then
if not MsgText[2] and msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
local USERNAME = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if data.username_ then UserNameID = "@"..data.username_ else UserNameID = "لا يوجد" end  
local maseegs = redis:get(boss..'msgs:'..arg.UserID..':'..arg.ChatID) or 1
local edited = redis:get(boss..':edited:'..arg.ChatID..':'..arg.UserID) or 0
local content = redis:get(boss..':adduser:'..arg.ChatID..':'..arg.UserID) or 0
sendMsg(arg.ChatID,arg.MsgID,"🎫┇ايديه » `"..arg.UserID.."`\n📨┇رسائله » "..maseegs.."\n🎟┇معرفه » ["..UserNameID.."]\n📈┇تفاعله » "..Get_Ttl(maseegs).."\n📮┇رتبته » "..Getrtba(arg.UserID,arg.ChatID).."\n⚡️┇تعديلاته » "..edited.."\n☎️┇جهاته » "..content.."") 
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
local USERNAME = arg.user
NameUser = Hyper_Link_Name(data)
local maseegs = redis:get(boss..'msgs:'..UserID..':'..arg.ChatID) or 1
local edited = redis:get(boss..':edited:'..arg.ChatID..':'..UserID) or 0
local content = redis:get(boss..':adduser:'..arg.ChatID..':'..UserID) or 0
sendMsg(arg.ChatID,arg.MsgID,"🎫┇ايديه » `"..UserID.."`\n📨┇رسائله » "..maseegs.."\n🎟┇معرفه » ["..USERNAME.."]\n📈┇تفاعله » "..Get_Ttl(maseegs).."\n📮┇رتبته » "..Getrtba(UserID,arg.ChatID).."\n⚡️┇تعديلاته » "..edited.."\n☎️┇جهاته » "..content.."") 
end,{ChatID=msg.chat_id_,MsgID=msg.id_,user=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="tfa3l"}) 
end
return false
end

if MsgText[1] == "كشف" then
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data)
USERCAR = utf8.len(USERNAME)
local namei = data.first_name_..' '..(data.last_name_ or "")
if data.username_ then useri = '@'..data.username_ else useri = " لا يوجد " end
SendMention(arg.ChatID,arg.UserID,arg.MsgID,'🤵🏼¦ الاسم » '..namei..'\n'
..'🎫¦ الايدي » {'..arg.UserID..'} \n'
..'🎟¦ المعرف » '..useri..'\n'
..'📮¦ الرتبه » '..Getrtba(arg.UserID,arg.ChatID)..'\n'
..'🕵🏻️‍♀️¦ نوع الكشف » بالرد\n➖',13,utf8.len(namei))
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
UserName = Flter_Markdown(arg.UserName)
sendMsg(arg.ChatID,arg.MsgID,'ـ🤵🏼*¦* الاسم » '..FlterName(data.title_,30)..'\n'..'🎫*¦* الايدي » {`'..UserID..'`} \n'..'🎟*¦* المعرف » '..UserName..'\n📮¦ الرتبه » '..Getrtba(UserID,arg.ChatID)..'\n🕵🏻️‍♀️*¦* نوع الكشف » بالمعرف\n'..'➖')
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="whois"}) 
end
return false
end


if MsgText[1] == "رفع القيود" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تنفيذ الامر بالرد ع رسالة البوت \n📛") end
GetUserID(UserID,function(arg,data)
if msg.SudoBase then redis:srem(boss..'gban_users',arg.UserID)  end 
Restrict(arg.ChatID,arg.UserID,2)
redis:srem(boss..'banned:'..arg.ChatID,arg.UserID)
StatusLeft(arg.ChatID,arg.UserID)
redis:srem(boss..'is_silent_users:'..arg.ChatID,arg.UserID)
NameUser = Hyper_Link_Name(data)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم رفع القيود ان وجد  \n✓") 
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك تنفيذ الامر بالرد ع رسالة البوت \n📛") end
if msg.SudoBase then redis:srem(boss..'gban_users',UserID)  end 
Restrict(arg.ChatID,UserID,2)
redis:srem(boss..'banned:'..arg.ChatID,UserID)
StatusLeft(arg.ChatID,UserID)
redis:srem(boss..'is_silent_users:'..arg.ChatID,UserID)
NameUser = Hyper_Link_Name(data)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم رفع القيود ان وجد  \n✓") 
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
if msg.SudoBase then redis:srem(boss..'gban_users',MsgText[2])  end 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="rfaqud"}) 
end 
return false
end

if MsgText[1] == "طرد" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if not msg.Creator and not redis:get(boss.."lock_KickBan"..msg.chat_id_) then return "📛*¦* الامر معطل من قبل اداره المجموعة  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد البوت\n🛠") 
elseif UserID == 819385837 or UserID == 60809019 then 
return sendMsg(arg.ChatID,arg.MsgID,"⚜️*¦* لا يمكنك طرد مطور السورس\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد المطور الاساسي\n🛠") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد المطور\n🛠") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد المنشئ\n🛠") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد المنشئ الاساسي\n🛠") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد المدير\n🛠") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد الادمن\n🛠") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد المميز\n🛠") 
end
kick_user(UserID,arg.ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(arg.ChatID,arg.MsgID,'📛*¦* لا يمكنني حظر العضو .\n🎟*¦* لانه مشرف في المجموعه \n ❕')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(arg.ChatID,arg.MsgID,'📛*¦* لا يمكنني حظر العضو .\n🎟*¦* ليس لدي صلاحيه الحظر او لست مشرف\n ❕')    
end
GetUserID(arg.UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم طرده  من المجموعه") 
StatusLeft(arg.ChatID,arg.UserID)
end,{ChatID=arg.ChatID,UserID=arg.UserID,MsgID=arg.MsgID})
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
UserName = arg.UserName
NameUser = Hyper_Link_Name(data)
if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد البوت\n🛠") 
elseif UserID == 819385837 or UserID == 60809019 then 
return sendMsg(arg.ChatID,arg.MsgID,"⚜️*¦* لا يمكنك طرد مطور السورس\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد المطور الاساسي\n🛠") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد المطور\n🛠") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد المنشئ\n🛠") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد المنشئ الاساسي\n🛠") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد المدير\n🛠") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد الادمن\n🛠") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك طرد المميز\n🛠") 
end
kick_user(UserID,arg.ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(arg.ChatID,arg.MsgID,'📛*¦* لا يمكنني طرد العضو .\n🎟*¦* لانه مشرف في المجموعه \n ❕')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(arg.ChatID,arg.MsgID,'📛*¦* لا يمكنني طرد العضو .\n🎟*¦* ليس لدي صلاحيه الحظر او لست مشرف\n ❕')    
end
StatusLeft(arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ العضو 「 "..arg.NameUser.." 」 \n⛔️¦ تم طرده  من المجموعه") 
end,{ChatID=arg.ChatID,MsgID=arg.MsgID,UserName=UserName,UserID=UserID,NameUser=NameUser})
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="kick"}) 
end 
return false
end


if MsgText[1] == "حظر" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if not msg.Creator and not redis:get(boss.."lock_KickBan"..msg.chat_id_) then return "📛*¦* الامر معطل من قبل اداره المجموعة  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_

if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المطور الاساسي\n🛠") 
elseif UserID == 819385837 or UserID == 60809019 then 
return sendMsg(arg.ChatID,arg.MsgID,"⚜️*¦* لا يمكنك حظر مطور السورس\n🛠") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المطور\n🛠") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المنشئ\n🛠") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المنشئ الاساسي\n🛠") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المدير\n🛠") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر الادمن\n🛠") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المميز\n🛠") 
end

kick_user(UserID,arg.ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(arg.ChatID,arg.MsgID,'📛*¦* لا يمكنني حظر العضو .\n🎟*¦* لانه مشرف في المجموعه \n ❕')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(arg.ChatID,arg.MsgID,'📛*¦* لا يمكنني حظر العضو .\n🎟*¦* ليس لدي صلاحيه الحظر او لست مشرف\n ❕')    
else
GetUserID(arg.UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
USERNAME = ResolveUserName(data)
if redis:sismember(boss..'banned:'..arg.ChatID,arg.UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد حظره  من المجموعه") 
end

redis:hset(boss..'username:'..arg.UserID,'username',USERNAME)
redis:sadd(boss..'banned:'..arg.ChatID,arg.UserID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم حظره  من المجموعه") 
end,{ChatID=arg.ChatID,UserID=arg.UserID,MsgID=arg.MsgID})
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})



elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)

if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المطور الاساسي\n🛠") 
elseif UserID == 819385837 or UserID == 60809019 then 
return sendMsg(arg.ChatID,arg.MsgID,"⚜️*¦* لا يمكنك حظر مطور السورس\n🛠") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المطور\n🛠") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المنشئ\n🛠") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المنشئ الاساسي\n🛠") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المدير\n🛠") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر الادمن\n🛠") 
end
if data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا هذا معرف قناة وليس حساب \n📛") 
end
if redis:sismember(boss..'banned:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد حظره  من المجموعه") 
end
kick_user(UserID,arg.ChatID,function(arg,data)
if data.ID == "Error" and data.code_ == 400 then
return sendMsg(arg.ChatID,arg.MsgID,'📛*¦* لا يمكنني حظر العضو .\n🎟*¦* لانه مشرف في المجموعه \n ❕')    
elseif data.ID == "Error" and data.code_ == 3 then
return sendMsg(arg.ChatID,arg.MsgID,'📛*¦* لا يمكنني حظر العضو .\n🎟*¦* ليس لدي صلاحيه الحظر او لست مشرف\n ❕')    
end
redis:hset(boss..'username:'..arg.UserID, 'username',arg.UserName)
redis:sadd(boss..'banned:'..arg.ChatID,arg.UserID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم حظره  من المجموعه") 
end,{ChatID=arg.ChatID,MsgID=arg.MsgID,UserName=UserName,UserID=UserID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="ban"}) 
end 
return false
end

--==============================================================================================================================
--==============================================================================================================================
--==============================================================================================================================


if MsgText[1] == "رفع مشرف" then
if not msg.SuperCreator then return "📪¦ هذا الامر يخص {منشئ اساسي,المطور} فقط  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_

GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
USERNAME = ResolveUserName(data)
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا هذا معرف قناة وليس حساب \n📛") end
redis:hset(boss..'username:'..arg.UserID,'username',USERNAME)
redis:setex(boss..":uploadingsomeon:"..msg.chat_id_..msg.sender_user_id_,500,NameUser)
redis:setex(boss..":uploadingsomeon2:"..msg.chat_id_..msg.sender_user_id_,500,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"📇¦  » حسننا الان ارسل صلاحيات المشرف :\n\n¦1- صلاحيه تغيير المعلومات\n¦2- صلاحيه حذف الرسائل\n¦3- صلاحيه دعوه مستخدمين\n¦4- صلاحيه حظر وتقيد المستخدمين \n¦5- صلاحيه تثبيت الرسائل \n¦6- صلاحيه رفع مشرفين اخرين\n\n¦[*]- لرفع كل الصلاحيات ما عدا رفع المشرفين \n¦[**] - لرفع كل الصلاحيات مع رفع المشرفين \n\n🚸¦ يمكنك اختيار الارقام معا وتعيين الكنيه للمشرف في ان واحد مثلا : \n\n¦ 136 الزعيم\n📬") 

end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})



elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا هذا معرف قناة وليس حساب \n📛") end
redis:hset(boss..'username:'..UserID,'username',arg.USERNAME)
redis:setex(boss..":uploadingsomeon:"..arg.ChatID..msg.sender_user_id_,500,NameUser)
redis:setex(boss..":uploadingsomeon2:"..arg.ChatID..msg.sender_user_id_,500,UserID)
sendMsg(arg.ChatID,arg.MsgID,"📇¦  » حسننا الان ارسل صلاحيات المشرف :\n\n¦1- صلاحيه تغيير المعلومات\n¦2- صلاحيه حذف الرسائل\n¦3- صلاحيه دعوه مستخدمين\n¦4- صلاحيه حظر وتقيد المستخدمين \n¦5- صلاحيه تثبيت الرسائل \n¦6- صلاحيه رفع مشرفين اخرين\n\n¦[*]- لرفع كل الصلاحيات ما عدا رفع المشرفين \n¦[**] - لرفع كل الصلاحيات مع رفع المشرفين \n\n🚸¦ يمكنك اختيار الارقام معا وتعيين الكنيه للمشرف في ان واحد مثلا : \n\n¦ 136 الزعيم\n📬") 
end,{ChatID=msg.chat_id_,MsgID=msg.id_,USERNAME=MsgText[2]})

elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="upMshrf"}) 
end 
return false
end

if MsgText[1] == "تنزيل مشرف" then
if not msg.SuperCreator then return "📪¦ هذا الامر يخص {منشئ اساسي,المطور} فقط  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكن تنفيذ الامر للبوت\n📛") end
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا هذا معرف قناة وليس حساب \n📛") end
ResAdmin = UploadAdmin(arg.ChatID,arg.UserID,"")  
if ResAdmin == '{"ok":false,"error_code":400,"description":"Bad Request: CHAT_ADMIN_REQUIRED"}' then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦*لا يمكنني تنزيله لانه مرفوع من قبل منشئ اخر \n📛")  end
redis:srem(boss..':MONSHA_BOT:'..arg.ChatID,arg.UserID)
redis:srem(boss..'owners:'..arg.ChatID,arg.UserID)
redis:srem(boss..'admins:'..arg.ChatID,arg.UserID)
redis:srem(boss..'whitelist:'..arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله من مشرفين المجموعه") 
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكن تنفيذ الامر للبوت\n📛") end
NameUser = Hyper_Link_Name(data)
if data.type_.ID == "ChannelChatInfo" then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا هذا معرف قناة وليس حساب \n📛") end
local ResAdmin = UploadAdmin(arg.ChatID,UserID,"")  
if ResAdmin == '{"ok":false,"error_code":400,"description":"Bad Request: CHAT_ADMIN_REQUIRED"}' then return sendMsg(arg.ChatID,arg.MsgID,"👤*¦*لا يمكنني تنزيله لانه مرفوع من قبل منشئ اخر \n📛")  end
redis:srem(boss..':MONSHA_BOT:'..arg.ChatID,UserID)
redis:srem(boss..'owners:'..arg.ChatID,UserID)
redis:srem(boss..'admins:'..arg.ChatID,UserID)
redis:srem(boss..'whitelist:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله من مشرفين المجموعه") 
end,{ChatID=msg.chat_id_,MsgID=msg.id_})

elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="DwonMshrf"}) 
end 
return false
end
--==============================================================================================================================
--==============================================================================================================================
--==============================================================================================================================

if (MsgText[1] == "الغاء الحظر" or MsgText[1] == "الغاء حظر") and msg.Admin then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لا يمكنك استخدام الامر بالرد على البوت \n❕") end
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)

GetChatMember(arg.ChatID,arg.UserID,function(arg,data)
if (data.status_.ID == "ChatMemberStatusKicked" or redis:sismember(boss..'banned:'..arg.ChatID,arg.UserID)) then
StatusLeft(arg.ChatID,arg.UserID,function(arg,data) 
if data.message_ and data.message_ == "CHAT_ADMIN_REQUIRED" then 
sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا البوت ليس لديه صلاحيات الحظر \n❕")
else
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد الغاء حظره  من المجموعه") 
end
end,{ChatID=arg.ChatID,UserID=arg.UserID,MsgID=arg.MsgID,USERNAME=arg.USERNAME})
redis:srem(boss..'banned:'..arg.ChatID,arg.UserID)
else
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم الغاء حظره  من المجموعه") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID,USERNAME=USERNAME})
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
if data.id_ == our_id then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لا يمكنك تنفيذ الامر مع البوت \n❕") end 
local UserID = data.id_
UserName = arg.UserName
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..'banned:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد الغاء حظره  من المجموعه") 
else
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم الغاء حظره  من المجموعه") 
end
redis:srem(boss..'banned:'..arg.ChatID,UserID)
StatusLeft(arg.ChatID,UserID)
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="uban"}) 
end 
return false
end


if MsgText[1] == "كتم" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم المطور الاساسي\n🛠") 
elseif UserID == 819385837 or UserID == 60809019 then 
return sendMsg(arg.ChatID,arg.MsgID,"⚜️*¦* لا يمكنك كتم مطور السورس\n🛠") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم المطور\n🛠") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم المنشئ\n🛠") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم المنشئ الاساسي\n🛠") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم المدير\n🛠") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم الادمن\n🛠") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم المميز\n🛠") 
end
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..'is_silent_users:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد كتمه  من المجموعه") 
else
redis:hset(boss..'username:'..arg.UserID,'username',USERNAME)
redis:sadd(boss..'is_silent_users:'..arg.ChatID,arg.UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم كتمه  من المجموعه") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})


elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
UserName = arg.UserName
NameUser = Hyper_Link_Name(data)
if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم البوت\n🛠") 
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم المطور الاساسي\n🛠") 
elseif UserID == 819385837 or UserID == 60809019 then 
return sendMsg(arg.ChatID,arg.MsgID,"⚜️*¦* لا يمكنك كتم مطور السورس\n🛠") 
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم المطور\n🛠") 
elseif redis:sismember(boss..':MONSHA_BOT:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم المنشئ\n🛠") 
elseif redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم المنشئ الاساسي\n🛠") 
elseif redis:sismember(boss..'owners:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم المدير\n🛠") 
elseif redis:sismember(boss..'admins:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم الادمن\n🛠") 
elseif  redis:sismember(boss..'whitelist:'..arg.ChatID,UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك كتم المميز\n🛠") 
end
if redis:sismember(boss..'is_silent_users:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد كتمه  من المجموعه") 
else
redis:hset(boss..'username:'..UserID,'username',UserName)
redis:sadd(boss..'is_silent_users:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم كتمه  من المجموعه") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="ktm"}) 
end
return false
end


if MsgText[1] == "الغاء الكتم" or MsgText[1] == "الغاء كتم" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..'is_silent_users:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد الغاء كتمه  من المجموعه") 
else
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم الغاء كتمه  من المجموعه") 
redis:srem(boss..'is_silent_users:'..arg.ChatID,arg.UserID)
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
elseif MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
UserName = arg.UserName
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..'is_silent_users:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد الغاء كتمه  من المجموعه") 
else
redis:srem(boss..'is_silent_users:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم الغاء كتمه  من المجموعه") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
elseif MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="unktm"}) 
end 
return false
end


--{ Commands For locks }

if MsgText[1] == "قفل الكل"		 then return lock_All(msg) end
if MsgText[1] == "قفل الوسائط" 	 then return lock_Media(msg) end
if MsgText[1] == "قفل الصور بالتقييد" 	 then return tqeed_photo(msg) end
if MsgText[1] == "قفل الفيديو بالتقييد"  then return tqeed_video(msg) end
if MsgText[1] == "قفل المتحركه بالتقييد" then return tqeed_gif(msg) end
if MsgText[1] == "قفل التوجيه بالتقييد"  then return tqeed_fwd(msg) end
if MsgText[1] == "قفل الروابط بالتقييد"  then return tqeed_link(msg) end
if MsgText[1] == "قفل الدردشه"    	     then return mute_text(msg) end
if MsgText[1] == "قفل المتحركه" 		 then return mute_gif(msg) end
if MsgText[1] == "قفل الصور" 			 then return mute_photo(msg) end
if MsgText[1] == "قفل الفيديو"			 then return mute_video(msg) end
if MsgText[1] == "قفل البصمات" 		then return mute_voice(msg) 	end
if MsgText[1] == "قفل الصوت" 		then return mute_audio(msg) 	end
if MsgText[1] == "قفل الملصقات" 	then return mute_sticker(msg) end
if MsgText[1] == "قفل الجهات" 		then return mute_contact(msg) end
if MsgText[1] == "قفل التوجيه" 		then return mute_forward(msg) end
if MsgText[1] == "قفل الموقع"	 	then return mute_location(msg) end
if MsgText[1] == "قفل الملفات" 		then return mute_document(msg) end
if MsgText[1] == "قفل الاشعارات" 	then return mute_tgservice(msg) end
if MsgText[1] == "قفل الانلاين" 		then return mute_inline(msg) end
if MsgText[1] == "قفل الالعاب" 		then return mute_game(msg) end
if MsgText[1] == "قفل الكيبورد" 	then return mute_keyboard(msg) end
if MsgText[1] == "قفل الروابط" 		then return lock_link(msg) end
if MsgText[1] == "قفل التاك" 		then return lock_tag(msg) end
if MsgText[1] == "قفل المعرفات" 	then return lock_username(msg) end
if MsgText[1] == "قفل التعديل" 		then return lock_edit(msg) end
if MsgText[1] == "قفل الكلايش" 		then return lock_spam(msg) end
if MsgText[1] == "قفل التكرار" 		then return lock_flood(msg) end
if MsgText[1] == "قفل البوتات" 		then return lock_bots(msg) end
if MsgText[1] == "قفل البوتات بالطرد" 	then return lock_bots_by_kick(msg) end
if MsgText[1] == "قفل الماركدوان" 	then return lock_markdown(msg) end
if MsgText[1] == "قفل الويب" 		then return lock_webpage(msg) end 
if MsgText[1] == "قفل التثبيت" 		then return lock_pin(msg) end 
if MsgText[1] == "قفل الاضافه" 		then return lock_Add(msg) end 
if MsgText[1] == "قفل الانكليزيه" 		then return lock_lang(msg) end 
if MsgText[1] == "قفل الفارسيه" 		then return lock_pharsi(msg) end 
if MsgText[1] == "قفل الفشار" 		then return lock_mmno3(msg) end 


--{ Commands For Unlocks }
if MsgText[1] == "فتح الكل" then return Unlock_All(msg) end
if MsgText[1] == "فتح الوسائط" then return Unlock_Media(msg) end
if MsgText[1] == "فتح الصور بالتقييد" 		then return fktqeed_photo(msg) 	end
if MsgText[1] == "فتح الفيديو بالتقييد" 	then return fktqeed_video(msg) 	end
if MsgText[1] == "فتح المتحركه بالتقييد" 	then return fktqeed_gif(msg) 	end
if MsgText[1] == "فتح التوجيه بالتقييد" 	then return fktqeed_fwd(msg) 	end
if MsgText[1] == "فتح الروابط بالتقييد" 	then return fktqeed_link(msg) 	end
if MsgText[1] == "فتح المتحركه" 	then return unmute_gif(msg) 	end
if MsgText[1] == "فتح الدردشه" 		then return unmute_text(msg) 	end
if MsgText[1] == "فتح الصور" 		then return unmute_photo(msg) 	end
if MsgText[1] == "فتح الفيديو" 		then return unmute_video(msg) 	end
if MsgText[1] == "فتح البصمات" 		then return unmute_voice(msg) 	end
if MsgText[1] == "فتح الصوت" 		then return unmute_audio(msg) 	end
if MsgText[1] == "فتح الملصقات" 	then return unmute_sticker(msg) end
if MsgText[1] == "فتح الجهات" 		then return unmute_contact(msg) end
if MsgText[1] == "فتح التوجيه" 		then return unmute_forward(msg) end
if MsgText[1] == "فتح الموقع" 		then return unmute_location(msg) end
if MsgText[1] == "فتح الملفات" 		then return unmute_document(msg) end
if MsgText[1] == "فتح الاشعارات" 	then return unmute_tgservice(msg) end
if MsgText[1] == "فتح الانلاين" 		then return unmute_inline(msg) 	end
if MsgText[1] == "فتح الالعاب" 		then return unmute_game(msg) 	end
if MsgText[1] == "فتح الكيبورد" 	then return unmute_keyboard(msg) end
if MsgText[1] == "فتح الروابط" 		then return unlock_link(msg) 	end
if MsgText[1] == "فتح التاك" 		then return unlock_tag(msg) 	end
if MsgText[1] == "فتح المعرفات" 	then return unlock_username(msg) end
if MsgText[1] == "فتح التعديل" 		then return unlock_edit(msg) 	end
if MsgText[1] == "فتح الكلايش" 		then return unlock_spam(msg) 	end
if MsgText[1] == "فتح التكرار" 		then return unlock_flood(msg) 	end
if MsgText[1] == "فتح البوتات" 		then return unlock_bots(msg) 	end
if MsgText[1] == "فتح البوتات بالطرد" 	then return unlock_bots_by_kick(msg) end
if MsgText[1] == "فتح الماركدوان" 	then return unlock_markdown(msg) end
if MsgText[1] == "فتح الويب" 		then return unlock_webpage(msg) 	end
if MsgText[1] == "فتح التثبيت" 		then return unlock_pin(msg) end 
if MsgText[1] == "فتح الاضافه" 		then return unlock_Add(msg) end 
if MsgText[1] == "فتح الانكليزيه" 		then return unlock_lang(msg) end 
if MsgText[1] == "فتح الفارسيه" 		then  return unlock_pharsi(msg) end 
if MsgText[1] == "فتح الفشار" 		then return unlock_mmno3(msg) end 


if MsgText[1] == "ضع رابط" then
if not msg.Creator  then return "📪¦ هذا الامر يخص {المطور,المنشئ الاساسي ,المنشئ} فقط  \n" end 
redis:setex(boss..'WiCmdLink'..msg.chat_id_..msg.sender_user_id_,500,true)
return '📭¦ حسننا عزيزي  ✋🏿\n🗯¦ الان ارسل  رابط مجموعتك 🍃'
end

if MsgText[1] == "انشاء رابط" then
if not msg.Creator then return "📪¦ هذا الامر يخص {المطور,المنشئ الاساسي ,المنشئ} فقط  \n" end
if not redis:get(boss..'ExCmdLink'..msg.chat_id_) then
local LinkGp = ExportLink(msg.chat_id_)
if LinkGp then
LinkGp = LinkGp.result
redis:set(boss..'linkGroup'..msg.chat_id_,LinkGp)
redis:setex(boss..'ExCmdLink'..msg.chat_id_,120,true)
return sendMsg(msg.chat_id_,msg.id_,"🙋🏼‍♂️*¦* تم انشاء رابط جديد \n🔖¦ ["..LinkGp.."]\n🔖¦ لعرض الرابط ارسل { الرابط } \n")
else
return sendMsg(msg.chat_id_,msg.id_,"📛¦ لا يمكنني انشاء رابط للمجموعه .\n🎟¦ لانني لست مشرف في المجموعه \n ❕")
end
else
return sendMsg(msg.chat_id_,msg.id_,"📛¦ لقد قمت بانشاء الرابط سابقا .\n🎟¦ يرجى الانتظار  { 4 دقيقة }  \n ❕🎟¦ لكي تستطيع انشاء رابط جديد")
end
return false
end 

if MsgText[1] == "الرابط" then
if not redis:get(boss.."lock_linkk"..msg.chat_id_) then return "📡*¦* الامر معطل من قبل الادارة \n^"  end
if not redis:get(boss..'linkGroup'..msg.chat_id_) then return "📡*¦* اوه 🙀 لا يوجد رابط ☹️\n🔖*¦*لانشاء رابط ارسل { انشاء رابط } \n📡" end
local GroupName = redis:get(boss..'group:name'..msg.chat_id_)
local GroupLink = redis:get(boss..'linkGroup'..msg.chat_id_)
return "📬¦ رابـط الـمـجـمـوعه :\n\n["..GroupLink.."]\n"
end

if MsgText[1] == "ضع القوانين" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
redis:setex(boss..'rulse:witting'..msg.chat_id_..msg.sender_user_id_,300,true)
return '📭¦ حسننا عزيزي  ✋🏿\n🗯¦ الان ارسل القوانين  للمجموعه 🍃'
end

if MsgText[1] == "القوانين" then
if not redis:get(boss..'rulse:msg'..msg.chat_id_) then 
return "📡*¦* مرحبأ عزيري 👋🏻 القوانين كلاتي 👇🏻\n🔖¦ ممنوع نشر الروابط \n🔖¦ ممنوع التكلم او نشر صور اباحيه \n🔖¦ ممنوع  اعاده توجيه\n🔖¦ ممنوع التكلم بلطائفه \n🔖¦ الرجاء احترام المدراء والادمنيه 😅\n"
else 
return "*🔖¦القوانين :*\n"..redis:get(boss..'rulse:msg'..msg.chat_id_) 
end 
end

if MsgText[1] == "ضع تكرار" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
local NumLoop = tonumber(MsgText[2])
if NumLoop < 1 or NumLoop > 50 then 
return "📡*¦* حدود التكرار ,  يجب ان تكون ما بين  *[2-50]*" 
end
redis:set(boss..'num_msg_max'..msg.chat_id_,MsgText[2]) 
return "📡*¦* تم وضع التكرار » { *"..MsgText[2].."* }"
end

if MsgText[1] == "ضع وقت التنظيف" then
if not msg.Creator then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
local NumLoop = tonumber(MsgText[2])
redis:set(boss..':Timer_Cleaner:'..msg.chat_id_,NumLoop) 
return "📡*¦* تم وضع وقت التنظيف » { *"..MsgText[2].."* } ساعه"
end



if MsgText[1] == "مسح المنشئيين الاساسيين" or MsgText[1] == "مسح المنشئين الاساسيين" or MsgText[1] == "مسح المنشئيين الاساسين" or MsgText[1] == "مسح المنشئين الاساسين" then 
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end

local Admins = redis:scard(boss..':MONSHA_Group:'..msg.chat_id_)
if Admins == 0 then  
return "📡*¦* اوه ☢ هنالك خطأ 🚸\n📛¦ عذرا لا يوجد منشئيين اساسييين ليتم مسحهم ✓" 
end
redis:del(boss..':MONSHA_Group:'..msg.chat_id_)
return "📮¦ بواسطه ⋙ "..msg.TheRankCmd.."   \n📛¦ تم مسح {"..Admins.."} من الادمنيه في البوت \n✓"
end

if MsgText[1] == "مسح الرسائل المجدوله" or MsgText[1] == "مسح الميديا" or MsgText[1] == "مسح الوسائط" then 
if not msg.Creator then return "📪¦ هذا الامر يخص {المطور,المنشئ} فقط  \n" end
local mmezz = redis:smembers(boss..":IdsMsgsCleaner:"..msg.chat_id_)
if #mmezz == 0 then return "📮¦ لا يوجد وسائط مجدوله للحذف او \n امر التنظيف تم تعطيله من قبل المنشئ الاساسي " end
for k,v in pairs(mmezz) do
Del_msg(msg.chat_id_,v)
end
return "📮¦ تم مسح جميع الوسائط المجدوله" 
end

if MsgText[1] == "مسح التعديلات"  or MsgText[1] == "مسح سحكاتي" or MsgText[1] == "مسح تعديلاتي" then    
redis:del(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_)
return "📮¦ تم مسح جميع سحكاتك" 
end

if MsgText[1] == "مسح الادمنيه" then 
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end

local Admins = redis:scard(boss..'admins:'..msg.chat_id_)
if Admins == 0 then  
return "📡*¦* اوه ☢ هنالك خطأ 🚸\n📛¦ عذرا لا يوجد ادمنيه ليتم مسحهم ✓" 
end
redis:del(boss..'admins:'..msg.chat_id_)
return "📮¦ بواسطه ⋙ "..msg.TheRankCmd.."   \n📛¦ تم مسح {"..Admins.."} من الادمنيه في البوت \n✓"
end


if MsgText[1] == "مسح قائمه المنع" then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
local Mn3Word = redis:scard(boss..':Filter_Word:'..msg.chat_id_)
if Mn3Word == 0 then 
return "📡*¦* عذرا لا توجد كلمات ممنوعه ليتم حذفها ✓" 
end
redis:del(boss..':Filter_Word:'..msg.chat_id_)
return "📮¦ بواسطه ⋙ "..msg.TheRankCmd.."   \n🔖¦ تم مسح {*"..Mn3Word.."*} كلمات من المنع ✓"
end


if MsgText[1] == "مسح القوانين" then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
if not redis:get(boss..'rulse:msg'..msg.chat_id_) then 
return "📛¦ عذرا لا يوجد قوانين ليتم مسحه \n!" 
end
redis:del(boss..'rulse:msg'..msg.chat_id_)
return "📮¦ بواسطه ⋙ "..msg.TheRankCmd.."   \n📛¦ تم حذف القوانين بنجاح ✓"
end


if MsgText[1] == "مسح الترحيب"  then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
if not redis:get(boss..'welcome:msg'..msg.chat_id_) then 
return "📡*¦* اوه ☢ هنالك خطأ 🚸\n📛¦ عذرا لا يوجد ترحيب ليتم مسحه ✓" 
end
redis:del(boss..'welcome:msg'..msg.chat_id_)
return "📮¦ بواسطه ⋙ "..msg.TheRankCmd.."   \n📛¦ تم حذف الترحيب بنجاح \n✓"
end


if MsgText[1] == "مسح المنشئيين" or MsgText[1] == "مسح المنشئين" then
if not msg.SuperCreator    then return "📪¦ هذا الامر يخص {المطور,منشئ الاساسي} فقط  \n" end
local NumMnsha = redis:scard(boss..':MONSHA_BOT:'..msg.chat_id_)
if NumMnsha ==0 then 
return "📛¦ عذرا لا يوجد منشئيين ليتم مسحهم \n!" 
end
redis:del(boss..':MONSHA_BOT:'..msg.chat_id_)
return "📮¦ بواسطه ⋙ "..msg.TheRankCmd.."   \n📛¦  تم مسح {* "..NumMnsha.." *} من المنشئيين\n✓"
end


if MsgText[1] == "مسح المدراء" then
if not msg.Creator then return "📪¦ هذا الامر يخص {المطور,المنشئ} فقط  \n" end
local NumMDER = redis:scard(boss..'owners:'..msg.chat_id_)
if NumMDER ==0 then 
return "📛¦ عذرا لا يوجد مدراء ليتم مسحهم \n!" 
end
redis:del(boss..'owners:'..msg.chat_id_)
return "📮¦ بواسطه ⋙ "..msg.TheRankCmd.."   \n📛¦  تم مسح {* "..NumMDER.." *} من المدراء  \n✓"
end

if MsgText[1] == 'مسح المحظورين' then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end

local list = redis:smembers(boss..'banned:'..msg.chat_id_)
if #list == 0 then return "*📌¦ لا يوجد مستخدمين محظورين  *" end
message = '📋*¦* قائمه الاعضاء المحظورين :\n'
for k,v in pairs(list) do
StatusLeft(msg.chat_id_,v)
end 
redis:del(boss..'banned:'..msg.chat_id_)
return "📮¦ بواسطه ⋙ "..msg.TheRankCmd.."   \n📛¦  تم مسح {* "..#list.." *} من المحظورين  \n✓"
end

if MsgText[1] == 'مسح المكتومين' then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
local MKTOMEN = redis:scard(boss..'is_silent_users:'..msg.chat_id_)
if MKTOMEN ==0 then 
return "📡*¦* لا يوجد مستخدمين مكتومين في المجموعه " 
end
redis:del(boss..'is_silent_users:'..msg.chat_id_)
return "📮¦ بواسطه ⋙ "..msg.TheRankCmd.."   \n📛¦  تم مسح {* "..MKTOMEN.." *} من المكتومين  \n✓"
end

if MsgText[1] == 'مسح المميزين' then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
local MMEZEN = redis:scard(boss..'whitelist:'..msg.chat_id_)
if MMEZEN ==0 then 
return "*⚙️*¦ لا يوجد مستخدمين مميزين في المجموعه " 
end
redis:del(boss..'whitelist:'..msg.chat_id_)
return "📮¦ بواسطه ⋙ "..msg.TheRankCmd.."   \n📛¦  تم مسح {* "..MMEZEN.." *} من المميزين  \n✓"
end

if MsgText[1] == 'مسح الرابط' then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
if not redis:get(boss..'linkGroup'..msg.chat_id_) then 
return "*⚙️*¦ لا يوجد رابط مضاف اصلا " 
end
redis:del(boss..'linkGroup'..msg.chat_id_)
return "📮¦ بواسطه ⋙ "..msg.TheRankCmd.."   \n📛¦ تم مسح رابط المجموعه"
end


if MsgText[1] == "مسح" then
if not MsgText[2] and msg.reply_id then 
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
Del_msg(msg.chat_id_, msg.reply_id) 
Del_msg(msg.chat_id_, msg.id_) 
return false
end

if MsgText[2] and MsgText[2]:match('^%d+$') then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
if 100 < tonumber(MsgText[2]) then return "📛*¦* حدود المسح ,  يجب ان تكون ما بين  *[2-100]*" end
local DelMsg = MsgText[2] + 1
GetHistory(msg.chat_id_,DelMsg,function(arg,data)
All_Msgs = {}
for k, v in pairs(data.messages_) do
if k ~= 0 then
if k == 1 then
All_Msgs[0] = v.id_
else
table.insert(All_Msgs,v.id_)
end  
end 
end 
if tonumber(DelMsg) == data.total_count_ then
tdcli_function({ID="DeleteMessages",chat_id_ = msg.chat_id_,message_ids_=All_Msgs},function() 
sendMsg(msg.chat_id_,msg.id_,"*⛑¦* تـم مسح ~⪼ { *"..MsgText[2].."* } من الرسائل  \n✓")
end,nil)
else
tdcli_function({ID="DeleteMessages",chat_id_=msg.chat_id_,message_ids_=All_Msgs},function() 
sendMsg(msg.chat_id_,msg.id_,"*⛑¦* تـم مسح ~⪼ { *"..MsgText[2].."* } من الرسائل  \n✓")
end,nil)
end
end)
return false
end
end 

--End del 

if MsgText[1] == "ضع اسم" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
redis:setex(boss..'name:witting'..msg.chat_id_..msg.sender_user_id_,300,true)
return "📭¦ حسننا عزيزي  ✋🏿\n🗯¦ الان ارسل الاسم  للمجموعه \n🛠"
end

if MsgText[1] == "حذف صوره" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
tdcli_function({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = {ID = "InputFileId", id_ = 0}},function(arg,data)
if data.message_ and data.message_ == "CHAT_NOT_MODIFIED" then
sendMsg(arg.ChatID,arg.MsgID,'🚸¦ عذرا , لا توجد صوره في المجموعة\n✖️')
elseif data.message_ and data.message_ == "CHAT_ADMIN_REQUIRED" then
sendMsg(arg.ChatID,arg.MsgID,'🚸¦ عذرا , البوت ليس لدية صلاحيه التعديل في المجموعة \n✖️')
else
sendMsg(arg.ChatID,arg.MsgID,'🚸¦ تم حذف صوره آلمـجمـوعهہ 🌿\n✖️')
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
return false
end

if MsgText[1] == "ضع صوره" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg, data)
if data.content_.ID == 'MessagePhoto' then
if data.content_.photo_.sizes_[3] then 
photo_id = data.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = data.content_.photo_.sizes_[0].photo_.persistent_id_
end
tdcli_function({
ID="ChangeChatPhoto",
chat_id_=arg.ChatID,
photo_ = GetInputFile(photo_id)},
function(arg,data)
if data.code_ and data.code_ == 3 then
return sendMsg(arg.ChatID,arg.MsgID,'🚸 ¦ ليس لدي صلاحيه تغيير الصوره \n🤖 ¦ يجب اعطائي صلاحيه `تغيير معلومات المجموعه ` ⠀\n✓')
end
end,{ChatID=arg.ChatID,MsgID=arg.MsgID})
end
end,{ChatID=msg.chat_id_,MsgID=msg.reply_id})
return false
else 
redis:setex(boss..'photo:group'..msg.chat_id_..msg.sender_user_id_,300,true)
return '📭¦ حسننا عزيزي 🍁\n🌄 ¦ الان قم بارسال الصوره\n🛠' 
end 
end

if MsgText[1] == "ضع وصف" then 
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
redis:setex(boss..'about:witting'..msg.chat_id_..msg.sender_user_id_,300,true) 
return "📭¦ حسننا عزيزي  ✋🏿\n🗯¦ الان ارسل الوصف  للمجموعه\n🛠" 
end

if MsgText[1] == "الادارين" or MsgText[1] == "الأداريين" or MsgText[1] == "الاداريين" or MsgText[1] == "الادارين" then   
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if not redis:get(boss.."lock_takkl"..msg.chat_id_) then  return "📛*¦* الامر معطل من قبل الادراة" end 
if redis:get(boss.."chat:tagall"..msg.chat_id_) then  return "📛*¦* يمكنك عمل تاك للكل كل *5 دقائق* فقط" end 
redis:setex(boss..'chat:tagall'..msg.chat_id_,300,true)
return TagAll(msg) 
end

if MsgText[1] == "تاك للكل" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if not redis:get(boss.."lock_takkl"..msg.chat_id_) then  return "📛*¦* الامر معطل من قبل الادراة" end 
if redis:get(boss.."chat:tagall"..msg.chat_id_) then  return "📛*¦* يمكنك عمل تاك للكل كل *5 دقائق* فقط" end 
redis:setex(boss..'chat:tagall'..msg.chat_id_,300,true)
if MsgText[2] and MsgText[2]:match('^ل %d+$') then
taglimit = MsgText[2]:match('^ل %d+$'):gsub('ل ','')

else
taglimit = 200
end
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = taglimit
},function(ta,moody)
x = 0
list = moody.members_
for k, v in pairs(list) do
GetUserID(v.user_id_,function(arg,data)
x = x + 1
if x == 1 then
t = "👥¦ قائمة الاعضاء \n\n"
end
if data.username_ then
t = t..""..x.."-l {[@"..data.username_.."]} \n"
else
tagname = FlterName(data.first_name_..' '..(data.last_name_ or ""),20)
tagname = tagname:gsub("]","")
tagname = tagname:gsub("[[]","")
t = t..""..x.."-l {["..tagname.."](tg://user?id="..v.user_id_..")} \n"
end
if k == 0 then
send_msg(msg.chat_id_,t,msg.id_)
end
end)
end
end,nil)
end
if MsgText[1] == "منع" then 
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if MsgText[2] then
return AddFilter(msg, MsgText[2]) 
elseif msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg, data)
if data.content_.ID == "MessageText" then
Type_id = data.content_.text_
elseif data.content_.ID == 'MessagePhoto' then
if data.content_.photo_.sizes_[3] then Type_id = data.content_.photo_.sizes_[3].photo_.persistent_id_ else Type_id = data.content_.photo_.sizes_[0].photo_.persistent_id_ end
elseif data.content_.ID == "MessageSticker" then
Type_id = data.content_.sticker_.sticker_.persistent_id_
elseif data.content_.ID == "MessageVoice" then
Type_id = data.content_.voice_.voice_.persistent_id_
elseif data.content_.ID == "MessageAnimation" then
Type_id = data.content_.animation_.animation_.persistent_id_
elseif data.content_.ID == "MessageVideo" then
Type_id = data.content_.video_.video_.persistent_id_
elseif data.content_.ID == "MessageAudio" then
Type_id = data.content_.audio_.audio_.persistent_id_
elseif data.content_.ID == "MessageUnsupported" then
return sendMsg(arg.ChatID,arg.MsgID,"📝*¦* عذرا الرساله غير مدعومه ✓️")
else
Type_id = 0
end

if redis:sismember(boss..':Filter_Word:'..arg.ChatID,Type_id) then 
return sendMsg(arg.ChatID,arg.MsgID,"📝*¦* هي بالتأكيد في قائمه المنع✓️")
else
redis:sadd(boss..':Filter_Word:'..arg.ChatID,Type_id) 
return sendMsg(arg.ChatID,arg.MsgID,"📝*¦* تمت اضافتها الى قائمه المنع ✓️")
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end
return false 
end

if MsgText[1] == "الغاء منع" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if MsgText[2] then
return RemFilter(msg,MsgText[2]) 
elseif msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg, data)
if msg.content_.ID == "MessageText" then
Type_id = data.content_.text_
elseif data.content_.ID == 'MessagePhoto' then
if data.content_.photo_.sizes_[3] then Type_id = data.content_.photo_.sizes_[3].photo_.persistent_id_ else Type_id = data.content_.photo_.sizes_[0].photo_.persistent_id_ end
elseif data.content_.ID == "MessageSticker" then
Type_id = data.content_.sticker_.sticker_.persistent_id_
elseif data.content_.ID == "MessageVoice" then
Type_id = data.content_.voice_.voice_.persistent_id_
elseif data.content_.ID == "MessageAnimation" then
Type_id = data.content_.animation_.animation_.persistent_id_
elseif data.content_.ID == "MessageVideo" then
Type_id = data.content_.video_.video_.persistent_id_
elseif data.content_.ID == "MessageAudio" then
Type_id = data.content_.audio_.audio_.persistent_id_
end
if redis:sismember(boss..':Filter_Word:'..arg.ChatID,Type_id) then 
redis:srem(boss..':Filter_Word:'..arg.ChatID,Type_id) 
return sendMsg(arg.ChatID,arg.MsgID,"📝*¦* تم السماح بها✓️")
else
return sendMsg(arg.ChatID,arg.MsgID,"📝*¦* هي بالتأكيد مسموح بها✓️")
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end
return false 
end

if MsgText[1] == "قائمه المنع" then 
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
return FilterXList(msg) 
end

if MsgText[1] == "الحمايه" then 
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
return settingsall(msg) 
end

if MsgText[1] == "الاعدادات" then 
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
return settings(msg) 
end

if MsgText[1] == "الوسائط" then 
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
return media(msg) 
end

if MsgText[1] == "الادمنيه" then 
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
return GetListAdmin(msg) 
end

if MsgText[1] == "المدراء" then 
if not msg.Director  then return "📪¦ هذا الامر يخص {المدير,المنشئ,المطور} فقط  \n" end
return ownerlist(msg) 
end

if MsgText[1] == "المنشئيين"  or MsgText[1] == "المنشئين" then 
if not msg.Creator  then return "📪¦ هذا الامر يخص {المطور ,المنشئ الاساسي ,المنشئ } فقط  \n" end
return conslist(msg)
end

if MsgText[1] == "المميزين" then 
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
return whitelist(msg) 
end

if MsgText[1] == "طرد البوتات" then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ} فقط  \n" end
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''),filter_={ID="ChannelMembersBots"},offset_=0,limit_=50},function(arg,data)
local Total = data.total_count_ or 0
if Total == 1 then
return sendMsg(arg.ChatID,arg.MsgID,"🔖¦ لا يـوجـد بـوتـات في الـمـجـمـوعـه .") 
else
local NumBot = 0
local NumBotAdmin = 0
for k, v in pairs(data.members_) do
if v.user_id_ ~= our_id then
kick_user(v.user_id_,arg.ChatID,function(arg,data)
if data.ID == "Ok" then
NumBot = NumBot + 1
else
NumBotAdmin = NumBotAdmin + 1
end
local TotalBots = NumBot + NumBotAdmin  
if TotalBots  == Total - 1 then
local TextR  = "📌¦ عـدد الـبـوتات •⊱ {* "..(Total - 1).." *} ⊰•\n\n"
if NumBot == 0 then 
TextR = TextR.."📮¦ لا يـمـكـن طردهم لانـهـم مشـرفـين .\n"
else
if NumBotAdmin >= 1 then
TextR = TextR.."🔖¦ لم يتم طـرد {* "..NumBotAdmin.." *} بوت لآنهہ‌‏م مـشـرفين."
else
TextR = TextR.."📮¦ تم طـرد كــل البوتآت بنجآح .\n"
end
end
return sendMsg(arg.ChatID,arg.MsgID,TextR) 
end
end,{ChatID=arg.ChatID,MsgID=arg.MsgID})
end
end
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
return false
end

if MsgText[1] == "كشف البوتات" then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''),
filter_ ={ID= "ChannelMembersBots"},offset_ = 0,limit_ = 50},function(arg,data)
local total = data.total_count_ or 0
AllBots = '🤖¦ قـائمه البوتات الـحالية\n\n'
local NumBot = 0
for k, v in pairs(data.members_) do
GetUserID(v.user_id_,function(arg,data)
if v.status_.ID == "ChatMemberStatusEditor" then
BotAdmin = "» *★*"
else
BotAdmin = ""
end
NumBot = NumBot + 1
AllBots = AllBots..NumBot..'- @['..data.username_..'] '..BotAdmin..'\n'
if NumBot == total then
AllBots = AllBots..[[

📮¦ لـديـک {]]..total..[[} بـوتـآت
🔖¦ ملاحظة : الـ ★ تعنـي ان البوت مشرف في المجموعـة.]]
sendMsg(arg.ChatID,arg.MsgID,AllBots) 
end
end,{ChatID=arg.ChatID,MsgID=arg.MsgID})
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
return false
end

if MsgText[1] == 'طرد المحذوفين' then
if not msg.Creator then return "📪¦ هذا الامر يخص {المطور,المنشئ} فقط  \n" end
sendMsg(msg.chat_id_,msg.id_,'🔛¦ جاري البحث عـن الـحـسـابـات المـحذوفـة ...')
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100','')
,offset_ = 0,limit_ = 200},function(arg,data)
if data.total_count_ and data.total_count_ <= 200 then
Total = data.total_count_ or 0
else
Total = 200
end
local NumMem = 0
local NumMemDone = 0
for k, v in pairs(data.members_) do 
GetUserID(v.user_id_,function(arg,datax)
if datax.type_.ID == "UserTypeDeleted" then 
NumMemDone = NumMemDone + 1
kick_user(v.user_id_,arg.ChatID,function(arg,data)  
redis:srem(boss..':MONSHA_BOT:'..arg.ChatID,v.user_id_)
redis:srem(boss..'whitelist:'..arg.ChatID,v.user_id_)
redis:srem(boss..'owners:'..arg.ChatID,v.user_id_)
redis:srem(boss..'admins:'..arg.ChatID,v.user_id_)
end)
end
NumMem = NumMem + 1
if NumMem == Total then
if NumMemDone >= 1 then
sendMsg(arg.ChatID,arg.MsgID,"🚸 ¦ تم طـرد {* "..NumMemDone.." *} من آلحسـآبآت آلمـحذوفهہ‏‏ 🌿")
else
sendMsg(arg.ChatID,arg.MsgID,'🚸 ¦ لا يوجد حسابات محذوفه في المجموعه 🌿')
end
end
end,{ChatID=arg.ChatID,MsgID=arg.MsgID})
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
return false
end  

if MsgText[1] == 'شحن' and MsgText[2] then
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end
if tonumber(MsgText[2]) > 0 and tonumber(MsgText[2]) < 1001 then
local extime = (tonumber(MsgText[2]) * 86400)
redis:setex(boss..'ExpireDate:'..msg.chat_id_, extime, true)
if not redis:get(boss..'CheckExpire::'..msg.chat_id_) then 
redis:set(boss..'CheckExpire::'..msg.chat_id_,true) end
sendMsg(msg.chat_id_,msg.id_,'💂🏻‍♀️¦ تم شحن الاشتراك الى `'..MsgText[2]..'` يوم   ... 👍🏿')
sendMsg(SUDO_ID,0,'💂🏻‍♀️¦ تم شحن الاشتراك الى `'..MsgText[2]..'` يوم   ... 👍🏿\n🕵🏼️‍♀️¦ في مجموعه  » »  '..redis:get(boss..'group:name'..msg.chat_id_))
else
sendMsg(msg.chat_id_,msg.id_,'💂🏻‍♀️¦ عزيزي المطور ✋🏿\n👨🏻‍🔧¦ شحن الاشتراك يكون ما بين يوم الى 1000 يوم فقط 🍃')
end 
return false
end

if MsgText[1] == 'الاشتراك' and MsgText[2] then 
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end
if MsgText[2] == '1' then
redis:setex(boss..'ExpireDate:'..msg.chat_id_, 2592000, true)
if not redis:get(boss..'CheckExpire::'..msg.chat_id_) then 
redis:set(boss..'CheckExpire::'..msg.chat_id_,true) 
end
sendMsg(msg.chat_id_,msg.id_,'💂🏻‍♀️¦ تم تفعيل الاشتراك   👍🏿\n📆¦  الاشتراك » `30 يوم`  *(شهر)*')
sendMsg(SUDO_ID,0,'💂🏻‍♀️¦ تم تفعيل الاشتراك  👍🏿\n📆¦  الاشتراك » `30 يوم`  *(شهر)*')
end
if MsgText[2] == '2' then
redis:setex(boss..'ExpireDate:'..msg.chat_id_,7776000,true)
if not redis:get(boss..'CheckExpire::'..msg.chat_id_) then 
redis:set(boss..'CheckExpire::'..msg.chat_id_,true) 
end
sendMsg(msg.chat_id_,msg.id_,'💂🏻‍♀️¦ تم تفعيل الاشتراك   👍🏿\n📆¦  الاشتراك » `90 يوم`  *(3 اشهر)*')
sendMsg(SUDO_ID,0,'💂🏻‍♀️¦ تم تفعيل الاشتراك   👍🏿\n📆¦  الاشتراك » `90 يوم`  *(3 اشهر)*')
end
if MsgText[2] == '3' then
redis:set(boss..'ExpireDate:'..msg.chat_id_,true)
if not redis:get(boss..'CheckExpire::'..msg.chat_id_) then 
redis:set(boss..'CheckExpire::'..msg.chat_id_,true) end
sendMsg(msg.chat_id_,msg.id_,'💂🏻‍♀️¦ تم تفعيل الاشتراك   👍🏿\n📆¦  الاشتراك » `مفتوح`  *(مدى الحياة)*')
sendMsg(SUDO_ID,0,'💂🏻‍♀️¦ تم تفعيل الاشتراك   👍🏿\n📆¦  الاشتراك » `مفتوح`  *(مدى الحياة)*')
end 
return false
end

if MsgText[1] == 'الاشتراك' and not MsgText[2] and msg.Admin then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
local check_time = redis:ttl(boss..'ExpireDate:'..msg.chat_id_)
if check_time < 0 then return '*مـفـتـوح *🎖\n✓' end
year = math.floor(check_time / 31536000)
byear = check_time % 31536000 
month = math.floor(byear / 2592000)
bmonth = byear % 2592000 
day = math.floor(bmonth / 86400)
bday = bmonth % 86400 
hours = math.floor( bday / 3600)
bhours = bday % 3600 
min = math.floor(bhours / 60)
sec = math.floor(bhours % 60)
if tonumber(check_time) > 1 and check_time < 60 then
remained_expire = '💳¦ `باقي من الاشتراك ` » » * \n 📆¦  '..sec..'* ثانيه'
elseif tonumber(check_time) > 60 and check_time < 3600 then
remained_expire = '💳¦ `باقي من الاشتراك ` » » '..min..' *دقيقه و * *'..sec..'* ثانيه'
elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
remained_expire = '💳¦ `باقي من الاشتراك ` » » * \n 📆¦  '..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه'
elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
remained_expire = '💳¦ `باقي من الاشتراك ` » » * \n 📆¦  '..day..'* يوم و *'..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه'
elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
remained_expire = '💳¦ `باقي من الاشتراك ` » » * \n 📆¦  '..month..'* شهر و *'..day..'* يوم و *'..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه'
elseif tonumber(check_time) > 31536000 then
remained_expire = '💳¦ `باقي من الاشتراك ` » » * \n 📆¦  '..year..'* سنه و *'..month..'* شهر و *'..day..'* يوم و *'..hours..'* ساعه و *'..min..'* دقيقه و *'..sec..'* ثانيه' end
return remained_expire
end

if MsgText[1] == "الرتبه" and not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
GetChatMember(arg.ChatID,data.sender_user_id_,function(arg,data)
if data.status_ and data.status_.ID == "ChatMemberStatusEditor" then
SudoGroups = 'مشرف '
elseif data.status_ and data.status_.ID == "ChatMemberStatusCreator" then 
SudoGroups = "منشئ ."
else
SudoGroups = "عضو .!"
end

Getrtb = Getrtba(arg.UserID,arg.ChatID)
GetUserID(arg.UserID,function(arg,data)
USERNAME = ResolveUserName(data)
USERCAR  = utf8.len(USERNAME)
SendMention(arg.ChatID,arg.UserID,arg.MsgID,'👤¦ العضو » '..USERNAME..'\n\nـ⠀•⊱ { رتـبـه الشخص } ⊰•\n\n🤖¦ في البوت » '..arg.Getrtb..' \n📋¦ في المجموعه » '..arg.SudoGroups..'\n✓',12,utf8.len(USERNAME)) 
end,{ChatID=arg.ChatID,UserID=arg.UserID,MsgID=arg.MsgID,Getrtb=Getrtb,SudoGroups=SudoGroups})
end,{ChatID=arg.ChatID,UserID=data.sender_user_id_,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
return false
end

if MsgText[1] == "كشف البوت" and not MsgText[2] then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
GetChatMember(msg.chat_id_,our_id,function(arg,data)
if data.status_.ID ~= "ChatMemberStatusMember" then 
sendMsg(arg.ChatID,arg.MsgID,'📡*¦* جيد , الـبــوت ادمــن الان \n')
else 
sendMsg(arg.ChatID,arg.MsgID,'📡*¦* كلا البوت ليس ادمن في المجموعة 📛')
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
return false 
end

if MsgText[1]== 'رسائلي' or MsgText[1] == 'رسايلي' or MsgText[1] == 'احصائياتي'  then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgs = (redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
local NumGha = (redis:get(boss..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local photo = (redis:get(boss..':photo:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local sticker = (redis:get(boss..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local voice = (redis:get(boss..':voice:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local audio = (redis:get(boss..':audio:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local animation = (redis:get(boss..':animation:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local edited = (redis:get(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local video = (redis:get(boss..':video:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)

local Get_info =  "⠀\n⠀•⊱ { الاحـصـائـيـات الـرسـائـل } ⊰•\n"
.."📋¦ الـرسـائـل •⊱ { `"..msgs.."` } ⊰•\n"
.."📞¦ الـجـهـات •⊱ { `"..NumGha.."` } ⊰•\n"
.."📸¦ الـصـور •⊱ { `"..photo.."` } ⊰•\n"
.."📽¦ الـمـتـحـركـه •⊱ { `"..animation.."` } ⊰•\n"
.."🔖¦ الـمـلـصـقات •⊱ { `"..sticker.."` } ⊰•\n"
.."🎙¦ الـبـصـمـات •⊱ { `"..voice.."` } ⊰•\n"
.."🔊¦ الـصـوت •⊱ { `"..audio.."` } ⊰•\n"
.."🎞¦ الـفـيـديـو •⊱ { `"..video.."` } ⊰•\n"
.."📬¦ الـتـعـديـل •⊱ { `"..edited.."` } ⊰•\n\n"
.."📊¦ تـفـاعـلـك  •⊱ "..Get_Ttl(msgs).." ⊰•\n"
.."ـ.——————————\n"
return sendMsg(arg.chat_id_,arg.id_,Get_info)    
end,{chat_id_=msg.chat_id_,id_=msg.id_})
return false
end

if MsgText[1]== 'جهاتي' then
return '🧟‍♂*¦*  عدد جهہآتگ آلمـضـآفهہ‏‏ » 【'..(redis:get(boss..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)..'】 . \n🐾'
end

if MsgText[1] == 'معلوماتي' or MsgText[1] == 'موقعي' then
GetUserID(msg.sender_user_id_,function(arg,data)
local msgs = (redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
local NumGha = (redis:get(boss..':adduser:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local photo = (redis:get(boss..':photo:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local sticker = (redis:get(boss..':sticker:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local voice = (redis:get(boss..':voice:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local audio = (redis:get(boss..':audio:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local animation = (redis:get(boss..':animation:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local edited = (redis:get(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local video = (redis:get(boss..':video:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
USERNAME = ""
Name = data.first_name_
if data.last_name_ then Name = data.first_name_ .." "..data.last_name_ end
if data.username_ then USERNAME = "💠¦ المعرف •⊱ @["..data.username_.."] ⊰•\n" end 
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
if SUDO_USER:match('@[%a%d_]+') then 
SUDO_USERR = "👨🏻‍💻¦ مـطـور البوت •⊱ ["..SUDO_USER.."] ⊰•\n"
else
SUDO_USERR = ""
end
local Get_info = "👨🏽‍🔧¦ اهـلا بـك عزيزي في معلوماتك 🥀 \n"
.."ـ.——————————\n"
.."🗯¦ الاســم •⊱{ "..FlterName(Name,25) .." }⊰•\n"
..USERNAME
.."⚜️¦ الايـدي •⊱ { `"..data.id_.."` } ⊰•\n"
.."🚸¦ رتبتــك •⊱ "..arg.TheRank.." ⊰•\n"
.."🔰¦ ــ •⊱ { `"..arg.chat_id_.."` } ⊰•\n"
.."ـ.——————————\n"
.." •⊱ { الاحـصـائـيـات الـرسـائـل } ⊰•\n"
.."📋¦ الـرسـائـل •⊱ { `"..msgs.."` } ⊰•\n"
.."📞¦ الـجـهـات •⊱ { `"..NumGha.."` } ⊰•\n"
.."📸¦ الـصـور •⊱ { `"..photo.."` } ⊰•\n"
.."📽¦ الـمـتـحـركـه •⊱ { `"..animation.."` } ⊰•\n"
.."🔖¦ الـمـلـصـقات •⊱ { `"..sticker.."` } ⊰•\n"
.."🎙¦ الـبـصـمـات •⊱ { `"..voice.."` } ⊰•\n"
.."🔊¦ الـصـوت •⊱ { `"..audio.."` } ⊰•\n"
.."🎞¦ الـفـيـديـو •⊱ { `"..video.."` } ⊰•\n"
.."📬¦ الـتـعـديـل •⊱ { `"..edited.."` } ⊰•\n\n"
.."📊¦ تـفـاعـلـك  •⊱ "..Get_Ttl(msgs).." ⊰•\n"
.."ـ.——————————\n"
..SUDO_USERR
sendMsg(arg.chat_id_,arg.id_,Get_info)    
end,{chat_id_=msg.chat_id_,id_=msg.id_,TheRank=msg.TheRank})
return false
end

if MsgText[1] == "تفعيل الردود العشوائيه" 	then return unlock_replayRn(msg) end
if MsgText[1] == "تفعيل الردود" 	then return unlock_replay(msg) end
if MsgText[1] == "تفعيل الايدي" 	then return unlock_ID(msg) end
if MsgText[1] == "تفعيل الترحيب" 	then return unlock_Welcome(msg) end
if MsgText[1] == "تفعيل التحذير" 	then return unlock_waring(msg) end 
if MsgText[1] == "تفعيل الايدي بالصوره" 	then return unlock_idphoto(msg) end 
if MsgText[1] == "تفعيل الحمايه" 	then return unlock_AntiEdit(msg) end 
if MsgText[1] == "تفعيل المغادره" 	then return unlock_leftgroup(msg) end 
if MsgText[1] == "تفعيل الحظر" 	then return unlock_KickBan(msg) end 
if MsgText[1] == "تفعيل الرابط" 	then return unlock_linkk(msg) end 
if MsgText[1] == "تفعيل تاك للكل" 	then return unlock_takkl(msg) end 
if MsgText[1] == "تفعيل التحقق" 		then return unlock_check(msg) end 
if MsgText[1] == "تفعيل التنظيف التلقائي" 		then return unlock_cleaner(msg) end 
if MsgText[1] == "تفعيل ردود السورس" 		then return unlock_rdodSource(msg) end 


if MsgText[1] == "تعطيل الردود العشوائيه" 	then return lock_replayRn(msg) end
if MsgText[1] == "تعطيل الردود" 	then return lock_replay(msg) end
if MsgText[1] == "تعطيل الايدي" 	then return lock_ID(msg) end
if MsgText[1] == "تعطيل الترحيب" 	then return lock_Welcome(msg) end
if MsgText[1] == "تعطيل التحذير" 	then return lock_waring(msg) end
if MsgText[1] == "تعطيل الايدي بالصوره" 	then return lock_idphoto(msg) end
if MsgText[1] == "تعطيل الحمايه" 	then return lock_AntiEdit(msg) end
if MsgText[1] == "تعطيل المغادره" 	then return lock_leftgroup(msg) end 
if MsgText[1] == "تعطيل الحظر" 	then return lock_KickBan(msg) end 
if MsgText[1] == "تعطيل الرابط" 	then return lock_linkk(msg) end 
if MsgText[1] == "تعطيل تاك للكل" 	then return lock_takkl(msg) end 
if MsgText[1] == "تعطيل التحقق" 		then return lock_check(msg) end 
if MsgText[1] == "تعطيل التنظيف التلقائي" 		then return lock_cleaner(msg) end 
if MsgText[1] == "تعطيل ردود السورس" 		then return lock_rdodSource(msg) end 


if MsgText[1] == "ضع الترحيب" then 
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
redis:set(boss..'welcom:witting'..msg.chat_id_..msg.sender_user_id_,true) 
return "📭¦ حسننا عزيزي  ✋🏿\n🗯¦ ارسل كليشه الترحيب الان\n\n علما ان الاختصارات كالاتي : \n \n{الاسم} : لوضع اسم المستخدم\n{الايدي} : لوضع ايدي المستخدم\n{المعرف} : لوضع معرف المستخدم \n{الرتبه} : لوضع نوع رتبه المستخدم \n{التفاعل} : لوضع تفاعل المستخدم \n{الرسائل} : لاضهار عدد الرسائل \n{النقاط} : لاضهار عدد النقاط \n{التعديل} : لاضهار عدد السحكات \n{البوت} : لاضهار اسم البوت\n{المطور} : لاضهار معرف المطور الاساسي\n➼" 
end

if MsgText[1] == "الترحيب" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
if redis:get(boss..'welcome:msg'..msg.chat_id_)  then
return Flter_Markdown(redis:get(boss..'welcome:msg'..msg.chat_id_))
else 
return "🙋🏼‍♂️*¦* أهلا عزيزي "..msg.TheRankCmd.."  \n🌿¦ نورت المجموعه \n💂🏼‍♀️" 
end 
end

if MsgText[1] == "المكتومين" then 
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
return MuteUser_list(msg) 
end

if MsgText[1] == "المحظورين" then 
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
return GetListBanned(msg) 
end

if MsgText[1] == "رفع الادمنيه" then
if not msg.Creator then return "📪¦ هذا الامر يخص {المطور,المنشئ} فقط  \n" end
return set_admins(msg) 
end

end -- end of insert group 
if MsgText[1] == "تعطيل الاذاعه"  or MsgText[1] =="تعطيل الاذاعه 🔌"	then return lock_brod(msg) end
if MsgText[1] == "تفعيل تعيين الايدي" or MsgText[1] =="تفعيل تعيين الايدي ⌨️" 	then return unlock_idediit(msg) end 
if MsgText[1] == "تعطيل تعيين الايدي" or MsgText[1] =="تعطيل تعيين الايدي ⚔️" 	then return lock_idediit(msg) end 
if MsgText[1] == "تفعيل الاذاعه" or MsgText[1] =="تفعيل الاذاعه 📇" 	then return unlock_brod(msg) end



if MsgText[1] == 'مسح المطورين'  then
if not msg.SudoBase then return "📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
local mtwren = redis:scard(boss..':SUDO_BOT:')
if mtwren == 0 then  return "⚙️*¦* عذرا لا يوجد مطورين في البوت  ✖️" end
redis:del(boss..':SUDO_BOT:') 
return "📛*¦* تم مسح {* "..mtwren.." *} من المطورين ☔️\n✓"
end

if MsgText[1] == 'مسح قائمه العام'  then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
local addbannds = redis:scard(boss..'gban_users')
if addbannds ==0 then 
return "*⚙️¦ قائمة الحظر فارغه .*" 
end
redis:del(boss..'gban_users') 
return "⚙️*¦* تـم مـسـح { *"..addbannds.." *} من قائمه العام\n✓" 
end 

if MsgText[1] == "رفع منشئ اساسي" or MsgText[1] == "رفع منشى اساسي" then
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"👤*¦* عذرا لا يمكنني رفع بوت \n📛") 
end
GetUserID(UserID,function(arg,data)
ReUsername = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه منشئ اساسي  في المجموعه") 
else
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه منشئ اساسي  في المجموعه") 
redis:hset(boss..'username:'..arg.UserID,'username',ReUsername)
redis:sadd(boss..':MONSHA_Group:'..arg.ChatID,arg.UserID)
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end


if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه منشئ اساسي  في المجموعه") 
else
redis:hset(boss..'username:'..UserID,'username',arg.UserName)
redis:sadd(boss..':MONSHA_Group:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه منشئ اساسي  في المجموعه") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="Upmonsh"}) 
end
return false
end

if MsgText[1] == "تنزيل منشئ اساسي" or MsgText[1] == "تنزيل منشى اساسي" then
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data):gsub([[\]],"")
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله منشئ اساسي  في المجموعه") 
else
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله منشئ اساسي  في المجموعه") 
redis:srem(boss..':MONSHA_Group:'..arg.ChatID,arg.UserID)
end  
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end


if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
UserName = Flter_Markdown(arg.UserName)
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..':MONSHA_Group:'..arg.ChatID,UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله منشئ اساسي  في المجموعه") 
else
redis:srem(boss..':MONSHA_Group:'..arg.ChatID,UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله منشئ اساسي  في المجموعه")
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 

if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="Dwmonsh"}) 
end

return false
end


if MsgText[1] == 'مسح كلايش التعليمات' then 
if not msg.SudoBase then return "📪¦ هذا الامر يخص {مطور اساسي} فقط  \n" end
redis:del(boss..":awamer_Klesha_m1:")
redis:del(boss..":awamer_Klesha_m2:")
redis:del(boss..":awamer_Klesha_m3:")
redis:del(boss..":awamer_Klesha_mtwr:")
redis:del(boss..":awamer_Klesha_mrd:")
redis:del(boss..":awamer_Klesha_mf:")
redis:del(boss..":awamer_Klesha_m:")

sendMsg(msg.chat_id_,msg.id_,"📛*¦* تم مسح كلايش التعليمات  \n❕")
end

if MsgText[1] == 'مسح كليشه الايدي' or MsgText[1] == 'مسح الايدي' or MsgText[1] == 'مسح ايدي'  or MsgText[1] == 'مسح كليشة الايدي'  then 
if not msg.Creator then return "📪¦ هذا الامر يخص {منشئ اساسي,المنشئ,المطور} فقط  \n" end
redis:del(boss..":infoiduser_public:"..msg.chat_id_)
sendMsg(msg.chat_id_,msg.id_,"📛*¦* تم مسح كليشة الايدي بنجاح \n❕")
end

if MsgText[1] == 'تعيين كليشه الايدي' or MsgText[1] == 'تعيين الايدي' or MsgText[1] == 'تعيين ايدي'  or MsgText[1] == 'تعيين كليشة الايدي'  then 
if not msg.Creator then return "📪¦ هذا الامر يخص {منشئ اساسي,المنشئ,المطور} فقط  \n" end
redis:setex(boss..":Witting_KleshaID_public"..msg.chat_id_..msg.sender_user_id_,1000,true)
return '📮*¦* حسننا , الان ارسل كليشه الايدي الجديده \n علما ان الاختصارات كالاتي : \n \n{الاسم} : لوضع اسم المستخدم\n{الايدي} : لوضع ايدي المستخدم\n{المعرف} : لوضع معرف المستخدم \n{الرتبه} : لوضع نوع رتبه المستخدم \n{التفاعل} : لوضع تفاعل المستخدم \n{الرسائل} : لاضهار عدد الرسائل \n{النقاط} : لاضهار عدد النقاط \n{التعديل} : لاضهار عدد السحكات \n{البوت} : لاضهار اسم البوت\n{المطور} : لاضهار معرف المطور الاساسي\n قناه تعليمات ونشر كلايش الايدي \n قناه الكلايش : [@Change_id] \n➼' 
end


if MsgText[1] == "تنزيل الكل" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(msg.chat_id_,msg.id_,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
msg = arg.msg
msg.UserID = UserID
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
msg = arg.msg
UserID = msg.UserID
if UserID == our_id then return sendMsg(msg.chat_id_,msg.id_,"📛*¦* لآ يمكنك تنفيذ الامر مع البوت\n❕") end
if UserID == 819385837 or UserID == 60809019 then return sendMsg(msg.chat_id_,msg.id_,"📛*¦* لآ يمكنك تنفيذ الامر ضد مطور السورس \n❕") end

if UserID == SUDO_ID then 
rinkuser = 1
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
rinkuser = 2
elseif redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,UserID) then 
rinkuser = 3
elseif redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
rinkuser = 4
elseif redis:sismember(boss..'owners:'..msg.chat_id_,UserID) then 
rinkuser = 5
elseif redis:sismember(boss..'admins:'..msg.chat_id_,UserID) then 
rinkuser = 6
elseif redis:sismember(boss..'whitelist:'..msg.chat_id_,UserID) then 
rinkuser = 7
else
rinkuser = 8
end
local DonisDown = "\n📛¦ تم تنزيله من الرتب الاتيه : \n\n "
if redis:sismember(boss..':SUDO_BOT:',UserID) then 
DonisDown = DonisDown.."❌¦ تم تنزيله من المطور ✓️\n"
end 
if redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."❌¦ تم تنزيله من المنشئ الاساسي ✓️\n"
end 
if redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."❌¦ تم تنزيله من المنشئ ✓️\n"
end 
if redis:sismember(boss..'owners:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."❌¦ تم تنزيله من المدير ✓️\n"
end 
if redis:sismember(boss..'admins:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."❌¦ تم تنزيله من الادمن ✓️\n"
end 
if redis:sismember(boss..'whitelist:'..msg.chat_id_,UserID) then
DonisDown = DonisDown.."❌¦ تم تنزيله من العضو مميز ✓️\n"
end
function senddwon() sendMsg(msg.chat_id_,msg.id_,"📛*¦* عذرا المستخدم رتبته اعلى منك لا يمكن تنزيله \n❕") end
function sendpluse() sendMsg(msg.chat_id_,msg.id_,"📛*¦* عذرا لا يمكن تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." \n❕") end

if rinkuser == 8 then return sendMsg(msg.chat_id_,msg.id_,"📮¦ المستخدم  ⋙「 "..NameUser.." 」   \nانه بالتأكيد عضو \n✓️")  end
huk = false
if msg.SudoBase then 
redis:srem(boss..':SUDO_BOT:',UserID)
redis:srem(boss..':MONSHA_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.SudoUser then 
if rinkuser == 2 then return sendpluse() end
if rinkuser < 2 then return senddwon() end
redis:srem(boss..':MONSHA_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.SuperCreator then 
if rinkuser == 3 then return sendpluse() end
if rinkuser < 3 then return senddwon() end
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Creator then 
if rinkuser == 4 then return sendpluse() end
if rinkuser < 5 then return senddwon() end
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Director then 
if rinkuser == 5 then return sendpluse() end
if rinkuser < 5 then return senddwon() end
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Admin then 
if rinkuser == 6 then return sendpluse() end
if rinkuser < 6 then return senddwon() end
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
else
huk = true
end

if not huk then sendMsg(msg.chat_id_,msg.id_,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n"..DonisDown.."\n✓️") end

end,{msg=msg})
end,{msg=msg})
end


if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
if UserID == our_id then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يمكنك تنفيذ الامر مع البوت\n❕") end

msg = arg.msg
if UserID == 819385837 or UserID == 60809019 then return sendMsg(msg.chat_id_,msg.id_,"📛*¦* لآ يمكنك تنفيذ الامر ضد مطور السورس \n❕") end
NameUser = Hyper_Link_Name(data)

if UserID == SUDO_ID then 
rinkuser = 1
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
rinkuser = 2
elseif redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,UserID) then 
rinkuser = 3
elseif redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
rinkuser = 4
elseif redis:sismember(boss..'owners:'..msg.chat_id_,UserID) then 
rinkuser = 5
elseif redis:sismember(boss..'admins:'..msg.chat_id_,UserID) then 
rinkuser = 6
elseif redis:sismember(boss..'whitelist:'..msg.chat_id_,UserID) then 
rinkuser = 7
else
rinkuser = 8
end
local DonisDown = "\n📛¦ تم تنزيله من الرتب الاتيه : \n\n "
if redis:sismember(boss..':SUDO_BOT:',UserID) then 
DonisDown = DonisDown.."❌¦ تم تنزيله من المطور ✓️\n"
end 
if redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."❌¦ تم تنزيله من المنشئ الاساسي ✓️\n"
end 
if redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."❌¦ تم تنزيله من المنشئ ✓️\n"
end 
if redis:sismember(boss..'owners:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."❌¦ تم تنزيله من المدير ✓️\n"
end 
if redis:sismember(boss..'admins:'..msg.chat_id_,UserID) then 
DonisDown = DonisDown.."❌¦ تم تنزيله من الادمن ✓️\n"
end 
if redis:sismember(boss..'whitelist:'..msg.chat_id_,UserID) then
DonisDown = DonisDown.."❌¦ تم تنزيله من العضو مميز ✓️\n"
end

function senddwon() sendMsg(msg.chat_id_,msg.id_,"📛*¦* عذرا المستخدم رتبته اعلى منك لا يمكن تنزيله \n❕") end
function sendpluse() sendMsg(msg.chat_id_,msg.id_,"📛*¦* عذرا لا يمكن تنزيل رتبه مثل رتبتك : "..msg.TheRankCmd.." \n❕") end

if rinkuser == 8 then return sendMsg(msg.chat_id_,msg.id_,"📮¦ المستخدم  ⋙「 "..NameUser.." 」   \nانه بالتأكيد عضو \n✓️")  end
huk = false
if msg.SudoBase then 
redis:srem(boss..':SUDO_BOT:',UserID)
redis:srem(boss..':MONSHA_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.SudoUser then 
if rinkuser == 2 then return sendpluse() end
if rinkuser < 2 then return senddwon() end
redis:srem(boss..':MONSHA_Group:'..msg.chat_id_,UserID)
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.SuperCreator then 
if rinkuser == 3 then return sendpluse() end
if rinkuser < 3 then return senddwon() end
redis:srem(boss..':MONSHA_BOT:'..msg.chat_id_,UserID)
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Creator then 
if rinkuser == 4 then return sendpluse() end
if rinkuser < 5 then return senddwon() end
redis:srem(boss..'owners:'..msg.chat_id_,UserID)
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Director then 
if rinkuser == 5 then return sendpluse() end
if rinkuser < 5 then return senddwon() end
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
elseif msg.Admin then 
if rinkuser == 6 then return sendpluse() end
if rinkuser < 6 then return senddwon() end
redis:srem(boss..'admins:'..msg.chat_id_,UserID)
redis:srem(boss..'whitelist:'..msg.chat_id_,UserID)
else
huk = true
end

if not huk then sendMsg(msg.chat_id_,msg.id_,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n"..DonisDown.."\n✓️") end

end,{msg=msg})
end 

if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="DwnAll"}) 
end

return false
end



--=====================================================================================


if MsgText[1] == "قائمه الاوامر" then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
local list = redis:hgetall(boss..":AwamerBotArray2:"..msg.chat_id_)
local list2 = redis:hgetall(boss..":AwamerBotArray:"..msg.chat_id_)
message = "📋¦ الاوامر الجديد : \n\n" i = 0
for name,Course in pairs(list) do i = i + 1 message = message ..i..' - *{* '..name..' *}* ~> '..Course..' \n'  end 
if i == 0 then return "📛*¦* لا توجد اوامر مضافه في القائمه \n " end
return message
end


if MsgText[1] == "مسح الاوامر" then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
local Awammer 	= redis:del(boss..":AwamerBot:"..msg.chat_id_)
redis:del(boss..":AwamerBotArray:"..msg.chat_id_)
redis:del(boss..":AwamerBotArray2:"..msg.chat_id_)
if Awammer ~= 0 then
return "📭¦ تم مسح قائمه الاوامر \n..."
else
return "📛*¦* القائمه بالفعل ممسوحه \n"
end
end


if MsgText[1] == "تعيين امر" or MsgText[1] == "تعين امر" or MsgText[1] == "اضف امر" then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
if MsgText[2] then

local checkAmr = false
for k, Boss in pairs(XBoss) do if MsgText[2]:match(Boss) then  checkAmr = true end end      
if checkAmr then
redis:setex(boss..":Witting_changeamr:"..msg.chat_id_..msg.sender_user_id_,300,MsgText[2])
return "📭¦ حسننا عزيزي , لتغير امر {* "..MsgText[2].." *}  ارسل الامر الجديد الان \n..."
else
return "📛*¦* عذرا لا يوجد هذا الامر في البوت لتتمكن من تغييره  \n"
end
else
redis:setex(boss..":Witting_changeamr2:"..msg.chat_id_..msg.sender_user_id_,300,true)
return "📭¦ حسننا عزيزي , لتغير امر  ارسل الامر القديم الان \n..."
end
end

if MsgText[1] == "مسح امر"  then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
if MsgText[2] then
local checkk = redis:hdel(boss..":AwamerBotArray2:"..msg.chat_id_,MsgText[2])
local AmrOld = redis:hgetall(boss..":AwamerBotArray:"..msg.chat_id_)
amrnew = ""
amrold = ""
amruser = MsgText[2].." @user"
amrid = MsgText[2].." 23434"
amrklma = MsgText[2].." ffffff"
amrfile = MsgText[2].." fff.lua"
for Amor,ik in pairs(AmrOld) do
if MsgText[2]:match(Amor) then			
print("¦AMrnew : "..Amor,"¦AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amruser:match(Amor) then
print("¦AMrnew : "..Amor,"¦AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amrid:match(Amor) then
print("¦AMrnew : "..Amor,"¦AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amrklma:match(Amor) then
print("¦AMrnew : "..Amor,"¦AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amrfile:match(Amor) then
print("¦AMrnew : "..Amor,"¦AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
end
end
if checkk ~=0 then
return "📭¦ تم مسح الامر {* "..MsgText[2].." *} من قائمه الاومر \n..."
else
return "📪¦ هذا الامر ليس موجود ضمن الاوامر المضافه  \n"
end
else
redis:setex(boss..":Witting_AmrDel:"..msg.chat_id_..msg.sender_user_id_,300,true)
return "📭¦  ارسل الامر الجديد المضاف بالقوائم الان\n..."
end


end


--=====================================================================================


if msg.SudoBase then

if MsgText[1] == "نقل ملكيه البوت" or MsgText[1] == "نقل ملكيه البوت 📇" then
redis:setex(boss..":Witting_MoveBot:"..msg.chat_id_..msg.sender_user_id_,300,true)
return "📭¦ حسننا عزيزي  ✋🏿\n🗯¦ الان ارسل معرف المستخدم لنقل ملكية البوت له ."
end





if MsgText[1] == 'تعيين قائمه الاوامر' then 
redis:setex(boss..":Witting_awamr_witting"..msg.chat_id_..msg.sender_user_id_,1000,true)
return '📮*¦* ارسل امر القائمه المراد تعيينهم مثل الاتي "\n¦`الاوامر` , `م1` , `م2 `, `م3 `, `م المطور ` , `اوامر الرد `,  `اوامر الملفات` \n➼' 
end


if MsgText[1] == "رفع مطور" then
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then 
return sendMsg(ChatID,MsgID,"👤*¦* عذرا لا يمكنني رفع بوت \n📛") 
end
GetUserID(UserID,function(arg,data)
RUSERNAME = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..':SUDO_BOT:',arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه مطور  في البوت") 
else
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه مطور  في البوت") 
redis:hset(boss..'username:'..arg.UserID,'username',RUSERNAME)
redis:sadd(boss..':SUDO_BOT:',arg.UserID)
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end


if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
ReUsername = arg.UserName
NameUser = Hyper_Link_Name(data)
if redis:sismember(boss..':SUDO_BOT:',UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد رفعه مطور  في البوت") 
else
redis:hset(boss..'username:'..UserID,'username',ReUsername)
redis:sadd(boss..':SUDO_BOT:',UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم رفعه مطور  في البوت") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 


if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="up_sudo"}) 
end
return false
end

if MsgText[1] == "تنزيل مطور" then
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..':SUDO_BOT:',arg.UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله مطور  في البوت") 
else
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله مطور  في البوت") 
redis:srem(boss..':SUDO_BOT:',arg.UserID)
end  
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end
--================================================
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
NameUser = Hyper_Link_Name(data)
if not redis:sismember(boss..':SUDO_BOT:',UserID) then 
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم بالتأكيد تنزيله مطور  في البوت") 
else
redis:srem(boss..':SUDO_BOT:',UserID)
sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n📋¦ تم تنزيله مطور  في البوت") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="dn_sudo"}) 
end
return false
end

if MsgText[1] == "تنظيف المجموعات" then
local groups = redis:smembers(boss..'group:ids')
local GroupsIsFound = 0
for i = 1, #groups do 
GroupTitle(groups[i],function(arg,data)
if data.code_ and data.code_ == 400 then
rem_data_group(groups[i])
print(" Del Group From list ")
else
print(" Name Group : "..data.title_)
GroupsIsFound = GroupsIsFound + 1
end
print(GroupsIsFound..' : '..#groups..' : '..i)
if #groups == i then
local GroupDel = #groups - GroupsIsFound 
if GroupDel == 0 then
sendMsg(msg.chat_id_,msg.id_,'💯*¦* جـيـد , لا توجد مجموعات وهميه \n✓')
else
sendMsg(msg.chat_id_,msg.id_,'📑*¦* عدد المجموعات •⊱ { *'..#groups..'*  } ⊰•\n🚸*¦* تـم تنظيف  •⊱ { *'..GroupDel..'*  } ⊰• مجموعه \n📉*¦* اصبح العدد الحقيقي الان •⊱ { *'..GroupsIsFound..'*  } ⊰• مجموعه')
end
end
end)
end
return false
end
if MsgText[1] == "تنظيف المشتركين" then
local pv = redis:smembers(boss..'users')
local NumPvDel = 0
for i = 1, #pv do
GroupTitle(pv[i],function(arg,data)
sendChatAction(pv[i],"Typing",function(arg,data)
if data.ID and data.ID == "Ok"  then
print("Sender Ok")
else
print("Failed Sender Nsot Ok")
redis:srem(boss..'users',pv[i])
NumPvDel = NumPvDel + 1
end
if #pv == i then 
if NumPvDel == 0 then
sendMsg(msg.chat_id_,msg.id_,'👨🏼‍⚕️¦ جـيـد , لا يوجد مشتركين وهمي')
else
local SenderOk = #pv - NumPvDel
sendMsg(msg.chat_id_,msg.id_,'📑*¦* عدد المشتركين •⊱ { *'..#pv..'*  } ⊰•\n🚸*¦* تـم تنظيف  •⊱ { *'..NumPvDel..'*  } ⊰• مشترك \n📉*¦* اصبح العدد الحقيقي الان •⊱ { *'..SenderOk..'*  } ⊰• من المشتركين') 
end
end
end)
end)
end
return false
end
if MsgText[1] == "ضع صوره للترحيب" or MsgText[1]=="ضع صوره للترحيب 🌄" then
redis:setex(boss..'welcom_ph:witting'..msg.sender_user_id_,300,true) 
return'📭¦ حسننا عزيزي 🍁\n🌄 ¦ الان قم بارسال الصوره للترحيب \n🛠' 
end

if MsgText[1] == "تعطيل البوت خدمي"  or MsgText[1] == "تعطيل البوت خدمي 🚫" then 
return lock_service(msg) 
end

if MsgText[1] == "تفعيل البوت خدمي" or MsgText[1] == "تفعيل البوت خدمي 🔃" then 
return unlock_service(msg) 
end

if MsgText[1] == "صوره الترحيب" then
local Photo_Weloame = redis:get(boss..':WELCOME_BOT')
if Photo_Weloame then
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
if SUDO_USER:match('@[%a%d_]+') then 
SUDO_USERR = "⚖️¦ مـعرف آلمـطـور  » "..SUDO_USER.." 🌿\n👨🏽‍🔧"
else
SUDO_USERR = ""
end
sendPhoto(msg.chat_id_,msg.id_,Photo_Weloame,[[💯¦ مـرحبآ آنآ بوت آسـمـي ]]..redis:get(boss..':NameBot:')..[[ 🎖
💰¦ آختصـآصـي حمـآيهہ‏‏ آلمـجمـوعآت
📛¦ مـن آلسـبآم وآلتوجيهہ‏‏ وآلتگرآر وآلخ...
]]..SUDO_USERR) 
return false
else
return "📛¦ لا توجد صوره مضافه للترحيب في البوت \n📌¦ لاضافه صوره الترحيب ارسل `ضع صوره للترحيب`"
end
end

if MsgText[1] == "ضع كليشه المطور" then 
redis:setex(boss..'text_sudo:witting'..msg.sender_user_id_,1200,true) 
return '📭¦ حسننا عزيزي 🍁\n📋¦ الان قم بارسال الكليشه \n🛠' 
end

if MsgText[1] == "مسح كليشه المطور" then 
if not redis:get(boss..":TEXT_SUDO") then
return '⚙️¦ اوه 🙀 لا يوجد كليشه مطور اصلا ☹️\n🛠' end
redis:del(boss..':TEXT_SUDO') 
return '🙋🏼‍♂️¦ أهلا عزيزي '..msg.TheRank..'\n📛¦ تم مسح كليشه المطور\n✓' 
end


if MsgText[1] == "ضع شرط التفعيل" and MsgText[2] and MsgText[2]:match('^%d+$') then 
redis:set(boss..':addnumberusers',MsgText[2]) 
return '💱*¦* تم وضـع شـرط آلتفعيل آلبوت آذآ گآنت آلمـجمـوعهہ‏‏ آگثر مـن *【'..MsgText[2]..'】* عضـو  🍁\n' 
end

if MsgText[1] == "شرط التفعيل" then 
return'🚸*¦* شـرط آلتفعيل آلبوت آذآ گآنت آلمـجمـوعهہ‏‏ آگثر مـن *【'..redis:get(boss..':addnumberusers')..'】* عضـو  🍁\n' 
end 
end

if MsgText[1] == 'المجموعات' or MsgText[1] == "المجموعات 🔝" then 
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end
return '📮*¦* عدد المجموعات المفعلة » `'..redis:scard(boss..'group:ids')..'`  ➼' 
end

if MsgText[1] == 'مسح كليشه الايدي عام' or MsgText[1] == 'مسح الايدي عام' or MsgText[1] == 'مسح ايدي عام'  or MsgText[1] == 'مسح كليشة الايدي عام' or MsgText[1] == 'مسح كليشه الايدي عام 🗑' then 
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end
if not msg.SudoBase and not redis:get(boss.."lockidedit") then return "📛*¦* الامر معطل من قبل المطور الاساسي  \n" end
redis:del(boss..":infoiduser")
return sendMsg(msg.chat_id_,msg.id_,"📛*¦* تم مسح كليشة الايدي العام بنجاح \n❕")
end

if MsgText[1] == 'تعيين كليشه الايدي عام' or MsgText[1] == 'عام تعيين الايدي' or MsgText[1] == 'تعيين ايدي عام'  or MsgText[1] == 'تعيين كليشة الايدي عام'  or MsgText[1] == 'تعيين كليشه الايدي عام 📄' then 
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end
if not msg.SudoBase and not redis:get(boss.."lockidedit") then return "📛*¦* تعيين الايدي معطل من قبل المطور الاساسي  \n" end
redis:setex(boss..":Witting_KleshaID"..msg.chat_id_..msg.sender_user_id_,1000,true)
return '📮*¦* حسننا , الان ارسل كليشه الايدي الجديده \n علما ان الاختصارات كالاتي : \n \n{الاسم} : لوضع اسم المستخدم\n{الايدي} : لوضع ايدي المستخدم\n{المعرف} : لوضع معرف المستخدم \n{الرتبه} : لوضع نوع رتبه المستخدم \n{التفاعل} : لوضع تفاعل المستخدم \n{الرسائل} : لاضهار عدد الرسائل \n{النقاط} : لاضهار عدد النقاط \n{التعديل} : لاضهار عدد السحكات \n{البوت} : لاضهار اسم البوت\n{المطور} : لاضهار معرف المطور الاساسي\n قناه تعليمات ونشر كلايش الايدي \n قناه الكلايش : [@Change_id] \n➼' 
end


if MsgText[1] == 'قائمه المجموعات' then 
if not msg.SudoBase then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end
return chat_list(msg) 
end


if MsgText[1] == 'تعطيل' and MsgText[2] and MsgText[2]:match("(%d+)") then
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end
local idgrup = "-100"..MsgText[2]
local name_gp = redis:get(boss..'group:name'..idgrup)
GroupTitle(idgrup,function(arg,data)
if data.ID and data.ID == "Error" and data.message_ == "CHANNEL_INVALID" then
if redis:sismember(boss..'group:ids',arg.Group) then
rem_data_group(arg.Group)
sendMsg(arg.chat_id_,arg.id_,'📛*¦* البوت ليس بالمجموعة ولكن تم مسح بياناتها \n🏷*¦* المجموعةة » ['..arg.name_gp..']\n🎫*¦* الايدي » ( *'..arg.Group..'* )\n✓')
else 
sendMsg(arg.chat_id_,arg.id_,'📛*¦* البوت ليس مفعل بالمجموعه ♨️\n🔙*¦* ولا يوجد بيانات لها ✓️')
end
else
StatusLeft(arg.Group,our_id)
if redis:sismember(boss..'group:ids',arg.Group) then
sendMsg(arg.Group,0,'📛*¦* تم تعطيل المجموعه بأمر من المطور  \n🚸*¦* سوف اغادر جاوو 🚶🏻🚶🏻 ...\n✘')
rem_data_group(arg.Group)
sendMsg(arg.chat_id_,arg.id_,'📛*¦* تم تعطيل المجموعه ومغادرتها \n🏷*¦* المجموعةة » ['..arg.name_gp..']\n🎫*¦* الايدي » ( *'..arg.Group..'* )\n✓')
else 
sendMsg(arg.chat_id_,arg.id_,'📛*¦* البوت ليس مفعل بالمجموعة \n🎫*¦* ولكن تم مغادرتها\n🏷*¦* المجموعةة » ['..arg.name_gp..']\n✓')
end
end 
end,{chat_id_=msg.chat_id_,id_=msg.id_,Group=idgrup,name_gp=name_gp})
return false
end

if MsgText[1] == 'المطور' then
GetUserID(SUDO_ID,function(arg,data)
local SUDO_NAME = '['..Flter_Markdown(data.first_name_..' '..(data.last_name_ or ""))..'](tg://user?id='..SUDO_ID..')'
return send_msg(msg.chat_id_,redis:get(boss..":TEXT_SUDO") or SUDO_NAME,msg.id_)
end,nil)
end

if MsgText[1] == "اذاعه بالتثبيت"  or MsgText[1] =="اذاعه بالتثبيت 📬" then
if not msg.SudoUser then return"📪¦ هذا الامر يخص {المطور} فقط  \n" end
redis:setex(boss..':prod_pin:'..msg.chat_id_..msg.sender_user_id_,300, true) 
return "📭¦ حسننا الان ارسل رساله ليتم اذاعتها بالتثبيت  \n🔛" 
end

if MsgText[1] == "اذاعه عام بالتوجيه" or MsgText[1] == "اذاعه عام بالتوجيه 📣" then
if not msg.SudoUser then return"📪¦ هذا الامر يخص {المطور} فقط  \n" end
if not msg.SudoBase and not redis:get(boss..'lock_brod') then 
return "📡*¦* الاذاعه مقفوله من قبل المطور الاساسي  🚶" 
end
redis:setex(boss..'fwd:'..msg.sender_user_id_,300, true) 
return "📭¦ حسننا الان ارسل التوجيه للاذاعه \n🔛" 
end

if MsgText[1] == "اذاعه عام" or MsgText[1] == "اذاعه عام 📢" then		
if not msg.SudoUser then return"📪¦ هذا الامر يخص {المطور} فقط  \n" end
if not msg.SudoBase and not redis:get(boss..'lock_brod') then 
return "📡*¦* الاذاعه مقفوله من قبل المطور الاساسي  🚶" 
end
redis:setex(boss..'fwd:all'..msg.sender_user_id_,300, true) 
return "📭¦ حسننا الان ارسل الكليشه للاذاعه عام \n🔛" 
end

if MsgText[1] == "اذاعه خاص" or MsgText[1] == "اذاعه خاص 👤" then		
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end
if not msg.SudoBase and not redis:get(boss..'lock_brod') then 
return "📡*¦* الاذاعه مقفوله من قبل المطور الاساسي  🚶" 
end
redis:setex(boss..'fwd:pv'..msg.sender_user_id_,300, true) 
return "📭¦ حسننا الان ارسل الكليشه للاذاعه خاص \n🔛"
end

if MsgText[1] == "اذاعه" or MsgText[1] == "اذاعه 🗣" then		
if not msg.SudoUser then return"📪¦ هذا الامر يخص {المطور} فقط  \n" end
if not msg.SudoBase and not redis:get(boss..'lock_brod') then 
return "📡*¦* الاذاعه مقفوله من قبل المطور الاساسي  🚶" 
end
redis:setex(boss..'fwd:groups'..msg.sender_user_id_,300, true) 
return "📭¦ حسننا الان ارسل الكليشه للاذاعه للمجموعات \n🔛" 
end

if MsgText[1] == "المطورين" or MsgText[1] == "المطورين 🕹" then
if not msg.SudoUser then return"📪¦ هذا الامر يخص {المطور} فقط  \n" end
return sudolist(msg) 
end

if MsgText[1] == "قائمه العام" or MsgText[1]=="قائمه العام 📜" then 
if not msg.SudoUser then return"📪¦ هذا الامر يخص {المطور} فقط  \n" end
return GetListGeneralBanned(msg) 
end

if MsgText[1] == "تعطيل التواصل" or MsgText[1]=="تعطيل التواصل ✖️" then 
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
return lock_twasel(msg) 
end

if MsgText[1] == "تفعيل التواصل" or MsgText[1]=="تفعيل التواصل 🔛" then 
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
return unlock_twasel(msg) 
end

if MsgText[1] == "حظر عام" then
if not msg.SudoBase then return "📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر البوت\n🛠") 
elseif  UserID == 819385837 or UserID == 60809019 then 
return sendMsg(arg.ChatID,arg.MsgID,"⚜️*¦* لا يمكنك حظر مطور السورس\n🛠")
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المطور الاساسي\n🛠")
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المطور\n🛠") 
end
GetUserID(UserID,function(arg,data)
NameUser = Hyper_Link_Name(data)
USERNAME = ResolveUserName(data)
if GeneralBanned(arg.UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد حظره عام  من المجموعات \n✓") 
else
redis:hset(boss..'username:'..arg.UserID,'username',USERNAME)
redis:sadd(boss..'gban_users',arg.UserID)
kick_user(arg.UserID,arg.ChatID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم حظره عام  من المجموعات \n✓") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.id_})
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
UserName = arg.UserName
NameUser = Hyper_Link_Name(data)

if UserID == our_id then   
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر البوت\n🛠") 
elseif  UserID == 819385837 or UserID == 60809019 then 
return sendMsg(arg.ChatID,arg.MsgID,"⚜️*¦* لا يمكنك حظر مطور السورس\n🛠")
elseif UserID == SUDO_ID then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المطور الاساسي\n🛠")
elseif redis:sismember(boss..':SUDO_BOT:',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* لا يمكنك حظر المطور\n🛠") 
end
if redis:sismember(boss..'gban_users',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد حظره عام  من المجموعات \n✓") 
else
redis:hset(boss..'username:'..UserID,'username',UserName)
redis:sadd(boss..'gban_users',UserID)
kick_user(UserID,arg.ChatID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم حظره عام  من المجموعات \n✓") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="bandall"}) 
end
return false
end

if MsgText[1] == "الغاء العام" or MsgText[1] == "الغاء عام" then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end

if not MsgText[2] and msg.reply_id then 
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.sender_user_id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* عذرا هذا العضو ليس موجود ضمن المجموعات \n❕") end
local UserID = data.sender_user_id_
GetUserID(UserID,function(arg,data)
USERNAME = ResolveUserName(data)
NameUser = Hyper_Link_Name(data)

if GeneralBanned(arg.UserID) then 
redis:srem(boss..'gban_users',arg.UserID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد الغاء حظره العام  من المجموعات \n✓") 
else
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم الغاء حظره العام  من المجموعات \n✓") 
end
end,{ChatID=arg.ChatID,UserID=UserID,MsgID=arg.MsgID})
end,{ChatID=msg.chat_id_,MsgID=msg.reply_id})
end
if MsgText[2] and MsgText[2]:match('^%d+$') then 
GetUserID(MsgText[2],action_by_id,{msg=msg,cmd="unbandall"}) 
end
if MsgText[2] and MsgText[2]:match('@[%a%d_]+') then 
GetUserName(MsgText[2],function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
local UserID = data.id_
UserName = arg.UserName
NameUser = Hyper_Link_Name(data)

if not redis:sismember(boss..'gban_users',UserID) then 
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم بالتأكيد الغاء حظره العام  من المجموعات \n✓") 
else
redis:srem(boss..'gban_users',UserID)
return sendMsg(arg.ChatID,arg.MsgID,"📮¦ المستخدم  ⋙「 "..NameUser.." 」 \n⛔️¦ تم الغاء حظره العام  من المجموعات \n✓") 
end
end,{ChatID=msg.chat_id_,MsgID=msg.id_,UserName=MsgText[2]})
end 
return false
end 

if MsgText[1] == "رتبتي" then return '🎫*¦* رتبتك » '..msg.TheRank..'\n➖' end

----------------- استقبال الرسائل ---------------
if MsgText[1] == "الغاء الامر ✖️" or MsgText[1] == "الغاء" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
redis:del(boss..'welcom:witting'..msg.chat_id_..msg.sender_user_id_,
boss..'rulse:witting'..msg.chat_id_..msg.sender_user_id_,
boss..'name:witting'..msg.chat_id_..msg.sender_user_id_,
boss..'about:witting'..msg.chat_id_..msg.sender_user_id_,
boss..'fwd:all'..msg.sender_user_id_,
boss..'fwd:pv'..msg.sender_user_id_,
boss..'fwd:groups'..msg.sender_user_id_,
boss..'namebot:witting'..msg.sender_user_id_,
boss..'addrd_all:'..msg.sender_user_id_,
boss..'delrd:'..msg.sender_user_id_,
boss..'addrd:'..msg.sender_user_id_,
boss..'delrdall:'..msg.sender_user_id_,
boss..'text_sudo:witting'..msg.sender_user_id_,
boss..":Witting_KleshaID"..msg.chat_id_..msg.sender_user_id_,
boss..":Witting_KleshaID_public"..msg.chat_id_..msg.sender_user_id_,
boss..":Witting_awamr_witting"..msg.chat_id_..msg.sender_user_id_,
boss..'addrd:'..msg.chat_id_..msg.sender_user_id_,
boss..':KStart:'..msg.chat_id_..msg.sender_user_id_,
boss.."WiCmdLink"..msg.chat_id_..msg.sender_user_id_,
boss..":uploadingsomeon:"..msg.chat_id_..msg.sender_user_id_,
boss..":uploadingsomeon2:"..msg.chat_id_..msg.sender_user_id_,
boss..":Witting_changeamr:"..msg.chat_id_..msg.sender_user_id_,
boss..":Witting_changeamr2:"..msg.chat_id_..msg.sender_user_id_,
boss..":Witting_MoveBot:"..msg.chat_id_..msg.sender_user_id_,
boss..":firstAmrOld:"..msg.chat_id_..msg.sender_user_id_,
boss..':prod_pin:'..msg.chat_id_..msg.sender_user_id_,
boss..":ForceSub:"..msg.sender_user_id_,
boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_,
boss..'addrdRandom1:'..msg.chat_id_..msg.sender_user_id_,
boss..'addrdRandom:'..msg.chat_id_..msg.sender_user_id_,
boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_,
boss..'addrdRandom1:'..msg.sender_user_id_,
boss..'addrdRandom:'..msg.sender_user_id_,
boss..'replay1Random'..msg.sender_user_id_)

return '📬*¦* تم آلغآء آلآمـر بنجآح \n🌿'
end  

if (MsgText[1] == '/files' or MsgText[1]== "الملفات 🗂" or MsgText[1]== "الملفات" ) then
if not msg.SudoBase then return "📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
return All_File()
end   


if MsgText[1] == 'اصدار السورس' or MsgText[1] == 'الاصدار' then
return '👨🏾‍🔧¦ اصدار سورس الزعيم : *v'..version..'* \n📡'
end

if (MsgText[1] == 'تحديث السورس' or MsgText[1] == 'تحديث السورس ™') then
if not msg.SudoBase then return "📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
local GetVerison = https.request('https://th3bs.github.io/GetVersion.txt') or "0"
GetVerison = GetVerison:gsub("\n",""):gsub(" ","")
if GetVerison > version then
UpdateSourceStart = true
sendMsg(msg.chat_id_,msg.id_,'🔛*¦* يوجد تحديث جديد الان \n📡*¦* جاري تنزيل وتثبيت التحديث  ...')
redis:set(boss..":VERSION",GetVerison)
return false
else
return "🔖¦ الاصدار الحالي : *v"..version.."* \n👨🏾‍🔧*¦* لديـك احدث اصدار \n📦"
end
return false
end


if MsgText[1] == 'نسخه احتياطيه للمجموعات' then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
return buck_up_groups(msg)
end 

if MsgText[1] == 'رفع نسخه الاحتياطيه' then
if not msg.SudoBase then return "📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
if msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg, data)
if data.content_.ID == 'MessageDocument' then
local file_name = data.content_.document_.file_name_
if file_name:match('.json')then
if file_name:match('@[%a%d_]+.json') then
if file_name:lower():match('@[%a%d_]+') == Bot_User:lower() then 
io.popen("rm -f ../.telegram-cli/data/document/*")
local file_id = data.content_.document_.document_.id_ 
tdcli_function({ID = "DownloadFile",file_id_ = file_id},function(arg, data) 
if data.ID == "Ok" then
Uploaded_Groups_Ok = true
Uploaded_Groups_CH = arg.chat_id_
Uploaded_Groups_MS = arg.id_
print(Uploaded_Groups_CH)
print(Uploaded_Groups_MS)
sendMsg(arg.chat_id_,arg.id_,'⏳*┇* جاري رفع النسخه انتظر قليلا ... \n⌛️')
end
end,{chat_id_=arg.chat_id_,id_=arg.id_})
else 
sendMsg(arg.chat_id_,arg.id_,"📛*¦* عذرا النسخه الاحتياطيه هذا ليست للبوت » ["..Bot_User.."]  \n❕")
end
else 
sendMsg(arg.chat_id_,arg.id_,'📛*¦* عذرا اسم الملف غير مدعوم للنظام او لا يتوافق مع سورس الزعيم يرجى جلب الملف الاصلي الذي قمت بسحبه وبدون تعديل ع الاسم\n❕')
end  
else
sendMsg(arg.chat_id_,arg.id_,'📛*¦* عذرا الملف ليس بصيغه Json !?\n❕')
end 
else
sendMsg(arg.chat_id_,arg.id_,'📛*¦* عذرا هذا ليس ملف النسحه الاحتياطيه للمجموعات\n❕')
end 
end,{chat_id_=msg.chat_id_,id_=msg.id_})
else 
return "📦*¦* ارسل ملف النسخه الاحتياطيه اولا\n📑*¦* ثم قم بالرد على الملف وارسل \" `رفع نسخه الاحتياطيه` \" "
end 
return false
end

if (MsgText[1]=="تيست" or MsgText[1]=="test") then 
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
return "💯 البوت شـغــال 🚀" 
end

if (MsgText[1]== "ايدي" or MsgText[1]=="ايدي 🆔") and msg.type == "pv" then return  "\n"..msg.sender_user_id_.."\n"  end

if MsgText[1]== "قناة السورس 📡" and msg.type == "pv" then
local inline = {{{text="قنآهہ‏‏ آلسـورس : الـزعـيـم 🍃",url="t.me/th3bs"}}}
send_key(msg.sender_user_id_,'  [قناة السورس : الـزعـيـم](t.me/th3bs)',nil,inline,msg.id_)
return false
end

if (MsgText[1]== "الاحصائيات 📈" or MsgText[1]=="الاحصائيات") then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
return 'الاحصائيات : 📈 \n\n👥*¦* عدد المجموعات المفعله : '..redis:scard(boss..'group:ids')..'\n👤*¦* عدد المشتركين في البوت : '..redis:scard(boss..'users')..'\n📡'
end
---------------[End Function data] -----------------------
if MsgText[1]=="اضف رد عام" or MsgText[1]=="اضف رد عام ➕" then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
redis:setex(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_,300,true)
redis:del(boss..'allreplay:'..msg.chat_id_..msg.sender_user_id_)
return "📭¦ حسننا الان ارسل كلمة الرد العام 🍃\n"
end

---------------[End Function data] -----------------------
if MsgText[1] == "تعيين كليشه الستارت" or MsgText[1] == "تعيين كليشة الستارت" or MsgText[1] == "تعيين كليشه الستارت 📱" then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
redis:setex(boss..':KStart:'..msg.chat_id_..msg.sender_user_id_,900,true)
return "📭¦ حسننا الان ارسل كليشة الستارت \n\n علما ان الاختصارات كالاتي : \n \n{الاسم} : لوضع اسم المستخدم\n{الايدي} : لوضع ايدي المستخدم\n{المعرف} : لوضع معرف المستخدم \n{الرتبه} : لوضع نوع رتبه المستخدم \n{البوت} : لاضهار اسم البوت \n{المطور} : لاضهار معرف المطور الاساسي ."
end
if MsgText[1] == "مسح كليشه الستارت" or MsgText[1] == "مسح كليشة الستارت" or MsgText[1] == "مسح كليشه الستارت 🗑" then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
redis:del(boss..':Text_Start')
return "📭¦ تم مسح كليشه الستارت "
end

if MsgText[1]== 'مسح' and MsgText[2]== 'الردود' then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
local names 	= redis:exists(boss..'replay:'..msg.chat_id_)
local photo 	= redis:exists(boss..'replay_photo:group:'..msg.chat_id_)
local voice 	= redis:exists(boss..'replay_voice:group:'..msg.chat_id_)
local imation   = redis:exists(boss..'replay_animation:group:'..msg.chat_id_)
local audio	 	= redis:exists(boss..'replay_audio:group:'..msg.chat_id_)
local sticker 	= redis:exists(boss..'replay_sticker:group:'..msg.chat_id_)
local video 	= redis:exists(boss..'replay_video:group:'..msg.chat_id_)
local file 	= redis:exists(boss..'replay_files:group:'..msg.chat_id_)
if names or photo or voice or imation or audio or sticker or video or file then
redis:del(boss..'replay:'..msg.chat_id_,boss..'replay_photo:group:'..msg.chat_id_,boss..'replay_voice:group:'..msg.chat_id_,
boss..'replay_animation:group:'..msg.chat_id_,boss..'replay_audio:group:'..msg.chat_id_,boss..'replay_sticker:group:'..msg.chat_id_,boss..'replay_video:group:'..msg.chat_id_,boss..'replay_files:group:'..msg.chat_id_)
return "✓ تم مسح كل الردود 🚀"
else
return '🚸*¦* لا يوجد ردود ليتم مسحها \n❕'
end
end

if MsgText[1] == 'مسح' and MsgText[2] == 'الردود العامه' then
if not msg.SudoBase then return"♨️ للمطورين فقط ! 💯" end
local names 	= redis:exists(boss..'replay:all')
local photo 	= redis:exists(boss..'replay_photo:group:')
local voice 	= redis:exists(boss..'replay_voice:group:')
local imation 	= redis:exists(boss..'replay_animation:group:')
local audio 	= redis:exists(boss..'replay_audio:group:')
local sticker 	= redis:exists(boss..'replay_sticker:group:')
local video 	= redis:exists(boss..'replay_video:group:')
local file 	= redis:exists(boss..'replay_files:group:')
if names or photo or voice or imation or audio or sticker or video or file then
redis:del(boss..'replay:all',boss..'replay_photo:group:',boss..'replay_voice:group:',boss..'replay_animation:group:',boss..'replay_audio:group:',boss..'replay_sticker:group:',boss..'replay_video:group:',boss..'replay_files:group:')
return "✓ تم مسح كل الردود العامه🚀"
else
return "لا يوجد ردود عامه ليتم مسحها ! 🚀"
end
end

if MsgText[1]== 'مسح' and MsgText[2]== 'رد عام' then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
redis:set(boss..'delrdall:'..msg.sender_user_id_,true) 
return "📭¦ حسننا عزيزي  ✋🏿\n🗯¦ الان ارسل الرد لمسحها من  المجموعات 🍃"
end

if MsgText[1]== 'مسح' and MsgText[2]== 'رد' then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
redis:set(boss..'delrd:'..msg.sender_user_id_,true)
return "📭¦ حسننا عزيزي  ✋🏿\n🗯¦ الان ارسل الرد لمسحها من  للمجموعه 🍃"
end

if MsgText[1]== 'الردود' then

if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
local names  	= redis:hkeys(boss..'replay:'..msg.chat_id_)
local photo 	= redis:hkeys(boss..'replay_photo:group:'..msg.chat_id_)
local voice  	= redis:hkeys(boss..'replay_voice:group:'..msg.chat_id_)
local imation 	= redis:hkeys(boss..'replay_animation:group:'..msg.chat_id_)
local audio 	= redis:hkeys(boss..'replay_audio:group:'..msg.chat_id_)
local sticker 	= redis:hkeys(boss..'replay_sticker:group:'..msg.chat_id_)
local video 	= redis:hkeys(boss..'replay_video:group:'..msg.chat_id_)
local files 	= redis:hkeys(boss..'replay_files:group:'..msg.chat_id_)
if #names==0 and #photo==0 and #voice==0 and #imation==0 and #audio==0 and #sticker==0 and #video==0 and #files==0  then 
return '🚸*¦* لا يوجد ردود مضافه حاليا \n❕' 
end
local ii = 1
local message = '🛑*¦* ردود البوت في المجموعه  :\n\n'
for i=1, #photo 	do message = message ..ii..' - *{* '..	photo[i]..' *}_*( صوره 🏞 ) \n' 	 ii = ii + 1 end
for i=1, #names 	do message = message ..ii..' - *{* '..	names[i]..' *}_*( نص 🗯 ) \n'  	 ii = ii + 1 end
for i=1, #voice 	do message = message ..ii..' - *{* '..  voice[i]..' *}_*( بصمه 🎙 ) \n' 	 ii = ii + 1 end
for i=1, #imation 	do message = message ..ii..' - *{* '..imation[i]..' *}_*( متحركه 🎭 ) \n' ii = ii + 1 end
for i=1, #audio 	do message = message ..ii..' - *{* '..	audio[i]..' *}_*( صوتيه 🔊 ) \n'  ii = ii + 1 end
for i=1, #sticker 	do message = message ..ii..' - *{* '..sticker[i]..' *}_*( ملصق 🗺 ) \n' 	 ii = ii + 1 end
for i=1, #video 	do message = message ..ii..' - *{* '..	video[i]..' *}_*( فيديو  🎞 ) \n' ii = ii + 1 end
for i=1, #files 	do message = message ..ii..' - *{* '..	files[i]..' *}_*( ملف 🗂 ) \n' ii = ii + 1 end
message = message..'\n➖➖➖'
if utf8.len(message) > 4096 then
return "📛¦ لا يمكن عرض الردود بسبب القائمه كبيره جدا ."
else
return message
end
end

if MsgText[1]== 'الردود العامه' or MsgText[1]=='الردود العامه 🗨' then
if not msg.SudoBase then return "♨️ للمطور فقط ! 💯" end
local names 	= redis:hkeys(boss..'replay:all')
local photo 	= redis:hkeys(boss..'replay_photo:group:')
local voice 	= redis:hkeys(boss..'replay_voice:group:')
local imation 	= redis:hkeys(boss..'replay_animation:group:')
local audio 	= redis:hkeys(boss..'replay_audio:group:')
local sticker 	= redis:hkeys(boss..'replay_sticker:group:')
local video 	= redis:hkeys(boss..'replay_video:group:')
local files 	= redis:hkeys(boss..'replay_files:group:')
if #names==0 and #photo==0 and #voice==0 and #imation==0 and #audio==0 and #sticker==0 and #video==0 and #files==0 then 
return '🚸*¦* لا يوجد ردود مضافه حاليا \n❕' 
end
local ii = 1
local message = '🛑*¦* الردود العامه في البوت :   :\n\n'
for i=1, #photo 	do message = message ..ii..' - *{* '..	photo[i]..' *}_*( صوره 🏞 ) \n' 	ii = ii + 1 end
for i=1, #names 	do message = message ..ii..' - *{* '..	names[i]..' *}_*( نص 🗯 ) \n'  	ii = ii + 1 end
for i=1, #voice 	do message = message ..ii..' - *{* '..	voice[i]..' *}_*( بصمه 🎙 ) \n' 	ii = ii + 1 end
for i=1, #imation 	do message = message ..ii..' - *{* '..imation[i]..' *}_*( متحركه 🎭 ) \n'ii = ii + 1 end
for i=1, #audio 	do message = message ..ii..' - *{* '..	audio[i]..' *}_*( صوتيه 🔊 ) \n' ii = ii + 1 end
for i=1, #sticker 	do message = message ..ii..' - *{* '..sticker[i]..' *}_*( ملصق 🗺 ) \n' 	ii = ii + 1 end
for i=1, #video 	do message = message ..ii..' - *{* '..	video[i]..' *}_*( فيديو  🎞 ) \n'ii = ii + 1 end
for i=1, #files 	do message = message ..ii..' - *{* '..	files[i]..' *}_*( ملف 🗂 ) \n' ii = ii + 1 end
message = message..'\n➖➖➖'
if utf8.len(message) > 4096 then
return "📛¦ لا يمكن عرض الردود بسبب القائمه كبيره جدا ."
else
return message
end
end

----=================================| كود الرد العشوائي المجموعات|===============================================
if MsgText[1]=="اضف رد عشوائي" and msg.GroupActive then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
redis:setex(boss..'addrdRandom1:'..msg.chat_id_..msg.sender_user_id_,1400,true) 
redis:del(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_)
return "📭¦ حسننا ,  الان ارسل كلمه الرد للعشوائي \n-"
end


if MsgText[1]== "مسح رد عشوائي" then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
redis:setex(boss..':DelrdRandom:'..msg.chat_id_..msg.sender_user_id_,300,true)
return "📭¦ حسننا عزيزي  ✋🏿\n🗯¦ الان ارسل الرد العشوائي لمسحها 🍃"
end


if MsgText[1] == "مسح الردود العشوائيه" then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  " end
local AlRdod = redis:smembers(boss..':KlmatRRandom:'..msg.chat_id_) 
if #AlRdod == 0 then return "🛑*¦* الردود العشوائيه محذوفه بالفعل\n✓" end
for k,v in pairs(AlRdod) do redis:del(boss..':ReplayRandom:'..msg.chat_id_..":"..v) redis:del(boss..':caption_replay:Random:'..msg.chat_id_..v) 
end
redis:del(boss..':KlmatRRandom:'..msg.chat_id_) 
return "🙋🏼‍♂️*¦* أهلا عزيزي "..msg.TheRankCmd.."  \n🛑*¦* تم مسح جميع الردود العشوائيه\n✓"
end

if MsgText[1] == "الردود العشوائيه" then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  " end
message = "📜| الردود العشـوائيه :\n\n"
local AlRdod = redis:smembers(boss..':KlmatRRandom:'..msg.chat_id_) 
if #AlRdod == 0 then 
message = message .."📛| لا توجد ردود عشوائيه مضافه !\n"
else
for k,v in pairs(AlRdod) do
local incrr = redis:scard(boss..':ReplayRandom:'..msg.chat_id_..":"..v) 
message = message..k..'- ['..v..'] ⋙ •⊱ {*'..incrr..'*} ⊰• رد\n'
end
end
return message.."\n"
end
----=================================|نهايه كود الرد العشوائي المجموعات|===============================================

----=================================|كود الرد العشوائي العام|===============================================

if MsgText[1]=="اضف رد عشوائي عام" then
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end
redis:setex(boss..'addrdRandom1Public:'..msg.chat_id_..msg.sender_user_id_,1400,true) 
redis:del(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_)
return "📭¦ حسننا ,  الان ارسل كلمه الرد للعشوائي العام \n-"
end


if MsgText[1]== "مسح رد عشوائي عام" then
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end
redis:setex(boss..':DelrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_,300,true)
return "📭¦ حسننا عزيزي  ✋🏿\n🗯¦ الان ارسل الرد العشوائي العام لمسحها 🍃"
end

if MsgText[1] == "مسح الردود العشوائيه العامه" then
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end
local AlRdod = redis:smembers(boss..':KlmatRRandom:') 
if #AlRdod == 0 then return "🛑*¦* الردود العشوائيه محذوفه بالفعل\n✓" end
for k,v in pairs(AlRdod) do redis:del(boss..":ReplayRandom:"..v) redis:del(boss..':caption_replay:Random:'..v)  end
redis:del(boss..':KlmatRRandom:') 
return "🙋🏼‍♂️*¦* أهلا عزيزي "..msg.TheRankCmd.."  \n🛑*¦* تم مسح جميع الردود العشوائيه\n✓"
end

if MsgText[1] == "الردود العشوائيه العام" then
if not msg.SudoUser then return "📪¦ هذا الامر يخص {المطور} فقط  \n" end
message = "📜| الردود العشـوائيه العام :\n\n"
local AlRdod = redis:smembers(boss..':KlmatRRandom:') 
if #AlRdod == 0 then 
message = message .."📛| لا توجد ردود عشوائيه مضافه !\n"
else
for k,v in pairs(AlRdod) do
local incrr = redis:scard(boss..":ReplayRandom:"..v) 
message = message..k..'- ['..v..'] ⋙ •⊱ {*'..incrr..'*} ⊰• رد\n'
end
end
return message.."\n"
end

----=================================|نهايه كود الرد العشوائي العام|===============================================


if MsgText[1]=="اضف رد" and msg.GroupActive then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
redis:setex(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_,300,true) 
redis:del(boss..'replay1'..msg.chat_id_..msg.sender_user_id_)
return "📭¦ حسننا , الان ارسل كلمه الرد \n-"
end

if MsgText[1] == "ضع اسم للبوت" or MsgText[1]== 'ضع اسم للبوت ©' then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
redis:setex(boss..'namebot:witting'..msg.sender_user_id_,300,true)
return"📭¦ حسننا عزيزي  ✋🏿\n🗯¦ الان ارسل الاسم  للبوت 🍃"
end

if MsgText[1] == 'server' then
if not msg.SudoUser then return "For Sudo Only." end
return io.popen([[

linux_version=`lsb_release -ds 2>/dev/null || cat /etc/*release 2>/dev/null | head -n1 || uname -om`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`

echo '📟 •⊱ { Seystem } ⊰•\n*»» '"$linux_version"'*' 
echo '*------------------------------\n*🔖 •⊱ { Memory } ⊰•\n*»» '"$memUsedPrc"'*'
echo '*------------------------------\n*💾 •⊱ { HardDisk } ⊰•\n*»» '"$HardDisk"'*'
echo '*------------------------------\n*⚙️ •⊱ { Processor } ⊰•\n*»» '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*------------------------------\n*📡 •⊱ { Location } ⊰•\n*»» '`curl http://th3boss.com/ip/location`'*'
echo '*------------------------------\n*👨🏾‍🔧 •⊱ { Server[_]Login } ⊰•\n*»» '`whoami`'*'
echo '*------------------------------\n*🔌 •⊱ { Uptime } ⊰•  \n*»» '"$uptime"'*'
]]):read('*all')
end


if MsgText[1] == 'السيرفر' then
if not msg.SudoUser then return "For Sudo Only." end
return io.popen([[

linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`

echo '📟l •⊱ { نظام التشغيل } ⊰•\n*»» '"$linux_version"'*' 
echo '*------------------------------\n*🔖l •⊱ { الذاكره العشوائيه } ⊰•\n*»» '"$memUsedPrc"'*'
echo '*------------------------------\n*💾l •⊱ { وحـده الـتـخـزيـن } ⊰•\n*»» '"$HardDisk"'*'
echo '*------------------------------\n*⚙️l •⊱ { الـمــعــالــج } ⊰•\n*»» '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*------------------------------\n*📡l •⊱ { موقـع الـسـيـرفـر } ⊰•\n*»» '`curl http://th3boss.com/ip/location`'*'
echo '*------------------------------\n*👨🏾‍🔧l •⊱ { الــدخــول } ⊰•\n*»» '`whoami`'*'
echo '*------------------------------\n*🔌l •⊱ { مـده تـشغيـل الـسـيـرفـر } ⊰•  \n*»» '"$uptime"'*'
]]):read('*all')
end



if msg.type == 'channel' and msg.GroupActive then

if msg.SudoBase and (MsgText[1]=="م1" or MsgText[1]=="م2" or MsgText[1]=="م3" or MsgText[1]=="م المطور" or MsgText[1]=="اوامر الرد" or MsgText[1]=="الاوامر" or MsgText[1]=="اوامر الملفات") and redis:get(boss..":Witting_awamr_witting"..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss..":Witting_awamr_witting"..msg.chat_id_..msg.sender_user_id_)
redis:setex(boss..":changawmer:"..msg.chat_id_..msg.sender_user_id_,900,MsgText[1])
sendMsg(msg.chat_id_,msg.id_,"🔖¦ حسننا لتعيين كليشة الـ *"..MsgText[1].."* \n📮¦ ارسل الكليشه الجديده الان \n\n علما يمكنك استخدام الاختصارات الاتي : \n \n{الاسم} : لوضع اسم المستخدم\n{الايدي} : لوضع ايدي المستخدم\n{المعرف} : لوضع معرف المستخدم \n{الرتبه} : لوضع نوع رتبه المستخدم \n{التفاعل} : لوضع تفاعل المستخدم \n{الرسائل} : لاضهار عدد الرسائل \n{النقاط} : لاضهار عدد النقاط \n{التعديل} : لاضهار عدد السحكات \n{البوت} : لاضهار اسم البوت\n{المطور} : لاضهار معرف المطور الاساسي\n➼")
return false
end



if MsgText[1] == "الاوامر" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
text = [[☑️ اهلا بك في اوامر البوت 👇
📨 للاستفسار - []]..SUDO_USER..[[]

• م1 - لعرض اوامر الاداره
• م2 - لعرض اوامر اعدادات المجموعه
• م3 - لعرض اوامر الحماية
• م المطور - لعرض اوامر المطور
• اوامر الرد - لاضافه رد معين
• اوامر الملفات - للتحكم في ملفات البوت]]
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_m:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
sendMsg(msg.chat_id_,msg.id_,textD)
end,{msg=msg})
return false
end

if MsgText[1]== 'م1' then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
local text = [[☑️ اهلا بك في قائمة اوامر الاداريين
📨 للاستفسار - []]..SUDO_USER..[[]

﹎﹎﹎﹎﹎اوامر الرفع والتنزيل﹎﹎﹎﹎﹎
• رفع - تنزيل منشى اساسي
• رفع - تنزيل مشرف
• رفع - تنزيل منشى
• رفع - تنزيل مدير
• رفع - تنزيل ادمن
• رفع - تنزيل مميز
• تنزيل الكل - لأزاله جميع الرتب أعلاه

﹎﹎﹎﹎﹎اوامر المسح﹎﹎﹎﹎﹎
• مسح المنشئين الاساسيين
• مسح المنشئين
• مسح المدراء
• مسح الادمنيه
• مسح المميزين
• مسح المحظورين
• مسح المكتومين
• مسح قائمه العام
• مسح قائمه المنع
• مسح الردود العامه
• مسح الردود
• مسح الاوامر
• مسح + عدد
• مسح بالرد
• مسح ايدي عام
• مسح كليشه الايدي
• مسح كليشه الستارت
• مسح الترحيب
• مسح الرابط
• مسح كلايش التعليمات

﹎﹎﹎﹎﹎اوامر الطرد الحظر الكتم﹎﹎﹎﹎﹎
• حظر - بالرد،بالمعرف،بالايدي
• طرد - بالرد،بالمعرف،بالايدي 
• كتم - بالرد،بالمعرف،بالايدي
• تقيد - بالرد،بالمعرف،بالايدي
• الغاء الحظر - بالرد،بالمعرف،بالايدي
• الغاء الكتم - بالرد،بالمعرف،بالايدي
• فك التقييد - بالرد،بالمعرف،بالايدي
• رفع القيود - لحذف ↜ كتم،حظر،حظر عام،تقييد
• منع + الكلمه
• الغاء منع + الكلمه
• طرد البوتات
• طرد المحذوفين
• كشف البوتات]]

GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_m1:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
sendMsg(msg.chat_id_,msg.id_,textD)
end,{msg=msg})
return false
end


if MsgText[1]== 'م2' then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username

local text = [[☑️ اهلا بك في قائمة اوامر المجموعه
📨 للاستفسار - []]..SUDO_USER..[[]

﹎﹎﹎﹎اوامر الوضع ﹎﹎﹎﹎
• ضع الترحيب
• ضع القوانين
• ضع وصف
• ضـع رابط
• اضف امر
• اضف رد عام
• تعيين ايدي عام
• تعيين كليشه الايدي

﹎﹎﹎﹎اوامر رؤية الاعدادات﹎﹎﹎﹎
• المطورين
• المنشئين الاساسيين
• المنشئين 
• الادمنيه
• المدراء
• المميزين
• المحظورين
• القوانين
• المكتومين
• المطور 
• معلوماتي 
• الحمايه  
• الوسائط
• الاعدادت
• المجموعه ]]

GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_m2:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
sendMsg(msg.chat_id_,msg.id_,textD)
end,{msg=msg})
return false
end

if MsgText[1]== 'م3' then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username

local text = [[ ☑️ اهلا بك في قائمة الحماية
📨 للاستفسار - []]..SUDO_USER..[[]

﹎﹎﹎ اوامر القفل والفتح بالمسح ﹎﹎﹎
• قفل - فتح التعديل  
•️ قفل - فتح البصمات 
• قفل - فتح الفيديو 
• قفل - فتح الـصــور 
• قفل - فتح الملصقات 
• قفل - فتح المتحركه 

• قفل - فتح الدردشه 
• قفل - فتح الروابط 
• قفل - فتح التاك 
• قفل - فتح البوتات 
• ️قفل - فتح المعرفات 
• قفل - فتح البوتات بالطرد 

• قفل - فتح الكلايش 
•️ قفل - فتح التكرار 
• قفل - فتح التوجيه 
• قفل - فتح الانلاين 
• قفل - فتح الجهات 
• قفل - فتح الــكـــل 

• قفل - فتح الفشار
• قفل - فتح الفارسيه
• قفل - فتح الانكليزيه
• قفل - فتح الاضافه
• قفل - فتح الصوت
• قفل - فتح الالعاب
• قفل - فتح الماركدوان
• قفل - فتح الويب

﹎﹎﹎﹎اوامر الفتح والقفل بالتقييد﹎﹎﹎
• قفل - فتح التوجيه بالتقييد 
• قفل - فتح الروابط بالتقييد 
• قفل - فتح المتحركه بالتقييد 
• قفل - فتح الصور بالتقييد 
• قفل - فتح الفيديو بالتقييد 

﹎﹎﹎﹎اوامر التفعيل والتعطيل ﹎﹎﹎﹎
• تفعيل - تعطيل الترحيب 
• تفعيل - تعطيل الردود 
• تفعيل - تعطيل التحذير 
• تفعيل - تعطيل الايدي
• تفعيل - تعطيل الرابط
• تفعيل - تعطيل المغادره
• تفعيل - تعطيل الحظر
• تفعيل - تعطيل الحمايه
• تفعيل - تعطيل تاك للكل
• تفعيل - تعطيل الايدي بالصوره
• تفعيل - تعطيل التحقق 
• تفعيل - تعطيل ردود السورس 
• تفعيل - تعطيل التنظيف التلقائي 
]]


GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_m3:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
sendMsg(msg.chat_id_,msg.id_,textD)
end,{msg=msg})
return false
end

if MsgText[1]== "م المطور" then
if not msg.SudoBase then return "🔅¦ للمطور الاساسي فقط  🎖" end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username

local text = [[ ☑️ اهلا بك في قائمة اوامر المطورين
📨 للاستفسار - []]..SUDO_USER..[[]

• تفعيل
• تعطيل
• اسم بوتك + غادر
• مسح الادمنيه
• مسح المميزين
• مسح المدراء
• مسح المطورين
• مسح المنشئين
• مسح المنشئين الاساسيين
• مسح كلايش التعليمات
• اذاعه
• اذاعه خاص
• اذاعه عام
• اذاعه بالتثبيت
• اذاعه عام بالتوجيه
• تعيين قائمه الاوامر
• مسح كلايش التعليمات
• تعيين كليشه ستارت
• تعيين ايدي عام
• مسح ايدي عام
• تفعيل / تعطيل تعيين الايدي
• تحديث
• تحديث السورس ]]

GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_mtwr:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
sendMsg(msg.chat_id_,msg.id_,textD)
end,{msg=msg})
return false
end

if MsgText[1]== 'اوامر الرد' then
if not msg.Director then return "📪¦ هذا الامر يخص {المطور,المنشئ,المدير} فقط  \n" end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username


local text = [[ ☑️ اهلا بك في قائمة اوامر الردود
📨 للاستفسار - []]..SUDO_USER..[[]

•  جميع اوامر الردود 
• الردود : لعرض الردود المثبته
•  اضف رد : لأضافه رد جديد
• مسح رد  الرد المراد مسحه
• مسح الردود : لمسح كل الردود
•  اضف رد عام : لاضافه رد لكل المجموعات
•  مسح رد عام : لمسح الرد العام 
• مسح الردود العامه : لمسح كل ردود العامه ]]

GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_mrd:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
sendMsg(msg.chat_id_,msg.id_,textD)
end,{msg=msg})
return false
end

if MsgText[1]== "اوامر الملفات" then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
local text = [[ ☑️ اهلا بك في قائمة اوامر الملفات
📨 للاستفسار - []]..SUDO_USER..[[]

• آوآمر آلملفآت

•  `/files`  لعرض قائمه الملفات 
•  `/store`  لعرض متجر الملفات 
•  `sp file.lua`   تثبيت الملف 
•  `dp file.lua`  الملف المراد حذفه ]]


GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg
local textD = redis:get(boss..":awamer_Klesha_mf:")
if textD then
textD = Flter_Markdown(convert_Klmat(msg,data,textD,true))
else
textD = text
end
sendMsg(msg.chat_id_,msg.id_,textD)
end,{msg=msg})
return false
end


if MsgText[1] == "مغادره" or MsgText[1] == "ادفرني" or MsgText[1] == "احظرني" or MsgText[1] == "اطردني" then
if msg.Admin then return "📛*¦* لا استطيع طرد المدراء والادمنيه والمنشئين  \n" end
if not redis:get(boss.."lock_leftgroup"..msg.chat_id_) then  return "📛*¦* امر المغادره معطل من قبل اداره المجموعة  \n" end
kick_user(msg.sender_user_id_,msg.chat_id_,function(arg,data)
if data.ID == "Ok" then
StatusLeft(msg.chat_id_,msg.sender_user_id_)
send_msg(msg.sender_user_id_,"👨🏼‍⚕️¦ اهلا عزيزي , لقد تم طردك من المجموعه بامر منك \n🔖¦ اذا كان هذا بالخطأ او اردت الرجوع للمجموعه \n\n🔖¦فهذا رابط المجموعه 💯\n🌿¦"..Flter_Markdown(redis:get(boss..'group:name'..msg.chat_id_)).." :\n\n["..redis:get(boss..'linkGroup'..msg.chat_id_).."]\n")
sendMsg(msg.chat_id_,msg.id_,"🚸¦ لقد تم طردك بنجاح , ارسلت لك رابط المجموعه في الخاص اذا وصلت لك تستطيع الرجوع متى شئت ")
else
sendMsg(msg.chat_id_,msg.id_,"🚸¦ لا استطيع طردك لانك مشرف في المجموعه  ")
end
end)
return false
end

end 



if MsgText[1] == "سورس" or MsgText[1]=="السورس" then
return [[
Welcome To Source BoSs 

🌐┇BOSS TEAM 
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉
📬┇ [Source Channel](https://t.me/xb_1b)

📊┇ [Source Install](https://t.me/TH3BS/4121)

🆔┇ [Changing ID Channel](https://t.me/Change_id/1)

📋┇ [Explanation Channel](https://t.me/SourceBoss/1)

┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
📮┇ [Source Programmer](https://t.me/TH3BOSS)

♻️┇ [Twasl Bot Programmer](https://t.me/TH3BOSSBOT)

]]
end

if MsgText[1] == "متجر الملفات" or MsgText[1]:lower() == "/store"  then
if not msg.SudoBase then return "📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
local Get_Files, res = https.request("https://th3bs.github.io/GetFiles.json")
print(Get_Files)
print(res)
if res == 200 then
local Get_info, res = pcall(JSON.decode,Get_Files);
if Get_info then
local TextS = res.IinFormation.Text_Msg
local TextE = res.IinFormation.BorderBy
local NumFile = 0
for name,Course in pairs(res.Plugins) do
local Check_File_is_Found = io.open("plugins/"..name,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
CeckFile = "{✓}"
else
CeckFile = "{✖️}"
end
NumFile = NumFile + 1
TextS = TextS..NumFile.."- `"..name..'` » '..CeckFile..'\nl*»»* [{تفاصيل اكثر}]('..Course..")\n------------------------------------\n"
end
return TextS..TextE
else
return "📛¦ اوبس , هناك خطأ في مصفوفه الجيسون راسل مطور السورس ليتمكن من حل المشكله في اسرع وقت ممكن.!"
end
else
return "📛¦ اوبس , لا يوجد اتصال في الـapi راسل المطور ليتم حل المشكله في اسرع وقت ممكن.!"
end
return false
end

if MsgText[1]:lower() == "sp" and MsgText[2] then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
local FileName = MsgText[2]:lower()
local Check_File_is_Found = io.open("plugins/"..FileName,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
TText = "📑¦ الملف موجود بالفعل \n🔖¦ تم تحديث الملف  \n✓"
else
TText = "🔖¦ تم تثبيت وتفعيل الملف بنجاح \n✓"
end
local Get_Files, res = https.request("https://raw.githubusercontent.com/TH3BS/th3bs.github.io/master/plugins/"..FileName)
if res == 200 then
print("DONLOADING_FROM_URL: "..FileName)
local FileD = io.open("plugins/"..FileName,'w+')
FileD:write(Get_Files)
FileD:close()
Start_Bot()

return TText
else
return "📛¦ لا يوجد ملف بهذا الاسم في المتجر \n✖️"
end
end

if MsgText[1]:lower() == "dp" and MsgText[2] then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
local FileName = MsgText[2]:lower()
local Check_File_is_Found = io.open("plugins/"..FileName,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
os.execute("rm -fr plugins/"..FileName)
TText = "📑¦ الملف ~⪼ ["..FileName.."] \n🔖¦ تم حذفه بنجاح  \n✓"
else
TText = "📑¦ الملف ~⪼ ["..FileName.."] \n🔖¦ بالفعل محذوف  \n✓"
end
Start_Bot()
return TText
end

if MsgText[1] == "الساعه" then
return "➖\n⏱¦ الـسـاعه الان : "..os.date("%I:%M%p").."\n"
.."📆¦ الـتـاريـخ : "..os.date("%Y/%m/%d")
end

if MsgText[1] == "التاريخ" then
return "➖\n📆¦ الـتـاريـخ : "..os.date("%Y/%m/%d")
end

if MsgText[1] == "تفعيل الاشتراك الاجباري" then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
if redis:get(boss..":UserNameChaneel") then
return "📑¦ اهلا عزيزي المطور \n🔖¦ الاشتراك بالتأكيد مفعل"
else
redis:setex(boss..":ForceSub:"..msg.sender_user_id_,350,true)
return "📑¦ مرحبا بـك في نظام الاشتراك الاجباري\n🔖¦ الان ارسل معرف قـنـاتـك"
end
end

if MsgText[1] == "تعطيل الاشتراك الاجباري" then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
local SubDel = redis:del(boss..":UserNameChaneel")
if SubDel == 1 then
return "🔖¦ تم تعطيل الاشتراك الاجباري . \n✓"
else
return "🔖¦ الاشتراك الاجباري بالفعل معطل . \n✓"
end
end

if MsgText[1] == "الاشتراك الاجباري" then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
local UserChaneel = redis:get(boss..":UserNameChaneel")
if UserChaneel then
return "🔖¦ اهلا عزيزي المطور \n🔖¦ الاشتراك الاجباري للقناة : ["..UserChaneel.."]\n✓"
else
return "🔖¦ لا يوجد قناة مفعله ع الاشتراك الاجباري. \n✓"
end
end

if MsgText[1] == "تغيير الاشتراك الاجباري" then
if not msg.SudoBase then return"📪¦ هذا الامر يخص {المطور الاساسي} فقط  \n" end
redis:setex(boss..":ForceSub:"..msg.sender_user_id_,350,true)
return "📑¦ مرحبا بـك في نظام الاشتراك الاجباري\n🔖¦ الان ارسل معرف قـنـاتـك"
end





end




local function dBoss(msg)

if msg.type == "pv" then 

if not msg.SudoUser then
local msg_pv = tonumber(redis:get(boss..'user:'..msg.sender_user_id_..':msgs') or 0)
if msg_pv > 5 then
redis:setex(boss..':mute_pv:'..msg.sender_user_id_,18000,true)   
return sendMsg(msg.chat_id_,0,'*📛¦* تم حظرك من البوت بسبب التكرار \n🛠') 
end
redis:setex(boss..'user:'..msg.sender_user_id_..':msgs',2,msg_pv+1)
end

if msg.text=="/start" then

if msg.SudoBase then
local text = '🎖¦ آهہ‏‏لآ عزيزي آلمـطـور 🍃\n💰¦ آنتهہ‏‏ آلمـطـور آلآسـآسـي هہ‏‏نآ 🛠\n...\n\n🚸¦ تسـتطـيع‏‏ آلتحگم بگل آلآوآمـر آلمـمـوجودهہ‏‏ بآلگيبورد\n⚖️¦ فقط آضـغط ع آلآمـر آلذي تريد تنفيذهہ‏‏'

local keyboard = {
{"الاحصائيات 📈"},
{"ضع اسم للبوت ©","ضع صوره للترحيب 🌄"},
{"تعطيل التواصل ✖️","تفعيل التواصل 🔛"},
{"تعطيل تعيين الايدي ⚔️","تفعيل تعيين الايدي ⌨️"},

{"تعطيل البوت خدمي 🚫","تفعيل البوت خدمي 🔃"},
{"مسح كليشه الستارت 🗑","تعيين كليشه الستارت 📱"},
{"مسح كليشه الايدي عام 🗑","تعيين كليشه الايدي عام 📄"},

{"اذاعه بالتثبيت 📬","تعطيل الاذاعه 🔌","تفعيل الاذاعه 📇"},
{"اذاعه 🗣","اذاعه عام 📢","اذاعه خاص 👤"},
{"الملفات 🗂","اذاعه عام بالتوجيه 📣"},
{"نقل ملكيه البوت 📇"},
{"تحديث ♻️","قائمه العام 📜","قناة السورس 📡"},
{"المطورين 🕹","ايدي 🆔"},
{"اضف رد عام ➕","الردود العامه 🗨"},
{"تحديث السورس ™"},
{"الغاء الامر ✖️"}}
return send_key(msg.sender_user_id_,text,keyboard,nil,msg.id_)
else
redis:sadd(boss..'users',msg.sender_user_id_)
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
if SUDO_USER:match('@[%a%d_]+') then 
SUDO_USERR = "⚖️¦ مـعرف آلمـطـور  : "..SUDO_USER
else
SUDO_USERR = ""
end


text = [[💯¦ مـرحبآ آنآ بوت آسـمـي []]..redis:get(boss..':NameBot:')..[[] 🎖
💰¦ آختصـآصـي حمـآيهہ‏‏ آلمـجمـوعآت
📛¦ مـن آلسـبآم وآلتوجيهہ‏‏ وآلتگرآر وآلخ...
🚸¦ فقط آلمـطـور يسـتطـيع تفعيل آلبوت
]]..SUDO_USERR..[[

👨🏽‍🔧]]
GetUserID(msg.sender_user_id_,function(arg,data)
if data.last_name_ then Name = data.first_name_ .." "..data.last_name_ else Name = data.first_name_ end
text = redis:get(boss..':Text_Start') or text
local edited = (redis:get(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local points = redis:get(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_) or 0
local Emsgs = redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 1
if data.username_ then UserNameID = "@"..data.username_ else UserNameID = "لا يوجد" end  
text = text:gsub("{الاسم}",Name)
text = text:gsub("{الايدي}",msg.sender_user_id_)
text = text:gsub("{المعرف}",UserNameID)
text = text:gsub("{الرتبه}",msg.TheRank)
text = text:gsub("{البوت}",redis:get(boss..':NameBot:'))
text = text:gsub("{المطور}",SUDO_USER)
xsudouser = SUDO_USER:gsub('@','')
xsudouser = xsudouser:gsub([[\_]],'_')
local inline = {{{text="آلمـطـور ™",url="t.me/"..xsudouser}}}
send_key(msg.sender_user_id_,Flter_Markdown(text),nil,inline,msg.id_)
end,nil)
return false
end
end

if msg.SudoBase then
if msg.reply_id then
GetMsgInfo(msg.chat_id_,msg.reply_id,function(arg,data)
if not data.forward_info_ then return false end
local FwdUser = data.forward_info_.sender_user_id_
local MSG_ID = (redis:get(boss.."USER_MSG_TWASEL"..data.forward_info_.date_) or 1)
msg = arg.msg
local SendOk = false
if data.content_.ID == "MessageDocument" then return false end
if msg.text then
sendMsg(FwdUser,MSG_ID,Flter_Markdown(msg.text))
SendOk = true
elseif msg.content_.ID == "MessageSticker" then
sendSticker(FwdUser,MSG_ID,msg.content_.sticker_.sticker_.persistent_id_,msg.content_.caption_ or '')
SendOk = true
elseif msg.content_.ID == "MessagePhoto" then
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
sendPhoto(FwdUser,MSG_ID,photo_id,msg.content_.caption_ or '')
SendOk = true
elseif msg.content_.ID == "MessageVoice" then
sendVoice(FwdUser,MSG_ID,msg.content_.voice_.voice_.persistent_id_,msg.content_.caption_ or '')
SendOk = true
elseif msg.content_.ID == "MessageAnimation" then
sendAnimation(FwdUser,MSG_ID,msg.content_.animation_.animation_.persistent_id_,msg.content_.caption_ or '')
SendOk = true
elseif msg.content_.ID == "MessageVideo" then
sendVideo(FwdUser,MSG_ID,msg.content_.video_.video_.persistent_id_,msg.content_.caption_ or '')
SendOk = true
elseif msg.content_.ID == "MessageAudio" then
sendAudio(FwdUser,MSG_ID,msg.content_.audio_.audio_.persistent_id_,msg.content_.caption_ or '')
SendOk = true
end
if SendOk then
GetUserID(FwdUser,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data,20) end
SendMention(arg.sender_user_id_,data.id_,arg.id_,"📬¦ تم آرسـآل آلرسـآل‏‏هہ 🌿\n🎟¦ آلى : "..USERNAME.." 🏌🏻",39,utf8.len(USERNAME)) 
end,{sender_user_id_=msg.sender_user_id_,id_=msg.id_})
end
end,{msg=msg})
end
else
if not redis:get(boss..'lock_twasel') then
if msg.forward_info_ or msg.content_.ID == "MessageSticker" or msg.content_.ID == "MessageUnsupported" or msg.content_.ID == "MessageDocument" then
return sendMsg(msg.chat_id_,msg.id_,"📛¦ عذرآ لآ يمـگنگ آرسـآل {ملف , توجيه‌‏ , مـلصـق , فديو گآم} ❗️")
end
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
if SUDO_USER:match('@[%a%d_]+') then 
SUDO_USERR = "\n🏌 "..SUDO_USER
else
SUDO_USERR = ""
end
redis:setex(boss.."USER_MSG_TWASEL"..msg.date_,43200,msg.id_)
sendMsg(msg.chat_id_,msg.id_,"🗯¦ تم آرسـآل رسـآلتگ آلى آلمـطـور\n📬¦ سـآرد عليگ في آقرب وقت["..SUDO_USERR.."]")
fwdMsg(SUDO_ID,msg.chat_id_,msg.id_)
return false
end
end
end

function CaptionInsert(msg,input,public)
if msg.content_ and msg.content_.caption_ then 
if public then
redis:hset(boss..':caption_replay:Random:'..msg.klma,input,msg.content_.caption_) 
else
redis:hset(boss..':caption_replay:Random:'..msg.chat_id_..msg.klma,input,msg.content_.caption_) 
end
end
end

--====================== Reply Random Public =====================================
if redis:get(boss..'addrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_) and redis:get(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_) then
klma = redis:get(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_)
msg.klma = klma
if msg.text == "تم" then
redis:del(boss..'addrdRandom1Public:'..msg.chat_id_..msg.sender_user_id_)
redis:del(boss..'addrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_)
sendMsg(msg.chat_id_,msg.id_,'♻️¦ تم اضافه رد متعدد عشوائي بنجاح ✓\n⚜️¦ يمكنك ارسال (['..klma..']) لاضهار الردود العشوائيه .')
redis:del(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_)
return false
end

local CountRdod = redis:scard(boss..':ReplayRandom:'..klma) or 1
local CountRdod2 = 10 - tonumber(CountRdod)
local CountRdod = 9 - tonumber(CountRdod)
if CountRdod2 == 0 then 
redis:del(boss..'addrdRandom1Public:'..msg.chat_id_..msg.sender_user_id_)
redis:del(boss..'addrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_)
sendMsg(msg.chat_id_,msg.id_,'🚸¦ وصلت الحد الاقصى لعدد الردود ✓\n⚜️¦ تم اضافه الرد (['..klma..']) للردود العشوائيه .')
redis:del(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_)
return false
end
if msg.text then 
if utf8.len(msg.text) > 4000 then 
return sendMsg(msg.chat_id_,msg.id_,"📛¦ عذرا غير مسموح باضافه جواب الرد باكثر من 4000 حرف تم الغاء الامر\n❕")
end
CaptionInsert(msg,msg.text,true)
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Text:"..msg.text) 
return sendMsg(msg.chat_id_,msg.id_,'تم ادراج الرد باقي '..CountRdod..'\n تم ادراج الرد ارسل رد اخر او ارسل {تم} \n✓')
elseif msg.content_.ID == "MessagePhoto" then
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Photo:"..photo_id) 
CaptionInsert(msg,photo_id,true)
return sendMsg(msg.chat_id_,msg.id_,'🌃¦ تم ادراج صور للرد باقي '..CountRdod..' ✓\n🌃¦ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageVoice" then
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Voice:"..msg.content_.voice_.voice_.persistent_id_) 
CaptionInsert(msg,msg.content_.voice_.voice_.persistent_id_,true)
return sendMsg(msg.chat_id_,msg.id_,'🎤¦ تم ادراج البصمه للرد باقي '..CountRdod..' ✓\n🎤¦  ارسل رد اخر او ارسل {تم}')
elseif msg.content_.ID == "MessageAnimation" then
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Animation:"..msg.content_.animation_.animation_.persistent_id_) 
CaptionInsert(msg,msg.content_.animation_.animation_.persistent_id_,true)
return sendMsg(msg.chat_id_,msg.id_,'🎉¦ تم ادراج المتحركه للرد باقي '..CountRdod..' ✓\n🎉¦ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageVideo" then
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Video:"..msg.content_.video_.video_.persistent_id_) 
CaptionInsert(msg,msg.content_.video_.video_.persistent_id_,true)
return sendMsg(msg.chat_id_,msg.id_,'🎥¦ تم ادراج الفيديو للرد باقي '..CountRdod..' ✓\n🎥¦ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageAudio" then
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Audio:"..msg.content_.audio_.audio_.persistent_id_) 
CaptionInsert(msg,msg.content_.audio_.audio_.persistent_id_,true)
return sendMsg(msg.chat_id_,msg.id_,'🎧¦ تم ادراج الصوت للرد باقي '..CountRdod..' ✓\n🎧¦ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageDocument" then
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Document:"..msg.content_.document_.document_.persistent_id_) 
CaptionInsert(msg,msg.content_.document_.document_.persistent_id_,true)
return sendMsg(msg.chat_id_,msg.id_,'📄¦ تم ادراج الملف للرد باقي '..CountRdod..' ✓\n📄¦ ارسل رد اخر او ارسل {تم} .')  
elseif msg.content_.ID == "MessageSticker" then
redis:sadd(boss..':KlmatRRandom:',klma) 
redis:sadd(boss..':ReplayRandom:'..klma,":Sticker:"..msg.content_.sticker_.sticker_.persistent_id_) 
CaptionInsert(msg,msg.content_.sticker_.sticker_.persistent_id_,true)
return sendMsg(msg.chat_id_,msg.id_,'🔖¦ تم ادراج الملصق للرد باقي '..CountRdod..' ✓\n🔖¦ ارسل رد اخر او ارسل {تم} .')
end  

end
--====================== End Reply Random Public =====================================
--====================== Reply Random Only Group =====================================
if redis:get(boss..'addrdRandom:'..msg.chat_id_..msg.sender_user_id_) and redis:get(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_) then
klma = redis:get(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_)
msg.klma = klma
if msg.text == "تم" then
redis:del(boss..'addrdRandom1:'..msg.chat_id_..msg.sender_user_id_)
redis:del(boss..'addrdRandom:'..msg.chat_id_..msg.sender_user_id_)
sendMsg(msg.chat_id_,msg.id_,'♻️¦ تم اضافه رد متعدد عشوائي بنجاح ✓\n⚜️¦ يمكنك ارسال (['..klma..']) لاضهار الردود العشوائيه .')
redis:del(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_)
return false
end

local CountRdod = redis:scard(boss..':ReplayRandom:'..msg.chat_id_..":"..klma) or 1
local CountRdod2 = 10 - tonumber(CountRdod)
local CountRdod = 9 - tonumber(CountRdod)
if CountRdod2 == 0 then 
redis:del(boss..'addrdRandom1:'..msg.chat_id_..msg.sender_user_id_)
redis:del(boss..'addrdRandom:'..msg.chat_id_..msg.sender_user_id_)
sendMsg(msg.chat_id_,msg.id_,'🚸¦ وصلت الحد الاقصى لعدد الردود ✓\n⚜️¦ تم اضافه الرد (['..klma..']) للردود العشوائيه .')
redis:del(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_)
return false
end
if msg.text then 
if utf8.len(msg.text) > 4000 then 
return sendMsg(msg.chat_id_,msg.id_,"📛¦ عذرا غير مسموح باضافه جواب الرد باكثر من 4000 حرف تم الغاء الامر\n❕")
end
CaptionInsert(msg,msg.text,false)
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Text:"..msg.text) 
return sendMsg(msg.chat_id_,msg.id_,'تم ادراج الرد باقي '..CountRdod..'\n تم ادراج الرد ارسل رد اخر او ارسل {تم} \n✓')
elseif msg.content_.ID == "MessagePhoto" then
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Photo:"..photo_id) 
CaptionInsert(msg,photo_id,false)
return sendMsg(msg.chat_id_,msg.id_,'🌃¦ تم ادراج صور للرد باقي '..CountRdod..' ✓\n🌃¦ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageVoice" then
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Voice:"..msg.content_.voice_.voice_.persistent_id_) 
CaptionInsert(msg,msg.content_.voice_.voice_.persistent_id_,false)
return sendMsg(msg.chat_id_,msg.id_,'🎤¦ تم ادراج البصمه للرد باقي '..CountRdod..' ✓\n🎤¦  ارسل رد اخر او ارسل {تم}')
elseif msg.content_.ID == "MessageAnimation" then
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Animation:"..msg.content_.animation_.animation_.persistent_id_) 
CaptionInsert(msg,msg.content_.animation_.animation_.persistent_id_,false)
return sendMsg(msg.chat_id_,msg.id_,'🎉¦ تم ادراج المتحركه للرد باقي '..CountRdod..' ✓\n🎉¦ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageVideo" then
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Video:"..msg.content_.video_.video_.persistent_id_) 
CaptionInsert(msg,msg.content_.video_.video_.persistent_id_,false)
return sendMsg(msg.chat_id_,msg.id_,'🎥¦ تم ادراج الفيديو للرد باقي '..CountRdod..' ✓\n🎥¦ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageAudio" then
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Audio:"..msg.content_.audio_.audio_.persistent_id_) 
CaptionInsert(msg,msg.content_.audio_.audio_.persistent_id_,false)
return sendMsg(msg.chat_id_,msg.id_,'🎧¦ تم ادراج الصوت للرد باقي '..CountRdod..' ✓\n🎧¦ ارسل رد اخر او ارسل {تم} .')
elseif msg.content_.ID == "MessageDocument" then
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Document:"..msg.content_.document_.document_.persistent_id_) 
CaptionInsert(msg,msg.content_.document_.document_.persistent_id_,false)
return sendMsg(msg.chat_id_,msg.id_,'📄¦ تم ادراج الملف للرد باقي '..CountRdod..' ✓\n📄¦ ارسل رد اخر او ارسل {تم} .')  
elseif msg.content_.ID == "MessageSticker" then
redis:sadd(boss..':KlmatRRandom:'..msg.chat_id_,klma) 
redis:sadd(boss..':ReplayRandom:'..msg.chat_id_..":"..klma,":Sticker:"..msg.content_.sticker_.sticker_.persistent_id_) 
CaptionInsert(msg,msg.content_.sticker_.sticker_.persistent_id_,false)
return sendMsg(msg.chat_id_,msg.id_,'🔖¦ تم ادراج الملصق للرد باقي '..CountRdod..' ✓\n🔖¦ ارسل رد اخر او ارسل {تم} .')
end  

end
--====================== End Reply Random Only Group =====================================


--====================== Reply Only Group =====================================
if redis:get(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_) and redis:get(boss..'replay1'..msg.chat_id_..msg.sender_user_id_) then
local klma = redis:get(boss..'replay1'..msg.chat_id_..msg.sender_user_id_)
if msg.content_ and msg.content_.caption_ then redis:hset(boss..':caption_replay:'..msg.chat_id_,klma,msg.content_.caption_) end
if msg.text then 
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
if utf8.len(msg.text) > 4000 then 
return sendMsg(msg.chat_id_,msg.id_,"📛¦ عذرا غير مسموح باضافه جواب الرد باكثر من 4000 حرف تم الغاء الامر\n❕")
end
redis:hset(boss..'replay:'..msg.chat_id_,klma,msg.text)
return sendMsg(msg.chat_id_,msg.id_,'(['..klma..'])\n  ✓ تم اضافت الرد 🚀 \n-')
elseif msg.content_.ID == "MessagePhoto" then
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
redis:hset(boss..'replay_photo:group:'..msg.chat_id_,klma,photo_id)
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه صوره للرد بنجاح ✓\n🗂¦ يمكنك ارسال (['..klma..']) لاضهار الصوره الاتيه .')
elseif msg.content_.ID == "MessageVoice" then
redis:hset(boss..'replay_voice:group:'..msg.chat_id_,klma,msg.content_.voice_.voice_.persistent_id_)
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه بصمه صوت للرد بنجاح ✓\n🗂¦ يمكنك ارسال (['..klma..']) لسماع البصمه الاتيه .')
elseif msg.content_.ID == "MessageAnimation" then
redis:hset(boss..'replay_animation:group:'..msg.chat_id_,klma,msg.content_.animation_.animation_.persistent_id_)
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه متحركه للرد بنجاح ✓\n🗂¦ يمكنك ارسال (['..klma..']) لاضهار الصوره الاتيه .')
elseif msg.content_.ID == "MessageVideo" then
redis:hset(boss..'replay_video:group:'..msg.chat_id_,klma,msg.content_.video_.video_.persistent_id_)
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه فيديو للرد بنجاح ✓\n🗂¦ يمكنك ارسال (['..klma..']) لاضهار الفيديو الاتي .')
elseif msg.content_.ID == "MessageAudio" then
redis:hset(boss..'replay_audio:group:'..msg.chat_id_,klma,msg.content_.audio_.audio_.persistent_id_)
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه للصوت للرد بنجاح ✓\n🗂¦ يمكنك ارسال (['..klma..']) لاضهار الصوت الاتي .')
elseif msg.content_.ID == "MessageDocument" then
redis:hset(boss..'replay_files:group:'..msg.chat_id_,klma,msg.content_.document_.document_.persistent_id_ )
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه ملف للرد بنجاح ✓\n🗂¦ يمكنك ارسال (['..klma..']) لاضهار الملف الاتي .')  
elseif msg.content_.ID == "MessageSticker" then
redis:hset(boss..'replay_sticker:group:'..msg.chat_id_,klma,msg.content_.sticker_.sticker_.persistent_id_)
redis:del(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه ملصق للرد بنجاح ✓\n🗂¦ يمكنك ارسال (['..klma..']) لاضهار الملصق الاتي .')
end  

end

--====================== Reply All Groups =====================================
if redis:get(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_) and redis:get(boss..'allreplay:'..msg.chat_id_..msg.sender_user_id_) then
local klma = redis:get(boss..'allreplay:'..msg.chat_id_..msg.sender_user_id_)
if msg.content_.caption_ then redis:hset(boss..':caption_replay:'..msg.chat_id_,klma,msg.content_.caption_) end
if msg.text then
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
if utf8.len(msg.text) > 4000 then 
return sendMsg(msg.chat_id_,msg.id_,"📛¦ عذرا غير مسموح باضافه جواب الرد باكثر من 4000 حرف تم الغاء الامر\n❕")
end
redis:hset(boss..'replay:all',klma,msg.text)
return sendMsg(msg.chat_id_,msg.id_,'(['..klma..'])\n  ✓ تم اضافت الرد لكل المجموعات 🚀 ')
elseif msg.content_.ID == "MessagePhoto" then 
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
redis:hset(boss..'replay_photo:group:',klma,photo_id)
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه صوره للرد العام ✓\n🗂¦ يمكنك ارسال (['..klma..']) لاضهار الصوره الاتيه .')
elseif msg.content_.ID == "MessageVoice" then
redis:hset(boss..'replay_voice:group:',klma,msg.content_.voice_.voice_.persistent_id_)
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه بصمه صوت للرد العام ✓\n🗂¦ يمكنك ارسال (['..klma..']) لسماع البصمه الاتيه .')
elseif msg.content_.ID == "MessageAnimation" then
redis:hset(boss..'replay_animation:group:',klma,msg.content_.animation_.animation_.persistent_id_)
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه متحركه للرد العام ✓\n🗂¦ يمكنك ارسال (['..klma..']) لاضهار الصوره الاتيه .')
elseif msg.content_.ID == "MessageVideo" then
redis:hset(boss..'replay_video:group:',klma,msg.content_.video_.video_.persistent_id_)
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه فيديو للرد العام ✓\n🗂¦ يمكنك ارسال (['..klma..']) لاضهار الفيديو الاتي .')
elseif msg.content_.ID == "MessageAudio" then
redis:hset(boss..'replay_audio:group:',klma,msg.content_.audio_.audio_.persistent_id_)
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه للصوت للرد العام ✓\n🗂¦ يمكنك ارسال (['..klma..']) لاضهار الصوت الاتي .')
elseif msg.content_.ID == "MessageDocument" then
redis:hset(boss..'replay_files:group:',klma,msg.content_.document_.document_.persistent_id_ )
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه ملف للرد العام ✓\n🗂¦ يمكنك ارسال (['..klma..']) لاضهار ملف الاتي .')  
elseif msg.content_.ID == "MessageSticker" then
redis:hset(boss..'replay_sticker:group:',klma,msg.content_.sticker_.sticker_.persistent_id_)
redis:del(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,'🗂¦ تم اضافه ملصق للرد العام ✓\n🗂¦ يمكنك ارسال (['..klma..']) لاضهار الملصق الاتي .')
end  

end

if msg.text then
--====================== Requst UserName Of Channel For ForceSub ==============

if msg.Director and (msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.text:match("[Hh][Tt][Tt][Pp]://") or msg.text:match("[Ww][Ww][Ww].") or msg.text:match(".[Cc][Oo][Mm]") or msg.text:match(".[Oo][Rr][Gg]")) and redis:get(boss.."WiCmdLink"..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss.."WiCmdLink"..msg.chat_id_..msg.sender_user_id_)
redis:set(boss..'linkGroup'..msg.chat_id_,msg.text)
sendMsg(msg.chat_id_,msg.id_,"🔖¦ تم تعيين الرابط بنجاح  ")
return false
end

if msg.Creator and redis:get(boss..":Witting_KleshaID_public"..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss..":Witting_KleshaID_public"..msg.chat_id_..msg.sender_user_id_)
redis:set(boss..":infoiduser_public:"..msg.chat_id_,msg.text)
sendMsg(msg.chat_id_,msg.id_,"🔖¦ تم تعيين كليشة الايدي بنجاح \n📮¦ يمكنك تجربة الامر الان ")
return false
end

if msg.SuperCreator and redis:get(boss..":uploadingsomeon:"..msg.chat_id_..msg.sender_user_id_) then 

NameUser = redis:get(boss..":uploadingsomeon:"..msg.chat_id_..msg.sender_user_id_)
UserID = redis:get(boss..":uploadingsomeon2:"..msg.chat_id_..msg.sender_user_id_)
if not msg.text:match("[1234567]") and not msg.text:match("[*]") and not msg.text:match("[*][*]") then
redis:del(boss..":uploadingsomeon:"..msg.chat_id_..msg.sender_user_id_)
redis:del(boss..":uploadingsomeon2:"..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,"📛*¦* تم الغاء الامر , يجب ان يحتوي رسالتك ع ارقام الصلاحيات المعروضه . \n📛")   
end

Nikname = msg.text:gsub("[1234567]","")
Nikname = Nikname:gsub("[*]","")
ResAdmin = UploadAdmin(msg.chat_id_,UserID,msg.text)  
if ResAdmin == '{"ok":false,"error_code":400,"description":"Bad Request: not enough rights"}' then
sendMsg(msg.chat_id_,msg.id_,"📛*¦* عذرا البوت ليس لديه صلاحيه رفع مشرفين في المجموعه \n📛") 
elseif ResAdmin == '{"ok":false,"error_code":400,"description":"Bad Request: can\'t remove chat owner"}' then
sendMsg(msg.chat_id_,msg.id_,"📛*¦* عذرا لا يمكنني التحكم بصلاحيات المنشئ للمجموعه. \n📛") 
elseif ResAdmin == '{"ok":false,"error_code":400,"description":"Bad Request: CHAT_ADMIN_REQUIRED"}' then
sendMsg(msg.chat_id_,msg.id_,"📛*¦* عذرا لا يمكنني التحكم بصلاحيات المشرف مرفوع من قبل منشئ اخر . \n📛") 
elseif ResAdmin == '{"ok":true,"result":true}' then
ChangeNikname(msg.chat_id_,UserID,Nikname)
redis:sadd(boss..'admins:'..msg.chat_id_,UserID)
local trues = "✓"
local falses = "✖️"

infochange = falses
infochange1 = falses
infochange2 = falses
infochange3 = falses
infochange4 = falses
infochange5 = falses
if msg.text:match(1) then
infochange = trues
end
if msg.text:match(2) then
infochange1 = trues
end
if msg.text:match(3) then
infochange2 = trues
end
if msg.text:match(4) then
infochange3 = trues
end
if msg.text:match(5) then
infochange4 = trues
end
if msg.text:match(6) then
infochange5 = trues
end
if msg.text:match("[*][*]") then
infochange = trues
infochange1 = trues
infochange2 = trues
infochange3 = trues
infochange4 = trues
infochange5 = trues
elseif msg.text:match("[*]") then
infochange = trues
infochange1 = trues
infochange2 = trues
infochange3 = trues
infochange4 = trues
end

if Nikname == "" then Nikname = "بدون" end
sendMsg(msg.chat_id_,msg.id_,"📮¦ المشرف  ⋙ 「 "..NameUser.." 」 صلاحياته : \n\n"
.."📱¦ تغيير معلومات المجموعه : "..infochange.."\n"
.."🗑¦ صلاحيه حذف الرسائل : "..infochange1.."\n"
.."📬¦ صلاحيه دعوه مستخدمين : "..infochange2.."\n"
.."🔑¦ صلاحيه حظر وتقيد المستخدمين : "..infochange3.."\n"
.."📌¦ صلاحيه تثبيت الرسائل : "..infochange4.."\n"
.."📤¦ صلاحيه رفع مشرفين اخرين : "..infochange5.."\n\n"
.."📋¦ الـكـنـيـة : ["..Nikname.."]\n"
.."\n✓") 
else
sendMsg(msg.chat_id_,msg.id_,"📮¦ المشرف  ⋙ 「 "..NameUser.." 」  حدث خطأ ما  \n✓") 
end
redis:del(boss..":uploadingsomeon:"..msg.chat_id_..msg.sender_user_id_)
redis:del(boss..":uploadingsomeon2:"..msg.chat_id_..msg.sender_user_id_)
return false
end


if msg.Creator and redis:get(boss..":changawmer:"..msg.chat_id_..msg.sender_user_id_) and not redis:get(boss..":Witting_awamr_witting"..msg.chat_id_..msg.sender_user_id_) then 
if msg.text=="م1" or msg.text=="م2" or msg.text=="م3" or msg.text=="م المطور" or msg.text=="اوامر الرد" or msg.text=="الاوامر" or msg.text=="اوامر الملفات" then return false end
local amr = redis:get(boss..":changawmer:"..msg.chat_id_..msg.sender_user_id_)
if amr == "م1" then
redis:set(boss..":awamer_Klesha_m1:",msg.text)
elseif amr == "م2" then
redis:set(boss..":awamer_Klesha_m2:",msg.text)
elseif amr == "م3" then
redis:set(boss..":awamer_Klesha_m3:",msg.text)
elseif amr == "م المطور" then
redis:set(boss..":awamer_Klesha_mtwr:",msg.text)
elseif amr == "اوامر الرد" then
redis:set(boss..":awamer_Klesha_mrd:",msg.text)
elseif amr == "اوامر الملفات" then
redis:set(boss..":awamer_Klesha_mf:",msg.text)
elseif amr == "الاوامر" then
redis:set(boss..":awamer_Klesha_m:",msg.text)
end
redis:del(boss..":changawmer:"..msg.chat_id_..msg.sender_user_id_)
return sendMsg(msg.chat_id_,msg.id_,"🔖¦ تم تعيين كليشة التعليمات بنجاح \n📮¦ يمكنك تجربة الامر *{"..amr.."}* ")
end


if msg.SudoUser and redis:get(boss..":Witting_KleshaID"..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss..":Witting_KleshaID"..msg.chat_id_..msg.sender_user_id_)
redis:set(boss..":infoiduser",msg.text)
sendMsg(msg.chat_id_,msg.id_,"🔖¦ تم تعيين كليشة الايدي بنجاح \n📮¦ يمكنك تجربة الامر الان ")
return false
end

--==========================================================================================================

if msg.Director and redis:get(boss..":Witting_changeamr:"..msg.chat_id_..msg.sender_user_id_) then
local Awammer 	= redis:hgetall(boss..":AwamerBotArray2:"..msg.chat_id_)
Amr = redis:get(boss..":Witting_changeamr:"..msg.chat_id_..msg.sender_user_id_)
checknewamr = false

for name,Course in pairs(Awammer) do
if name == msg.text then 
checknewamr = true 
end 
end
if checknewamr  then
sendMsg(msg.chat_id_,msg.id_,"📛*¦* عذرا لايمكن اضافه امر مكرر في القائمه \n...")
else
for k, Boss in pairs(XBoss) do 
local cceck,sec = Boss:gsub("[(]"..Amr.."[)]","("..msg.text..")")
print(cceck,sec)
if sec ~= 0 then
redis:hset(boss..":AwamerBotArray:"..msg.chat_id_,cceck,Boss)
redis:hset(boss..":AwamerBotArray2:"..msg.chat_id_,msg.text,Amr)
end
end  
redis:hset(boss..":AwamerBot:"..msg.chat_id_,msg.text,Amr)
sendMsg(msg.chat_id_,msg.id_,"📑¦ تم تغيير الامر القديم ["..Amr.."] \n🔖¦ الى الامر الجديد ["..msg.text.."]\n...")
end
redis:del(boss..":Witting_changeamr:"..msg.chat_id_..msg.sender_user_id_)
return false
end

if msg.Director and not redis:get(boss..":Witting_changeamr2:"..msg.chat_id_..msg.sender_user_id_) and redis:get(boss..":firstAmrOld:"..msg.chat_id_..msg.sender_user_id_) then
local Awammer 	= redis:hgetall(boss..":AwamerBotArray2:"..msg.chat_id_)
local Amr = redis:get(boss..":firstAmrOld:"..msg.chat_id_..msg.sender_user_id_)

local checknewamr = false

for name,Course in pairs(Awammer) do if name == msg.text then checknewamr = true end end 
if checknewamr  then
sendMsg(msg.chat_id_,msg.id_,"📛*¦* عذرا لايمكن اضافه امر مكرر في القائمه \n...")
else
for k, Boss in pairs(XBoss) do 
local cceck,sec = Boss:gsub("[(]"..Amr.."[)]","("..msg.text..")")
if sec ~= 0 then
redis:hset(boss..":AwamerBotArray:"..msg.chat_id_,cceck,Boss) 
redis:hset(boss..":AwamerBotArray2:"..msg.chat_id_,msg.text,Amr)
end
end 
redis:hset(boss..":AwamerBot:"..msg.chat_id_,msg.text,Amr)
sendMsg(msg.chat_id_,msg.id_,"📑¦ تم تغيير الامر القديم ["..Amr.."] \n🔖¦ الى الامر الجديد ["..msg.text.."]\n...")
end
redis:del(boss..":firstAmrOld:"..msg.chat_id_..msg.sender_user_id_)
return false
end

if msg.Director and redis:get(boss..":Witting_changeamr2:"..msg.chat_id_..msg.sender_user_id_) then
local checkAmr = false
for k, Boss in pairs(XBoss) do if msg.text:match(Boss) then checkAmr = true end end      
if checkAmr then
sendMsg(msg.chat_id_,msg.id_,"📭¦ حسننا عزيزي , لتغير امر {* "..msg.text.." *} \n¦ ارسل الامر الجديد الان \n...")
redis:setex(boss..":firstAmrOld:"..msg.chat_id_..msg.sender_user_id_,900,msg.text)
else
sendMsg(msg.chat_id_,msg.id_,"📛*¦* عذرا لا يوجد هذا الامر في البوت لتتمكن من تغييره  \n")
end
redis:del(boss..":Witting_changeamr2:"..msg.chat_id_..msg.sender_user_id_)
return false
end


if msg.SudoUser and msg.text and redis:get(boss..":Witing_DelNewRtba:"..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss..":Witing_DelNewRtba:"..msg.chat_id_..msg.sender_user_id_)

if msg.text ~= "مطور اساسي" and msg.text ~= "مطور" and msg.text ~= "منشئ اساسي" and msg.text ~= "منشئ" and msg.text ~= "مدير" and msg.text ~= "ادمن" and msg.text ~= "مميز" then
sendMsg(msg.chat_id_,msg.id_,"عذرا هذه الرتبه غير متوفره في السورس \n• تم الغاء الامر")
return false
end

if msg.text == "مطور اساسي" then
redis:del(boss..":RtbaNew1:"..msg.chat_id_)
elseif msg.text == "مطور" then
redis:del(boss..":RtbaNew2:"..msg.chat_id_)
elseif msg.text == "منشئ اساسي" then
redis:del(boss..":RtbaNew3:"..msg.chat_id_)
elseif msg.text == "منشئ" then
redis:del(boss..":RtbaNew4:"..msg.chat_id_)
elseif msg.text == "مدير" then
redis:del(boss..":RtbaNew5:"..msg.chat_id_)
elseif msg.text == "ادمن" then
redis:del(boss..":RtbaNew6:"..msg.chat_id_)
elseif msg.text == "مميز" then
redis:del(boss..":RtbaNew7:"..msg.chat_id_)
end

sendMsg(msg.chat_id_,msg.id_,"- تم حذف الرتبه المضافه")
return false
end

if msg.SudoUser and msg.text and redis:get(boss..":Witing_NewRtba:"..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss..":Witing_NewRtba:"..msg.chat_id_..msg.sender_user_id_)

if msg.text ~= "مطور اساسي" and msg.text ~= "مطور" and msg.text ~= "منشئ اساسي" and msg.text ~= "منشئ" and msg.text ~= "مدير" and msg.text ~= "ادمن" and msg.text ~= "مميز" then
sendMsg(msg.chat_id_,msg.id_,"عذرا هذه الرتبه غير متوفره في السورس \n• تم الغاء الامر")
return false
end

redis:setex(boss..":Witting_NewRtba2:"..msg.chat_id_..msg.sender_user_id_,1000,msg.text)
sendMsg(msg.chat_id_,msg.id_,"- الان ارسل الرتبه الجديده")
return false
end


if msg.SudoUser and msg.text and redis:get(boss..":Witting_NewRtba2:"..msg.chat_id_..msg.sender_user_id_) then 


local rtbanamenew = redis:get(boss..":Witting_NewRtba2:"..msg.chat_id_..msg.sender_user_id_)
if rtbanamenew == "مطور اساسي" then
redis:set(boss..":RtbaNew1:"..msg.chat_id_,msg.text)
elseif rtbanamenew == "مطور" then
redis:set(boss..":RtbaNew2:"..msg.chat_id_,msg.text)
elseif rtbanamenew == "منشئ اساسي" then
redis:set(boss..":RtbaNew3:"..msg.chat_id_,msg.text)
elseif rtbanamenew == "منشئ" then
redis:set(boss..":RtbaNew4:"..msg.chat_id_,msg.text)
elseif rtbanamenew == "مدير" then
redis:set(boss..":RtbaNew5:"..msg.chat_id_,msg.text)
elseif rtbanamenew == "ادمن" then
redis:set(boss..":RtbaNew6:"..msg.chat_id_,msg.text)
elseif rtbanamenew == "مميز" then
redis:set(boss..":RtbaNew7:"..msg.chat_id_,msg.text)
end

redis:del(boss..":Witting_NewRtba2:"..msg.chat_id_..msg.sender_user_id_)
sendMsg(msg.chat_id_,msg.id_,"- تم تغيير الرتبه بنجاح  \n\n•  ["..rtbanamenew.."] 》 ["..msg.text.."]\n")
return false
end


if msg.Director and redis:get(boss..":Witting_AmrDel:"..msg.chat_id_..msg.sender_user_id_) then
local checkk = redis:hdel(boss..":AwamerBotArray2:"..msg.chat_id_,msg.text)

local AmrOld = redis:hgetall(boss..":AwamerBotArray:"..msg.chat_id_)
amrnew = ""
amrold = ""
amruser = msg.text.." @user"
amrid = msg.text.." 23434"
amrklma = msg.text.." ffffff"
amrfile = msg.text.." fff.lua"
for Amor,ik in pairs(AmrOld) do
if msg.text:match(Amor) then			
print("¦AMrnew : "..Amor,"¦AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amruser:match(Amor) then
print("¦AMrnew : "..Amor,"¦AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amrid:match(Amor) then
print("¦AMrnew : "..Amor,"¦AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amrklma:match(Amor) then
print("¦AMrnew : "..Amor,"¦AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
elseif amrfile:match(Amor) then
print("¦AMrnew : "..Amor,"¦AMrOld : "..ik)
redis:hdel(boss..":AwamerBotArray:"..msg.chat_id_,Amor)
end
end

if checkk ~=0 then
tiires =  "📭¦ تم مسح الامر {* "..msg.text.." *} من قائمه الاومر \n..."
else
tiires = "📪¦ هذا الامر ليس موجود ضمن الاوامر المضافه  \n"
end
sendMsg(msg.chat_id_,msg.id_,tiires)
redis:del(boss..":Witting_AmrDel:"..msg.chat_id_..msg.sender_user_id_)
return false
end

--==========================================================================================================

if msg.Director and redis:get(boss..":Witting_AmrDel:"..msg.chat_id_..msg.sender_user_id_) then

local checkk = redis:hdel(boss..":AwamerBot:"..msg.chat_id_,msg.text)
if checkk ~=0 then
tiires =  "📭¦ تم مسح الامر {* "..msg.text.." *} من قائمه الاومر \n..."
else
tiires = "📪¦ هذا الامر ليس موجود ضمن الاوامر المضافه  \n"
end
sendMsg(msg.chat_id_,msg.id_,tiires)
redis:del(boss..":Witting_AmrDel:"..msg.chat_id_..msg.sender_user_id_)
return false
end


if msg.SudoBase and redis:get(boss..":Witting_MoveBot:"..msg.chat_id_..msg.sender_user_id_) then
if msg.text:match("^@[%a%d_]+$") then
GetUserName(msg.text,function(arg,data)
if not data.id_ then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لآ يوجد عضـو بهہ‌‏ذآ آلمـعرف \n❕") end 
if data.type_.user_ and data.type_.user_.type_.ID == "UserTypeBot" then return sendMsg(arg.ChatID,arg.MsgID,"📛*¦* لا يمكنني رفع حساب بوت \n❕") end 
local UserID = data.id_
if UserID == our_id then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا لا يمكنني رفع البوت \n📛") 
elseif data.type_.ID == "ChannelChatInfo" then 
return sendMsg(arg.ChatID,arg.MsgID,"👤*¦* عذرا هذا معرف قناة وليس حساب \n📛") 
end
redis:set(boss..":SUDO_ID:",UserID)
local usero = arg.USERNAME:gsub([[\_]],"_")
redis:hset(boss..'username:'..UserID,'username',usero)
sendMsg(msg.chat_id_,msg.id_,"🔖¦ تمت العملية بنجاح وتم تحويل ملكية البوت \n📮¦ الى الحساب الاتي : ["..arg.USERNAME:gsub([[\_]],"_").."]")
dofile("./inc/Run.lua")
print("Update Source And Reload ~ ./inc/Run.lua And change username sudo")
end,{ChatID=msg.chat_id_,MsgID=msg.id_,USERNAME=msg.text})

else
sendMsg(msg.chat_id_,msg.id_,"📑¦ عذرا , هناك خطأ لديك \n🔖¦ هذا ليس معرف مستخدم ولا يحتوي على @  .")
end
redis:del(boss..":Witting_MoveBot:"..msg.chat_id_..msg.sender_user_id_)
return false 
end


if redis:get(boss..":ForceSub:"..msg.sender_user_id_) then
redis:del(boss..":ForceSub:"..msg.sender_user_id_)
if msg.text:match("^@[%a%d_]+$") then
local url , res = https.request(ApiToken..'/getchatmember?chat_id='..msg.text..'&user_id='..msg.sender_user_id_)
if res == 400 then
local Req = JSON.decode(url)
if Req.description == "Bad Request: chat not found" then 
sendMsg(msg.chat_id_,msg.id_,"📑¦ عذرا , هناك خطأ لديك \n🔖¦ المعرف الذي ارسلته ليس معرف قناة.")
return false
elseif Req.description == "Bad Request: user not found" then
sendMsg(msg.chat_id_,msg.id_,"📑¦ عذرا , لقد نسيت شيئا \n🔖¦ يجب رفع البوت مشرف في قناتك لتتمكن من تفعيل الاشتراك الاجباري .")
elseif Req.description == "Bad Request: CHAT_ADMIN_REQUIRED" then
sendMsg(msg.chat_id_,msg.id_,"📑¦ عذرا , لقد نسيت شيئا \n🔖¦ يجب رفع البوت مشرف في قناتك لتتمكن من تفعيل الاشتراك الاجباري .")
return false
end
else
redis:set(boss..":UserNameChaneel",msg.text)
sendMsg(msg.chat_id_,msg.id_,"🔖¦ جـيـد , الان لقد تم تفعيل الاشتراك الاجباري\n📮¦ على قناتك : ["..msg.text.."]")
return false
end
else
sendMsg(msg.chat_id_,msg.id_,"📑¦ عذرا , عزيزي المطور \n🔖¦ هذا ليس معرف قناة , حاول مجددا .")
return false
end
end

if redis:get(boss..'namebot:witting'..msg.sender_user_id_) then --- استقبال اسم البوت 
redis:del(boss..'namebot:witting'..msg.sender_user_id_)
redis:set(boss..':NameBot:',msg.text)
Start_Bot() 
sendMsg(msg.chat_id_,msg.id_,"📭¦ تم تغير اسم البوت  ✋🏿\n🗯¦ الان اسمه "..Flter_Markdown(msg.text).." \n✓")
return false
end

if redis:get(boss..'addrd_all:'..msg.chat_id_..msg.sender_user_id_) then -- استقبال الرد لكل المجموعات
if not redis:get(boss..'allreplay:'..msg.chat_id_..msg.sender_user_id_) then -- استقبال كلمه الرد لكل المجموعات
if utf8.len(msg.text) > 25 then 
return sendMsg(msg.chat_id_,msg.id_,"📛¦ عذرا غير مسموح باضافه كلمه الرد باكثر من 25 حرف \n❕")
end
redis:hdel(boss..'replay_photo:group:',msg.text)
redis:hdel(boss..'replay_voice:group:',msg.text)
redis:hdel(boss..'replay_animation:group:',msg.text)
redis:hdel(boss..'replay_audio:group:',msg.text)
redis:hdel(boss..'replay_sticker:group:',msg.text)
redis:hdel(boss..'replay_video:group:',msg.text)
redis:hdel(boss..'replay_files:group:',msg.text)
redis:setex(boss..'allreplay:'..msg.chat_id_..msg.sender_user_id_,300,msg.text)
return sendMsg(msg.chat_id_,msg.id_,"📜¦ جيد , يمكنك الان ارسال جوا ب الردالعام \n🔛¦ [[ نص,صوره,فيديو,متحركه,بصمه,اغنيه,ملف ]] ✓\n\n\n علما ان الاختصارات كالاتي : \n \n{الاسم} : لوضع اسم المستخدم\n{الايدي} : لوضع ايدي المستخدم\n{المعرف} : لوضع معرف المستخدم \n{الرتبه} : لوضع نوع رتبه المستخدم \n{التفاعل} : لوضع تفاعل المستخدم \n{الرسائل} : لاضهار عدد الرسائل \n{النقاط} : لاضهار عدد النقاط \n{التعديل} : لاضهار عدد السحكات \n{البوت} : لاضهار اسم البوت\n{المطور} : لاضهار معرف المطور الاساسي\n➼")
end
end

if redis:get(boss..':KStart:'..msg.chat_id_..msg.sender_user_id_) then
redis:del(boss..':KStart:'..msg.chat_id_..msg.sender_user_id_)
redis:set(boss..':Text_Start',msg.text)
return sendMsg(msg.chat_id_,msg.id_,'🛑*¦* تم اضافه كليشة الستارت بنجاح \n\n🚸*¦*ملاحظه : كليشة الستارت للمطور الاساسي تكون ثابته اما لغير الرتب تكون حسب الي وضعتها')
end


if redis:get(boss..'delrdall:'..msg.sender_user_id_) then
redis:del(boss..'delrdall:'..msg.sender_user_id_)
local names = redis:hget(boss..'replay:all',msg.text)
local photo =redis:hget(boss..'replay_photo:group:',msg.text)
local voice = redis:hget(boss..'replay_voice:group:',msg.text)
local animation = redis:hget(boss..'replay_animation:group:',msg.text)
local audio = redis:hget(boss..'replay_audio:group:',msg.text)
local sticker = redis:hget(boss..'replay_sticker:group:',msg.text)
local video = redis:hget(boss..'replay_video:group:',msg.text)
local file = redis:hget(boss..'replay_files:group:',msg.text)
if not (names or photo or voice or animation or audio or sticker or video or file) then
return sendMsg(msg.chat_id_,msg.id_,'🛑*¦* هذا الرد ليس مضاف في قائمه الردود 📛')
else
redis:hdel(boss..'replay:all',msg.text)
redis:hdel(boss..'replay_photo:group:',msg.text)
redis:hdel(boss..'replay_voice:group:',msg.text)
redis:hdel(boss..'replay_audio:group:',msg.text)
redis:hdel(boss..'replay_animation:group:',msg.text)
redis:hdel(boss..'replay_sticker:group:',msg.text)
redis:hdel(boss..'replay_video:group:',msg.text)
redis:hdel(boss..'replay_files:group:',msg.text)
return sendMsg(msg.chat_id_,msg.id_,'('..Flter_Markdown(msg.text)..')\n  ✓ تم مسح الرد 🚀 ')
end 
end 


if redis:get(boss..'text_sudo:witting'..msg.sender_user_id_) then -- استقبال كليشه المطور
redis:del(boss..'text_sudo:witting'..msg.sender_user_id_) 
redis:set(boss..':TEXT_SUDO',Flter_Markdown(msg.text))
return sendMsg(msg.chat_id_,msg.id_, "📜*¦* تم وضع الكليشه بنجاح كلاتي 👋🏻\n\n*{*  "..Flter_Markdown(msg.text).."  *}*\n✓")
end
if redis:get(boss..'welcom:witting'..msg.chat_id_..msg.sender_user_id_) then -- استقبال كليشه الترحيب
redis:del(boss..'welcom:witting'..msg.chat_id_..msg.sender_user_id_) 
redis:set(boss..'welcome:msg'..msg.chat_id_,msg.text)
return sendMsg(msg.chat_id_,msg.id_,"📜*¦* تم وضع الترحيب بنجاح كلاتي 👋\n✓" )
end
if redis:get(boss..'rulse:witting'..msg.chat_id_..msg.sender_user_id_) then --- استقبال القوانين
redis:del(boss..'rulse:witting'..msg.chat_id_..msg.sender_user_id_) 
redis:set(boss..'rulse:msg'..msg.chat_id_,Flter_Markdown(msg.text)) 
return sendMsg(msg.chat_id_,msg.id_,'📜*¦* مرحبآ عزيزي\n📦¦ تم حفظ القوانين بنجاح ✓\n🔖¦ ارسل [[ القوانين ]] لعرضها \n🛑✓')
end
if redis:get(boss..'name:witting'..msg.chat_id_..msg.sender_user_id_) then --- استقبال الاسم
redis:del(boss..'name:witting'..msg.chat_id_..msg.sender_user_id_) 
tdcli_function({ID= "ChangeChatTitle",chat_id_=msg.chat_id_,title_=msg.text},dl_cb,nil)
end
if redis:get(boss..'about:witting'..msg.chat_id_..msg.sender_user_id_) then --- استقبال الوصف
redis:del(boss..'about:witting'..msg.chat_id_..msg.sender_user_id_) 
tdcli_function({ID="ChangeChannelAbout",channel_id_=msg.chat_id_:gsub('-100',''),about_ = msg.text},function(arg,data) 
if data.ID == "Ok" then 
return sendMsg(msg.chat_id_,msg.id_,"📜*¦* تم وضع الوصف بنجاح\n✓")
end 
end,nil)
end


if redis:get(boss..'fwd:all'..msg.sender_user_id_) then ---- استقبال رساله الاذاعه عام
redis:del(boss..'fwd:all'..msg.sender_user_id_)
local pv = redis:smembers(boss..'users')  
local groups = redis:smembers(boss..'group:ids')
local allgp =  #pv + #groups
if allgp >= 300 then
sendMsg(msg.chat_id_,msg.id_,'📑¦ اهلا عزيزي المطور \n🔖¦ جاري نشر التوجيه للمجموعات وللمشتركين ...')			
end
for i = 1, #pv do 
sendMsg(pv[i],0,Flter_Markdown(msg.text))
end
for i = 1, #groups do 
sendMsg(groups[i],0,Flter_Markdown(msg.text))
end
return sendMsg(msg.chat_id_,msg.id_,'📜*¦* تم اذاعه الكليشه بنجاح 🏌🏻\n🗣*¦* للمـجمـوعآت » *'..#groups..'* گروب \n👥*¦* للمـشـترگين » '..#pv..' مـشـترگ \n✓')
end

if redis:get(boss..'fwd:pv'..msg.sender_user_id_) then ---- استقبال رساله الاذاعه خاص
redis:del(boss..'fwd:pv'..msg.sender_user_id_)
local pv = redis:smembers(boss..'users')
if #pv >= 300 then
sendMsg(msg.chat_id_,msg.id_,'📑¦ اهلا عزيزي المطور \n🔖¦ جاري نشر الرساله للمشتركين ...')			
end
local NumPvDel = 0
for i = 1, #pv do
sendMsg(pv[i],0,Flter_Markdown(msg.text))
end
sendMsg(msg.chat_id_,msg.id_,'🙍🏼‍♂️*¦* عدد المشتركين : '..#pv..'\n🗣*¦* تم الاذاعه بنجاح ✓') 
end

if redis:get(boss..':prod_pin:'..msg.chat_id_..msg.sender_user_id_) then 
redis:del(boss..':prod_pin:'..msg.chat_id_..msg.sender_user_id_)
local groups = redis:smembers(boss..'group:ids')
if #groups >= 300 then
sendMsg(msg.chat_id_,msg.id_,'📑¦ اهلا عزيزي المطور \n🔖¦ جاري نشر الرساله للمجموعات ...')			
end
local NumGroupsDel = 0
for i = 1, #groups do 
sendMsg(groups[i],0,Flter_Markdown(msg.text),function(arg,data)
if data.chat_id_ then redis:setex(boss..":propin"..data.chat_id_,100,data.content_.text_) end
end)
end
sendMsg(msg.chat_id_,msg.id_,'📑*¦* عدد المجموعات •⊱ { *'..#groups..'*  } ⊰•\n🗣*¦* تـم الاذاعه بالتثبيت بنجاح ✓')
end 

if redis:get(boss..'fwd:groups'..msg.sender_user_id_) then ---- استقبال رساله الاذاعه خاص
redis:del(boss..'fwd:groups'..msg.sender_user_id_)
local groups = redis:smembers(boss..'group:ids')
if #groups >= 300 then
sendMsg(msg.chat_id_,msg.id_,'📑¦ اهلا عزيزي المطور \n🔖¦ جاري نشر الرساله للمجموعات ...')			
end
local NumGroupsDel = 0
for i = 1, #groups do 
sendMsg(groups[i],0,Flter_Markdown(msg.text))
end
sendMsg(msg.chat_id_,msg.id_,'📑*¦* عدد المجموعات •⊱ { *'..#groups..'*  } ⊰•\n🗣*¦* تـم الاذاعه بنجاح ✓')
end 
end 

if msg.forward_info_ and redis:get(boss..'fwd:'..msg.sender_user_id_) then
redis:del(boss..'fwd:'..msg.sender_user_id_)
local pv = redis:smembers(boss..'users')
local groups = redis:smembers(boss..'group:ids')
local allgp =  #pv + #groups
if allgp == 500 then
sendMsg(msg.chat_id_,msg.id_,'📑¦ اهلا عزيزي المطور \n🔖¦ جاري نشر التوجيه للمجموعات وللمشتركين ...')			
end
local number = 0
for i = 1, #pv do 
fwdMsg(pv[i],msg.chat_id_,msg.id_,dl_cb,nil)
end
for i = 1, #groups do 
fwdMsg(groups[i],msg.chat_id_,msg.id_,dl_cb,nil)
end
return sendMsg(msg.chat_id_,msg.id_,'📜*¦* تم اذاعه التوجيه بنجاح 🏌🏻\n🗣*¦* للمـجمـوعآت » *'..#groups..'* \n👥*¦* للخآص » '..#pv..'\n✓')			
end



if msg.text and msg.type == "channel" then
if msg.text:match("^"..Bot_Name.." غادر$") and (msg.SudoBase or msg.SudoUser) then
sendMsg(msg.chat_id_,msg.id_,'اوك باي 😢💔💯') 
rem_data_group(msg.chat_id_)
StatusLeft(msg.chat_id_,our_id)
return false
end
end

if msg.content_.ID == "MessagePhoto" and redis:get(boss..'welcom_ph:witting'..msg.sender_user_id_) then
redis:del(boss..'welcom_ph:witting'..msg.sender_user_id_)
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
redis:set(boss..':WELCOME_BOT',photo_id)
return sendMsg(msg.chat_id_,msg.id_,'🚸 ¦ تم تغيير صـورهہ‏‏ آلترحيب للبوت 🌿\n✓')
end 

if msg.content_.ID == "MessagePhoto" and msg.type == "channel" and msg.GroupActive then
if redis:get(boss..'photo:group'..msg.chat_id_..msg.sender_user_id_) then
redis:del(boss..'photo:group'..msg.chat_id_..msg.sender_user_id_)
if msg.content_.photo_.sizes_[3] then 
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
tdcli_function({ID="ChangeChatPhoto",chat_id_=msg.chat_id_,photo_=GetInputFile(photo_id)},function(arg,data)
if data.code_ == 3 then
sendMsg(arg.chat_id_,arg.id_,'🚸 ¦ ليس لدي صلاحيه تغيير الصوره \n🤖 ¦ يجب اعطائي صلاحيه `تغيير معلومات المجموعه ` ⠀\n✓')
end
end,{chat_id_=msg.chat_id_,id_=msg.id_})
return false
end
end

--=============================================================================================================================
if msg.SudoUser and msg.text and redis:get(boss..'addrdRandom1Public:'..msg.chat_id_..msg.sender_user_id_) then 
if not redis:get(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_) then  -- كلمه الرد
if utf8.len(msg.text) > 25 then return sendMsg(msg.chat_id_,msg.id_,"📛¦ عذرا غير مسموح باضافه كلمه الرد باكثر من 25 حرف \n❕") end
redis:setex(boss..'addrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_,1400,true) 
redis:setex(boss..'replay1RandomPublic'..msg.chat_id_..msg.sender_user_id_,1400,msg.text)
return sendMsg(msg.chat_id_,msg.id_,"📜¦ جيد , يمكنك الان ارسال جواب الرد المتعدد العام \n🔛¦ [[ نص,صوره,فيديو,متحركه,بصمه,اغنيه,ملف ]] \n\n علما ان الاختصارات كالاتي : \n \n{الاسم} : لوضع اسم المستخدم\n{الايدي} : لوضع ايدي المستخدم\n{المعرف} : لوضع معرف المستخدم \n{الرتبه} : لوضع نوع رتبه المستخدم \n{التفاعل} : لوضع تفاعل المستخدم \n{الرسائل} : لاضهار عدد الرسائل \n{النقاط} : لاضهار عدد النقاط \n{التعديل} : لاضهار عدد السحكات \n{البوت} : لاضهار اسم البوت\n{المطور} : لاضهار معرف المطور الاساسي\n\n〽️| يمكنك اضافه 10 ردود متعدد كحد اقصى  \n➼")
end
end



if  msg.SudoUser and msg.text and redis:get(boss..':DelrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_) then
redis:del(boss..':DelrdRandomPublic:'..msg.chat_id_..msg.sender_user_id_)
local DelRd = redis:del(boss..':ReplayRandom:'..msg.text) 
if DelRd == 0 then 
return sendMsg(msg.chat_id_,msg.id_,'🛑*¦* هذا الرد ليس مضاف في الردود العشوائيه 📛')
end
redis:del(boss..':caption_replay:Random:'..msg.text) 
redis:srem(boss..':KlmatRRandom:',msg.text) 
return sendMsg(msg.chat_id_,msg.id_,'🛑*¦* تم حذف الرد بنجاح \n✓')
end
--=============================================================================================================================


if not msg.GroupActive then return false end
if msg.text then

if redis:get(boss..'addrdRandom1:'..msg.chat_id_..msg.sender_user_id_) then -- استقبال الرد للمجموعه فقط

if not redis:get(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_) then  -- كلمه الرد
if utf8.len(msg.text) > 25 then 
return sendMsg(msg.chat_id_,msg.id_,"📛¦ عذرا غير مسموح باضافه كلمه الرد باكثر من 25 حرف \n❕")
end
redis:setex(boss..'addrdRandom:'..msg.chat_id_..msg.sender_user_id_,1400,true) 
redis:setex(boss..'replay1Random'..msg.chat_id_..msg.sender_user_id_,1400,msg.text)
return sendMsg(msg.chat_id_,msg.id_,"📜¦ جيد , يمكنك الان ارسال جواب الرد المتعدد العام \n🔛¦ [[ نص,صوره,فيديو,متحركه,بصمه,اغنيه,ملف ]] \n\n علما ان الاختصارات كالاتي : \n \n{الاسم} : لوضع اسم المستخدم\n{الايدي} : لوضع ايدي المستخدم\n{المعرف} : لوضع معرف المستخدم \n{الرتبه} : لوضع نوع رتبه المستخدم \n{التفاعل} : لوضع تفاعل المستخدم \n{الرسائل} : لاضهار عدد الرسائل \n{النقاط} : لاضهار عدد النقاط \n{التعديل} : لاضهار عدد السحكات \n{البوت} : لاضهار اسم البوت\n{المطور} : لاضهار معرف المطور الاساسي\n\n〽️| يمكنك اضافه 10 ردود متعدد كحد اقصى  \n➼")
end
end


if redis:get(boss..'addrd:'..msg.chat_id_..msg.sender_user_id_) then -- استقبال الرد للمجموعه فقط
if not redis:get(boss..'replay1'..msg.chat_id_..msg.sender_user_id_) then  -- كلمه الرد
if utf8.len(msg.text) > 25 then 
return sendMsg(msg.chat_id_,msg.id_,"📛¦ عذرا غير مسموح باضافه كلمه الرد باكثر من 25 حرف \n❕")
end
redis:hdel(boss..'replay:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_photo:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_voice:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_animation:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_audio:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_sticker:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_video:group:'..msg.chat_id_,msg.text)
redis:setex(boss..'replay1'..msg.chat_id_..msg.sender_user_id_,300,msg.text)
return sendMsg(msg.chat_id_,msg.id_,"📜¦ جيد , يمكنك الان ارسال جواب الرد \n🔛¦ [[ نص,صوره,فيديو,متحركه,بصمه,اغنيه,ملف ]] \n\n علما ان الاختصارات كالاتي : \n \n{الاسم} : لوضع اسم المستخدم\n{الايدي} : لوضع ايدي المستخدم\n{المعرف} : لوضع معرف المستخدم \n{الرتبه} : لوضع نوع رتبه المستخدم \n{التفاعل} : لوضع تفاعل المستخدم \n{الرسائل} : لاضهار عدد الرسائل \n{النقاط} : لاضهار عدد النقاط \n{التعديل} : لاضهار عدد السحكات \n{البوت} : لاضهار اسم البوت\n{المطور} : لاضهار معرف المطور الاساسي\n➼")
end
end

if msg.text and redis:get(boss..':DelrdRandom:'..msg.chat_id_..msg.sender_user_id_) then
redis:del(boss..':DelrdRandom:'..msg.chat_id_..msg.sender_user_id_)
local DelRd = redis:del(boss..':ReplayRandom:'..msg.chat_id_..":"..msg.text) 
if DelRd == 0 then 
return sendMsg(msg.chat_id_,msg.id_,'🛑*¦* هذا الرد ليس مضاف في الردود العشوائيه 📛')
end
redis:del(boss..':caption_replay:Random:'..msg.chat_id_..msg.text) 
redis:srem(boss..':KlmatRRandom:'..msg.chat_id_,msg.text) 
return sendMsg(msg.chat_id_,msg.id_,'🛑*¦* تم حذف الرد بنجاح \n✓')
end

if redis:get(boss..'delrd:'..msg.sender_user_id_) then
redis:del(boss..'delrd:'..msg.sender_user_id_)
local names 	= redis:hget(boss..'replay:'..msg.chat_id_,msg.text)
local photo 	= redis:hget(boss..'replay_photo:group:'..msg.chat_id_,msg.text)
local voice 	= redis:hget(boss..'replay_voice:group:'..msg.chat_id_,msg.text)
local animation = redis:hget(boss..'replay_animation:group:'..msg.chat_id_,msg.text)
local audio 	= redis:hget(boss..'replay_audio:group:'..msg.chat_id_,msg.text)
local files 	= redis:hget(boss..'replay_files:group:'..msg.chat_id_,msg.text)
local sticker 	= redis:hget(boss..'replay_sticker:group:'..msg.chat_id_,msg.text)
local video 	= redis:hget(boss..'replay_video:group:'..msg.chat_id_,msg.text)
if not (names or photo or voice or animation or audio or files or sticker or video) then
return sendMsg(msg.chat_id_,msg.id_,'🛑*¦* هذا الرد ليس مضاف في قائمه الردود 📛')
else
redis:hdel(boss..'replay:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_photo:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_voice:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_audio:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_files:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_animation:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_sticker:group:'..msg.chat_id_,msg.text)
redis:hdel(boss..'replay_video:group:'..msg.chat_id_,msg.text)
return sendMsg(msg.chat_id_,msg.id_,'(['..msg.text..'])\n  ✓ تم مسح الرد 🚀 ')
end 
end

end

if msg.content_.ID == "MessagePinMessage" then
print(" -- pinned -- ")
local msg_pin_id = redis:get(boss..":MsgIDPin:"..msg.chat_id_)
if not msg.Director and not msg.OurBot and redis:get(boss..'lock_pin'..msg.chat_id_) then
if msg_pin_id then
print(" -- pinChannelMessage -- ")
tdcli_function({ID ="PinChannelMessage",
channel_id_ = msg.chat_id_:gsub('-100',''),
message_id_ = msg_pin_id,
disable_notification_ = 0},
function(arg,data)
if data.ID == "Ok" then
sendMsg(arg.chat_id_,arg.id_,"📛‍♂️*¦* عذرا التثبيت مقفل من قبل الاداره تم ارجاع التثبيت القديم\n")
end
end,{chat_id_=msg.chat_id_,id_=msg.id_})
else
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},
function(arg,data) 
if data.ID == "Ok" then
sendMsg(msg.chat_id_,msg.id_,"📛‍♂️*¦* عذرا التثبيت مقفل من قبل الاداره تم الغاء التثبيت\n✓")      
end
end,{chat_id_=msg.chat_id_,id_=msg.id_})
end
return false
end
redis:set(boss..":MsgIDPin:"..msg.chat_id_,msg.id_)
end

if msg.content_.ID == "MessageChatChangePhoto" then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then UserName = "@"..data.username_ else UserName = "احد المشرفين" end
sendMsg(msg.chat_id_,msg.id_," قام ["..UserName.."] بتغير صوره المجموعه ✓\n")
end,{chat_id_=msg.chat_id_,id_=msg.id_})
end

if msg.content_.ID == "MessageChatChangeTitle" then
GetUserID(msg.sender_user_id_,function(arg,data)
redis:set(boss..'group:name'..arg.chat_id_,arg.title_)
if data.username_ then UserName = "@"..data.username_ else UserName = "احد المشرفين" end
sendMsg(arg.chat_id_,arg.id_,"📡¦ قام  ["..UserName.."]\n📭¦ بتغير اسم المجموعه  ✋🏿\n🗯¦ الى "..Flter_Markdown(msg.content_.title_).." \n✓") 
end,{chat_id_=msg.chat_id_,id_=msg.id_,title_=msg.content_.title_})
end

if msg.content_.ID == "MessageChatAddMembers" and redis:get(boss..'welcome:get'..msg.chat_id_) then
local adduserx = tonumber(redis:get(boss..'user:'..msg.sender_user_id_..':msgs') or 0)
if adduserx > 3 then 
redis:del(boss..'welcome:get'..msg.chat_id_)
end
redis:setex(boss..'user:'..msg.sender_user_id_..':msgs',3,adduserx+1)
end

if (msg.content_.ID == "MessageChatAddMembers") then
if redis:get(boss..'welcome:get'..msg.chat_id_) then
if msg.adduserType then
welcome = (redis:get(boss..'welcome:msg'..msg.chat_id_) or "🔖¦ مرحباً عزيزي\n🔖¦ نورت المجموعة \n💂🏼‍♀️")
welcome = welcome:gsub("{القوانين}", redis:get(boss..'rulse:msg'..msg.chat_id_) or "🔖¦ مرحبأ عزيري 👋🏻 القوانين كلاتي 👇🏻\n🔖¦ ممنوع نشر الروابط \n🔖¦ ممنوع التكلم او نشر صور اباحيه \n🔖¦ ممنوع  اعاده توجيه \n🔖¦ ممنوع التكلم بلطائفه \n🔖¦ الرجاء احترام المدراء والادمنيه 😅\n")
if msg.addusername then UserName = '@'..msg.addusername else UserName = '< لا يوجد معرف >' end
local edited = (redis:get(boss..':edited:'..msg.chat_id_..':'..msg.adduser) or 0)
local points = redis:get(boss..':User_Points:'..msg.chat_id_..msg.adduser) or 0
local msgs = redis:get(boss..'msgs:'..msg.adduser..':'..msg.chat_id_) or 1

if msg.adduser == SUDO_ID then 
gtupe = 'المطور الاساسي' 
elseif redis:sismember(boss..':SUDO_BOT:',msg.adduser) then 
gtupe = 'المطور'
elseif msg.GroupActive and redis:sismember(boss..':MONSHA_Group:'..msg.chat_id_,msg.adduser) then 
gtupe = 'منشئ اساسي'
elseif msg.GroupActive and redis:sismember(boss..':MONSHA_BOT:'..msg.chat_id_,msg.adduser) then 
gtupe = 'المنشىء'
elseif msg.GroupActive and redis:sismember(boss..'owners:'..msg.chat_id_,msg.adduser) then 
gtupe = 'المدير' 
elseif msg.GroupActive and redis:sismember(boss..'admins:'..msg.chat_id_,msg.adduser) then 
gtupe = 'الادمن'
elseif msg.GroupActive and redis:sismember(boss..'whitelist:'..msg.chat_id_,msg.adduser) then 
gtupe = 'عضو مميز'
elseif msg.adduser == our_id then
gtupe = "بوت"
else
gtupe = 'فقط عضو 🙍🏼‍♂️'
end

welcome = welcome:gsub("{المجموعه}",Flter_Markdown((redis:get(boss..'group:name'..msg.chat_id_) or '')))
local welcome = welcome:gsub("{المعرف}",UserName)
local welcome = welcome:gsub("{الايدي}",msg.adduser)
local welcome = welcome:gsub("{الرتبه}",gtupe)
local welcome = welcome:gsub("{التفاعل}",Get_Ttl(msgs))
local welcome = welcome:gsub("{الرسائل}",msgs)
local welcome = welcome:gsub("{النقاط}",points)
local welcome = welcome:gsub("{التعديل}",edited)
local welcome = welcome:gsub("{البوت}",redis:get(boss..':NameBot:'))
local welcome = welcome:gsub("{المطور}",SUDO_USER)
local welcome = welcome:gsub("{الاسم}",FlterName(msg.addname,20))
sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(welcome))
return false
end 
end 
end 

if (msg.content_.ID == "MessageChatJoinByLink") then
if redis:get(boss..'welcome:get'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
welcome = (redis:get(boss..'welcome:msg'..msg.chat_id_) or "🔖¦ مرحباً عزيزي\n🔖¦ نورت المجموعة \n💂🏼‍♀️")
welcome = welcome:gsub("{القوانين}", redis:get(boss..'rulse:msg'..msg.chat_id_) or "🔖¦ مرحبأ عزيري 👋🏻 القوانين  👇🏻\n🔖¦ ممنوع نشر الروابط \n🔖¦ ممنوع التكلم او نشر صور اباحيه \n🔖¦ ممنوع  اعاده توجيه \n🔖¦ ممنوع التكلم بلطائفه \n🔖¦ الرجاء احترام المدراء والادمنيه 😅\n")
if data.username_ then UserName = '@'..data.username_ else UserName = '< لا يوجد معرف >' end
local edited = (redis:get(boss..':edited:'..msg.chat_id_..':'..msg.sender_user_id_) or 0)
local points = redis:get(boss..':User_Points:'..msg.chat_id_..msg.sender_user_id_) or 0
local msgs = redis:get(boss..'msgs:'..msg.sender_user_id_..':'..msg.chat_id_) or 1
welcome = welcome:gsub("{المجموعه}",Flter_Markdown((redis:get(boss..'group:name'..msg.chat_id_) or '')))
local welcome = welcome:gsub("{المعرف}",UserName)
local welcome = welcome:gsub("{الايدي}",msg.sender_user_id_)
local welcome = welcome:gsub("{الرتبه}",msg.TheRank)
local welcome = welcome:gsub("{التفاعل}",Get_Ttl(msgs))
local welcome = welcome:gsub("{الرسائل}",msgs)
local welcome = welcome:gsub("{النقاط}",points)
local welcome = welcome:gsub("{التعديل}",edited)
local welcome = welcome:gsub("{البوت}",redis:get(boss..':NameBot:'))
local welcome = welcome:gsub("{المطور}",SUDO_USER)
local welcome = welcome:gsub("{الاسم}",FlterName(data.first_name_..' '..(data.last_name_ or "" ),20))
sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(welcome)) 
end)
end
return false
end

if msg.edited and not msg.SuperCreator and redis:get(boss.."antiedit"..msg.chat_id_) then 
if not msg.text then
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg 
local usersmnc   = ""
local NameUser   = Hyper_Link_Name(data)
if data.username_  then uuseri = "\n🔬¦ معرفه : @["..data.username_.."]"  else uuseri = "" end
local monsha = redis:smembers(boss..':MONSHA_Group:'..msg.chat_id_)
Rwers = ""
if msg.content_.ID == "MessagePhoto" then
Rwers = "صوره"
elseif msg.content_.ID == "MessageSticker"  then
Rwers = "ملصق"
elseif msg.content_.ID == "MessageVoice"  then
Rwers = "بصمه"
elseif msg.content_.ID == "MessageAudio"  then
Rwers = "صوت"
elseif msg.content_.ID == "MessageVideo"  then
Rwers = "فيديو"
elseif msg.content_.ID == "MessageAnimation"  then
Rwers = "متحركه"
else
Rwers = "نصي رابط"
end
if #monsha ~= 0 then 
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v) if info and info.username and info.username:match("@[%a%d_]+") then usersmnc = usersmnc..info.username.." - " end
sendMsg(v,0,"📇¦ هناك شخص قام بالتعديل \n👲🏼¦ الاسم : ⋙「 "..NameUser.." 」 "..uuseri.."\n🀄️¦ الايدي : `"..msg.sender_user_id_.."`\n📬¦ رتبته : "..Getrtba(msg.sender_user_id_,msg.chat_id_).."\n🔌¦ نوع التعديل : "..Rwers.."\n📱¦ المجموعة : "..Flter_Markdown((redis:get(boss..'group:name'..msg.chat_id_) or '')).."\n🔅¦ الرابط : "..redis:get(boss..'linkGroup'..msg.chat_id_).." \n🚸" )
end
end
return sendMsg(msg.chat_id_,msg.id_,"📢¦ نداء لمنشئيين : ["..usersmnc.."] \n📇¦ هناك شخص قام بالتعديل"..uuseri.."\n👲🏼¦ الاسم : ⋙「 "..NameUser.." 」 \n🀄️¦ الايدي : `"..msg.sender_user_id_.."`\n📬¦ رتبته : "..Getrtba(msg.sender_user_id_,msg.chat_id_).."\n🔌¦ نوع التعديل : "..Rwers.."\n🚸" )   

end,{msg=msg})
Del_msg(msg.chat_id_,msg.id_)
end
if (msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or msg.text:match("[Tt].[Mm][Ee]/") 
or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or msg.text:match(".[Pp][Ee]") 
or msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or msg.text:match("[Hh][Tt][Tt][Pp]://") 
or msg.text:match("[Ww][Ww][Ww].") 
or msg.text:match(".[Cc][Oo][Mm]")) 
then
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg 
local usersmnc   = ""
local NameUser   = Hyper_Link_Name(data)
if data.username_  then uuseri = "\n🔬¦ معرفه : @["..data.username_.."]"  else uuseri = "" end
local monsha = redis:smembers(boss..':MONSHA_Group:'..msg.chat_id_)

Rwers = "نصي رابط"

if #monsha ~= 0 then 
for k,v in pairs(monsha) do
local info = redis:hgetall(boss..'username:'..v) if info and info.username and info.username:match("@[%a%d_]+") then usersmnc = usersmnc..info.username.." - " end
sendMsg(v,0,"📇¦ هناك شخص قام بالتعديل \n👲🏼¦ الاسم : ⋙「 "..NameUser.." 」 "..uuseri.."\n🀄️¦ الايدي : `"..msg.sender_user_id_.."`\n📬¦ رتبته : "..Getrtba(msg.sender_user_id_,msg.chat_id_).."\n🔌¦ نوع التعديل : "..Rwers.."\n📱¦ المجموعة : "..Flter_Markdown((redis:get(boss..'group:name'..msg.chat_id_) or '')).."\n🔅¦ الرابط : "..redis:get(boss..'linkGroup'..msg.chat_id_).." \n🚸" )
end
end
return sendMsg(msg.chat_id_,msg.id_,"📢¦ نداء لمنشئيين : ["..usersmnc.."] \n📇¦ هناك شخص قام بالتعديل"..uuseri.."\n👲🏼¦ الاسم : ⋙「 "..NameUser.." 」 \n🀄️¦ الايدي : `"..msg.sender_user_id_.."`\n📬¦ رتبته : "..Getrtba(msg.sender_user_id_,msg.chat_id_).."\n🔌¦ نوع التعديل : "..Rwers.."\n🚸" )   

end,{msg=msg})
Del_msg(msg.chat_id_,msg.id_)
end
end



if not msg.Admin and not msg.Special then -- للاعضاء فقط  

if not msg.forward_info_ and msg.content_.ID ~= "MessagePhoto" and redis:get(boss..'lock_flood'..msg.chat_id_)  then
local msgs = (redis:get(boss..'user:'..msg.sender_user_id_..':msgs') or 0)
local NUM_MSG_MAX = (redis:get(boss..'num_msg_max'..msg.chat_id_) or 5)
if tonumber(msgs) > tonumber(NUM_MSG_MAX) then 
redis:setex(boss..'sender:'..msg.sender_user_id_..':'..msg.chat_id_..'flood',30,true)
GetUserID(msg.sender_user_id_,function(arg,datau)
Restrict(arg.chat_id_,arg.sender_user_id_,1)
if datau.username_ then USERNAME = '@'..datau.username_ else USERNAME = FlterName(datau.first_name_..' '..(datau.last_name_ or "")) end
SendMention(arg.chat_id_,datau.id_,arg.id_,"👤¦ العضو » "..USERNAME.."\n🚸¦ قمـت بتگرآر آگثر مـن "..arg.NUM_MSG_MAX.." رسـآلهہ‌‏ , لذآ تم تقييدگ مـن آلمـجمـوعهہ‌‏ ✓\n",12,utf8.len(USERNAME)) 
end,{chat_id_=msg.chat_id_,id_=msg.id_,NUM_MSG_MAX=NUM_MSG_MAX,sender_user_id_=msg.sender_user_id_})
return false
end 
redis:setex(boss..'user:'..msg.sender_user_id_..':msgs',2,msgs+1)
end


if msg.forward_info_ then
if redis:get(boss..'mute_forward'..msg.chat_id_) then -- قفل التوجيه
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del Becuse Send Fwd \27[0m")

if data.ID == "Error" and data.code_ == 6 then 
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) and not redis:get(boss..':User_Fwd_Msg:'..msg.sender_user_id_..':flood') then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع اعادة التوجيه  \n📛",12,utf8.len(USERNAME)) 
return redis:setex(boss..':User_Fwd_Msg:'..msg.sender_user_id_..':flood',15,true)
end,nil)
end
end)
return false
elseif redis:get(boss..':tqeed_fwd:'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del Becuse Send Fwd tqeed \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,1)
end)
return false 
end
elseif msg.edited and msg.content_.ID ~= "MessageText" and redis:get(boss..'lock_edit'..msg.chat_id_) then -- قفل التعديل
Del_msg(msg.chat_id_,msg.id_,function(arg,data) 
print("\27[1;31m Msg Del becuse send Edit \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذراً ممنوع التعديل تم المسح \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif tonumber(msg.via_bot_user_id_) ~= 0 and redis:get(boss..'mute_inline'..msg.chat_id_) then -- قفل الانلاين
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send inline \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا الانلاين مقفول  \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.text then -- رسايل فقط
if utf8.len(msg.text) > 500 and redis:get(boss..'lock_spam'..msg.chat_id_) then -- قفل الكليشه 
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send long msg \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ ممنوع ارسال الكليشه والا سوف تجبرني على طردك  \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif (msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or msg.text:match("[Tt].[Mm][Ee]/") 
or msg.text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or msg.text:match(".[Pp][Ee]") 
or msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") 
or msg.text:match("[Hh][Tt][Tt][Pp]://") 
or msg.text:match("[Ww][Ww][Ww].") 
or msg.text:match(".[Cc][Oo][Mm]")) 
and redis:get(boss..':tqeed_link:'..msg.chat_id_)  then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m The user i restricted becuse send link \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,1)
end)
return false
elseif(msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or msg.text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Oo][Rr][Gg]/") 
or msg.text:match("[Tt].[Mm][Ee]/") or msg.text:match(".[Pp][Ee]")) 
and redis:get(boss..'lock_link'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send link \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ ممنوع ارسال الروابط  \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif (msg.text:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.text:match("[Hh][Tt][Tt][Pp]://") or msg.text:match("[Ww][Ww][Ww].") or msg.text:match(".[Cc][Oo][Mm]") or msg.text:match(".[Tt][Kk]") or msg.text:match(".[Mm][Ll]") or msg.text:match(".[Oo][Rr][Gg]")) and redis:get(boss..'lock_webpage'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send web link \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ ممنوع ارسال روابط الويب   \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif (msg.text:match("ه‍") or msg.text:match("ی") or msg.text:match("ک")) and redis:get(boss.."lock_pharsi"..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send lock_pharsi \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ ممنوع ارسال الفارسيه  \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif KlmatMmno3(msg.text) and redis:get(boss.."lock_mmno3"..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send mseeea \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ ممنوع ارسال الكلمات المسيئه  \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.text:match("[a-zA-Z]") and redis:get(boss.."lock_lang"..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send En \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ ممنوع ارسال الانكليزيه  \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.text:match("#.+") and redis:get(boss..'lock_tag'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send tag \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ ممنوع ارسال التاك  \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.text:match("@[%a%d_]+")  and redis:get(boss..'lock_username'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send username \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ ممنوع ارسال المعرف   \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif not msg.textEntityTypeBold and (msg.textEntityTypeBold or msg.textEntityTypeItalic) and redis:get(boss..'lock_markdown'..msg.chat_id_) then 
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send markdown \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ ممنوع ارسال الماركدوان  \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.textEntityTypeTextUrl and redis:get(boss..'lock_webpage'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send web page \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦  .ممنوع ارسال روابط الويب   \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
end 
elseif msg.content_.ID == "MessageUnsupported" and redis:get(boss..'mute_video'..msg.chat_id_) then -- قفل الفيديو
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send video \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع ارسال الفيديو كام \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.content_.ID == "MessagePhoto" then
if redis:get(boss..'mute_photo'..msg.chat_id_)  then -- قفل الصور
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send photo \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع ارسال الصور  \n📛",12,utf8.len(USERNAME))
end,nil)
end
end)
return false
elseif redis:get(boss..':tqeed_photo:'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m The user resctricted becuse send photo \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,3)
end)
return false
end
elseif msg.content_.ID == "MessageVideo" then
if redis:get(boss..'mute_video'..msg.chat_id_) then -- قفل الفيديو
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send vedio \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع ارسال الفيديو  \n📛",12,utf8.len(USERNAME)) 
end,nil)   
end
end)
return false
elseif redis:get(boss..':tqeed_video:'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m The user restricted becuse send video \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,3)
end)
return false
end
elseif msg.content_.ID == "MessageDocument" and redis:get(boss..'mute_document'..msg.chat_id_) then -- قفل الملفات
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send file \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع ارسال الملفات  \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.content_.ID == "MessageSticker" and redis:get(boss..'mute_sticker'..msg.chat_id_) then --قفل الملصقات
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send sticker \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع ارسال الملصقات  \n📛",12,utf8.len(USERNAME)) 
end,nil)   
end
end)
return false
elseif msg.content_.ID == "MessageAnimation" then
if redis:get(boss..'mute_gif'..msg.chat_id_) then -- قفل المتحركه
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send gif \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع ارسال الصور المتحركه  \n📛",12,utf8.len(USERNAME)) 
end,nil)   
end
end)
return false
elseif redis:get(boss..':tqeed_gif:'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m The user restricted becuse send gif \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
Restrict(msg.chat_id_,msg.sender_user_id_,3)
end)
return false
end
elseif msg.content_.ID == "MessageContact" and redis:get(boss..'mute_contact'..msg.chat_id_) then -- قفل الجهات
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send Contact \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME..'\n📛¦ عذرا ممنوع ارسال جهات الاتصال  \n📛',12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.content_.ID == "MessageLocation" and redis:get(boss..'mute_location'..msg.chat_id_) then -- قفل الموقع
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send location \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع ارسال الموقع  \n📛",12,utf8.len(USERNAME))
end,nil)
end
end)
return false
elseif msg.content_.ID == "MessageVoice" and redis:get(boss..'mute_voice'..msg.chat_id_) then -- قفل البصمات
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send voice \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع ارسال البصمات  \n📛",12,utf8.len(USERNAME))
end,nil)   
end
end)
return false
elseif msg.content_.ID == "MessageGame" and redis:get(boss..'mute_game'..msg.chat_id_) then -- قفل الالعاب
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send game \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع لعب الالعاب  \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.content_.ID == "MessageAudio" and redis:get(boss..'mute_audio'..msg.chat_id_) then -- قفل الصوت
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send audio \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع ارسال الصوت  \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif msg.reply_markup and  msg.reply_markup.ID == "replyMarkupInlineKeyboard" and redis:get(boss..'mute_keyboard'..msg.chat_id_) then -- كيبورد
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send keyboard \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا الكيبورد مقفول  \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
end

if msg.content_.caption_ then -- الرسايل الي بالكابشن
if (msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") 
or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") 
or msg.content_.caption_:match("[Tt].[Mm][Ee]/") 
or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") 
or msg.content_.caption_:match(".[Pp][Ee]")) 
and redis:get(boss..'lock_link'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send link caption \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع ارسال الروابط  \n📛",12,utf8.len(USERNAME)) 
end,nil)
end
end)
return false
elseif (msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") 
or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") 
or msg.content_.caption_:match("[Ww][Ww][Ww].") 
or msg.content_.caption_:match(".[Cc][Oo][Mm]")) 
and redis:get(boss..'lock_webpage'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send webpage caption \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع ارسال روابط الويب  \n📛",12,utf8.len(USERNAME))
end,nil)
end
end)
return false
elseif msg.content_.caption_:match("@[%a%d_]+") and redis:get(boss..'lock_username'..msg.chat_id_) then
Del_msg(msg.chat_id_,msg.id_,function(arg,data)
print("\27[1;31m Msg Del becuse send username caption \27[0m")
if data.ID == "Error" and data.code_ == 6 then
return sendMsg(msg.chat_id_,msg.id_,'📛*¦* لا يمكنني مسح الرساله المخالفه .\n🎟*¦* لست مشرف او ليس لدي صلاحيه  الحذف \n ❕')    
end
if redis:get(boss..'lock_woring'..msg.chat_id_) then
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
SendMention(msg.chat_id_,data.id_,msg.id_,"👤¦ العضو » "..USERNAME.."\n📛¦ عذرا ممنوع ارسال التاك او المعرف  \n📛",12,utf8.len(USERNAME))
end,nil)
end 
end)
return false
end 


end --========{ End if } ======

end 
SaveNumMsg(msg)

if msg.text then
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg



if redis:get(boss.."lock_RandomRdod"..msg.chat_id_) then 
local Replay = 0
Replay = redis:smembers(boss..':ReplayRandom:'..msg.text) 
if #Replay ~= 0 then 
local Replay = Replay[math.random(#Replay)]
Replay = convert_Klmat(msg,data,Replay,true)
local CaptionFilter = Replay:gsub(":Text:",""):gsub(":Document:",""):gsub(":Voice:",""):gsub(":Photo:",""):gsub(":Animation:",""):gsub(":Audio:",""):gsub(":Sticker:",""):gsub(":Video:","")
Caption = redis:hget(boss..':caption_replay:Random:'..msg.text,CaptionFilter)
Caption = convert_Klmat(msg,data,Caption)
if Replay:match(":Text:") then
return sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(Replay:gsub(":Text:","")))
elseif Replay:match(":Document:") then 
return sendDocument(msg.chat_id_,msg.id_,Replay:gsub(":Document:",""),Caption)  
elseif Replay:match(":Photo:") then 
return sendPhoto(msg.chat_id_,msg.id_,Replay:gsub(":Photo:",""),Caption)  
elseif Replay:match(":Voice:") then 
return sendVoice(msg.chat_id_,msg.id_,Replay:gsub(":Voice:",""),Caption)
elseif Replay:match(":Animation:") then 
return sendAnimation(msg.chat_id_,msg.id_,Replay:gsub(":Animation:",""),Caption)  
elseif Replay:match(":Audio:") then 
return sendAudio(msg.chat_id_,msg.id_,Replay:gsub(":Audio:",""),"",Caption)  
elseif Replay:match(":Sticker:") then 
return sendSticker(msg.chat_id_,msg.id_,Replay:gsub(":Sticker:",""))  
elseif Replay:match(":Video:") then 
return sendVideo(msg.chat_id_,msg.id_,Replay:gsub(":Video:",""),Caption)
end
end


local Replay = 0
Replay = redis:smembers(boss..':ReplayRandom:'..msg.chat_id_..":"..msg.text) 
if #Replay ~= 0 then 
local Replay = Replay[math.random(#Replay)]
Replay = convert_Klmat(msg,data,Replay,true)
local CaptionFilter = Replay:gsub(":Text:",""):gsub(":Document:",""):gsub(":Voice:",""):gsub(":Photo:",""):gsub(":Animation:",""):gsub(":Audio:",""):gsub(":Sticker:",""):gsub(":Video:","")
Caption = redis:hget(boss..':caption_replay:Random:'..msg.chat_id_..msg.text,CaptionFilter)
Caption = convert_Klmat(msg,data,Caption)
if Replay:match(":Text:") then
return sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(Replay:gsub(":Text:","")))
elseif Replay:match(":Document:") then 
return sendDocument(msg.chat_id_,msg.id_,Replay:gsub(":Document:",""),Caption)  
elseif Replay:match(":Photo:") then 
return sendPhoto(msg.chat_id_,msg.id_,Replay:gsub(":Photo:",""),Caption)  
elseif Replay:match(":Voice:") then 
return sendVoice(msg.chat_id_,msg.id_,Replay:gsub(":Voice:",""),Caption)
elseif Replay:match(":Animation:") then 
return sendAnimation(msg.chat_id_,msg.id_,Replay:gsub(":Animation:",""),Caption)  
elseif Replay:match(":Audio:") then 
return sendAudio(msg.chat_id_,msg.id_,Replay:gsub(":Audio:",""),"",Caption)  
elseif Replay:match(":Sticker:") then 
return sendSticker(msg.chat_id_,msg.id_,Replay:gsub(":Sticker:",""))  
elseif Replay:match(":Video:") then 
return sendVideo(msg.chat_id_,msg.id_,Replay:gsub(":Video:",""),Caption)
end
end

end

if redis:get(boss..'replay'..msg.chat_id_) then
local Replay = false

Replay = redis:hget(boss..'replay:all',msg.text)
if Replay then
Replay = convert_Klmat(msg,data,Replay,true)
sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(Replay))
return false
end

Replay = redis:hget(boss..'replay:'..msg.chat_id_,msg.text)
if Replay then 
Replay = convert_Klmat(msg,data,Replay,true)
sendMsg(msg.chat_id_,msg.id_,Flter_Markdown(Replay)) 
return false
end

Replay = redis:hget(boss..'replay_photo:group:',msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
print(Caption)
sendPhoto(msg.chat_id_,msg.id_,Replay,Caption)  
return false
end

Replay = redis:hget(boss..'replay_voice:group:',msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendVoice(msg.chat_id_,msg.id_,Replay,Caption)
return false
end

Replay = redis:hget(boss..'replay_animation:group:',msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendAnimation(msg.chat_id_,msg.id_,Replay,Caption)  
return false
end

Replay = redis:hget(boss..'replay_audio:group:',msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendAudio(msg.chat_id_,msg.id_,Replay,"",Caption)  
return false
end


Replay = redis:hget(boss..'replay_files:group:'..msg.chat_id_,msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendDocument(msg.chat_id_,msg.id_,Replay,Caption)  
return false
end

Replay = redis:hget(boss..'replay_files:group:',msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendDocument(msg.chat_id_,msg.id_,Replay,Caption)  
return false
end

Replay = redis:hget(boss..'replay_sticker:group:',msg.text)
if Replay then 
sendSticker(msg.chat_id_,msg.id_,Replay)  
return false
end

Replay = redis:hget(boss..'replay_video:group:',msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendVideo(msg.chat_id_,msg.id_,Replay,Caption)
return false
end

Replay = redis:hget(boss..'replay_photo:group:'..msg.chat_id_,msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendPhoto(msg.chat_id_,msg.id_,Replay,Caption)  
return false
end

Replay = redis:hget(boss..'replay_voice:group:'..msg.chat_id_,msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendVoice(msg.chat_id_,msg.id_,Replay,Caption)
return false
end

Replay = redis:hget(boss..'replay_animation:group:'..msg.chat_id_,msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendAnimation(msg.chat_id_,msg.id_,Replay,Caption)  
return false
end

Replay = redis:hget(boss..'replay_audio:group:'..msg.chat_id_,msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendAudio(msg.chat_id_,msg.id_,Replay,"",Caption)  
return false
end

Replay = redis:hget(boss..'replay_sticker:group:'..msg.chat_id_,msg.text)
if Replay then 
sendSticker(msg.chat_id_,msg.id_,Replay)  
return false
end

Replay = redis:hget(boss..'replay_video:group:'..msg.chat_id_,msg.text)
if Replay then 
Caption = redis:hget(boss..':caption_replay:'..msg.chat_id_,msg.text)
Caption = convert_Klmat(msg,data,Caption)
sendVideo(msg.chat_id_,msg.id_,Replay,Caption)
return false
end
end

end,{msg=msg})


------------------------------{ Start Replay Send }------------------------



end

if msg.text and redis:get(boss.."lock_rdodSource"..msg.chat_id_) then

--================================{{  Reply Bot  }} ===================================

local su = {
"نعم حبيبي المطور 🌝❤",
"يابعد روح ["..Bot_Name.."] 😘❤️",
"هلا بمطوري العشق أمرني"}
local ss97 = {
"ها حياتي😻","عيونه 👀 وخشمه 👃🏻واذانه👂🏻",
"باقي ويتمدد 😎","ها حبي 😍","ها عمري 🌹","اجيت اجيت كافي لتصيح 🌚👌",
"هياتني اجيت 🌚❤️","نعم حبي 😎","هوه غير يسكت عاد ها شتريد 😷",
"احجي بسرعه شتريد 😤","ها يا كلبي ❤️","هم صاحو عليه راح ابدل اسمي من وراكم 😡",
"لك فداك ["..Bot_Name.."] حبيبي انت اموووح 💋","دا اشرب جاي تعال غير وكت 😌","كول حبيبي أمرني 😍",
"احجي فضني شرايد ولا اصير ضريف ودكلي جرايد لو مجلات تره بايخه 😒😏",
"اشتعلو اهل ["..Bot_Name.."] شتريد 😠","بووووووووو 👻 ها ها فزيت شفتك شفتك لا تحلف 😂",
"طالع مموجود 😒","هااا شنوو اكو حاته بالكروب وصحت عليه  😍💕","انت مو قبل يومين غلطت عليه؟  😒",
"راجع المكتب حبيبي عبالك ["..Bot_Name.."] سهل تحجي ويا 😒","ياعيون ["..Bot_Name.."] أمرني 😍",
"لك دبدل ملابسي اطلع برااااا 😵😡 ناس متستحي","سويت هواي شغلات سخيفه بحياتي بس عمري مصحت على واحد وكلتله انجب 😑",
"مشغول ويا ضلعتي  ☺️","مازا تريد منه 😌🍃"
}
local bs = {
"مابوس 🌚💔",
"اآآآم͠ــ.❤️😍ــو͠و͠و͠آ͠آ͠ح͠❤️عسسـل❤️",
"الوجه ميساعد 😐✋",
"ممممح😘ححح😍😍💋",
}
local ns = {
"🌹 هــلــℌelℓoووات🌹عمـ°🌺°ــري🙊😋",
"هْـٌﮩٌﮧٌ﴿🙃﴾ﮩٌـ୭ٌ୭ـْلوُّات†😻☝️",
"هلاوو99وووات نورت/ي ❤️🙈",
"هلووات 😊🌹",
}
local sh = {
"اهلا عزيزي المطور 😽❤️",
"هلوات . نورت مطوري 😍",
}
local lovm = {
"اكرهك 😒👌🏿",
"دي 😑👊🏾",
"اعشكك/ج مح 😍💋",
"اي احبك/ج 😍❤️",
"ماحبك/ج 😌🖖",
"امـــوت فيك ☹️",
"اذا كتلك/ج احبك/ج شراح تستفاد/ين 😕❤️",
"ولي ماحبك/ج 🙊💔",
}
local song = {
"عمي يبو البار 🤓☝🏿️ \nصبلي لبلبي ترى اني سكران 😌 \n وصاير عصبي 😠 \nانه وياج يم شامه 😉 \nوانه ويــــا�� يم شامه  شد شد  👏🏿👏🏿 \nعدكم سطح وعدنه سطح 😁 \n نتغازل لحد الصبح 😉 \n انه وياج يم شامه 😍 \n وانه وياج فخريه وانه وياج حمديه 😂🖖🏿\n ",
"اي مو كدامك مغني قديم 😒🎋 هوه ﴿↜ انـِۨـۛـِۨـۛـِۨيـُِـٌِہۧۥۛ ֆᵛ͢ᵎᵖ ⌯﴾❥  ربي كامز و تكلي غنيلي 🙄😒🕷 آإرۈحُـ✯ـہ✟  😴أنــ💤ــااااام😴  اشرف تالي وكت يردوني اغني 😒☹️🚶","لا تظربني لا تظرب 💃💃 كسرت الخيزارانه💃🎋 صارلي سنه وست اشهر💃💃 من ظربتك وجعانه🤒😹",
"موجوع كلبي😔والتعب بية☹️من اباوع على روحي😢ينكسر كلبي عليه😭",
"ايامي وياها👫اتمنا انساها😔متندم اني حيل😞يم غيري هيه💃تضحك😂عليه😔مقهور انام الليل😢كاعد امسح بل رسائل✉️وجان اشوف كل رسايلها📩وبجيت هوايه😭شفت احبك😍واني من دونك اموت😱وشفت واحد 🚶صار هسه وياية👬اني رايدها عمر عمر تعرفني كل زين🙈 وماردت لا مصلحة ولاغايه😕والله مافد يوم بايسها💋خاف تطلع🗣البوسه💋وتجيها حجايه😔️",
"😔صوتي بعد مت سمعه✋يال رايح بلا رجعة🚶بزودك نزلت الدمعة ذاك اليوم☝️يال حبيتلك ثاني✌روح وياه وضل عاني😞يوم اسود علية اني🌚 ذاك اليوم☝️تباها بروحك واضحك😂لان بجيتلي عيني😢😭 وافراح يابعد روحي😌خل الحركة تجويني😔🔥صوتي بعد متسمعة🗣✋",
}

local Text = msg.text
local Text2 = Text:match("^"..Bot_Name.." (%d+)$")

if msg.SudoUser and Text == Bot_Name and not Text2 then
return sendMsg(msg.chat_id_,msg.id_,su[math.random(#su)])
elseif not msg.SudoUser and Text== Bot_Name and not Text2 then  
return sendMsg(msg.chat_id_,msg.id_,ss97[math.random(#ss97)])
elseif Text:match("^كول (.*)$") then
if utf8.len(Text:match("^كول (.*)$")) > 50 then 
return sendMsg(msg.chat_id_,msg.id_,"📛¦ ما اكدر اكول اكثر من 50 حرف 🙌🏾")
end
local callback_Text = FlterName(Text:match("^كول (.*)$"),50)
if callback_Text and callback_Text == 'الاسم سبام 📛' then
return sendMsg(msg.chat_id_,msg.id_,"📛¦ للاسف النص هذا مخالف ")
else
return sendMsg(msg.chat_id_,0,callback_Text) 
end
elseif Text:match("^"..Bot_Name.." اتفل (.*)$") then
if msg.reply_id then
sendMsg(msg.chat_id_,msg.id_,'اوك سيدي 🌝🍃')
sendMsg(msg.chat_id_,msg.reply_id,'ختفوووووووووو💦💦️️')
else 
return sendMsg(msg.chat_id_,msg.id_,"  🕵🏻 وينه بله سويله رد 🙄")
end
elseif Text:match("^"..Bot_Name.." رزله(.*)$") and msg.SudoUser then
if msg.reply_id then
sendMsg(msg.chat_id_,msg.id_,'اوك سيدي 🌝🍃')
return sendMsg(msg.chat_id_,msg.reply_id,'تعال هيوو  😒 شو طالعه عينك ولسانك طويل سربوت  اشو تعال بله شنو هاذ ويهك هاذ 😳 كول بلعباس , 😅 لك #دي وتفو بعد لتندك بتاج راسك خوش حمبقلبي  👍🏿') 
end
elseif Text:match("^بوس (.*)$") then 
if msg.reply_id then 
return sendMsg(msg.chat_id_,msg.reply_id,bs[math.random(#bs)])
else
return sendMsg(msg.chat_id_,msg.id_,"📌 وينه بله سويله رد 🕵🏻")
end 
elseif msg.SudoUser and Text=="هلو" then 
return sendMsg(msg.chat_id_,msg.id_,sh[math.random(#sh)])
elseif not msg.SudoUser and Text=="هلو" then 
return sendMsg(msg.chat_id_,msg.id_,ns[math.random(#ns)])
elseif msg.SudoUser and Text== "احبك" then 
return sendMsg(msg.chat_id_,msg.id_,"اموت عليك حياتي  😍❤️")
elseif msg.SudoUser and Text== "تحبني" or Text=="حبك" then 
return sendMsg(msg.chat_id_,msg.id_,"اموت عليك حياتي  😍❤️")
elseif not msg.SudoUser and Text== "احبك" or Text=="حبك" then 
return sendMsg(msg.chat_id_,msg.id_,lovm[math.random(#lovm)])
elseif not msg.SudoUser and Text== "تحبني" then
return sendMsg(msg.chat_id_,msg.id_,lovm[math.random(#lovm)])
elseif Text== "غني" or Text=="غنيلي" then 
return sendMsg(msg.chat_id_,msg.id_,song[math.random(#song)])
elseif Text=="اتفل" or Text=="تفل" then
if msg.Admin then 
return sendMsg(msg.chat_id_,msg.id_,'ختفوووووووووو💦💦️️')
else 
return sendMsg(msg.chat_id_,msg.id_,"📌 انجب ما اتفل عيب 😼🙌🏿") 
end
elseif Text== "تف" then return sendMsg(msg.chat_id_,msg.id_,"عيب ابني/بتي اتفل/ي اكبر منها شوية 😌😹")
elseif Text== "شلونكم" or Text== "شلونك" or Text== "شونك" or Text== "شونكم" then 
return sendMsg(msg.chat_id_,msg.id_,"احســن مــن انتهــــہ شــلونـــك شــخــبـارك يـــول مۂــــشتـــاقـــلك شــو ماكـــو 😹🌚")
elseif Text== "صاكه"  then return sendMsg(msg.chat_id_,msg.id_,"اووويلي يابه 😍❤️ دزلي صورتهه 🐸💔")
elseif Text== "وينك"  then return sendMsg(msg.chat_id_,msg.id_,"دور بكلبك وتلكاني 😍😍❤️")
elseif Text== "منورين"  then return sendMsg(msg.chat_id_,msg.id_,"من نورك عمري ❤️🌺")
elseif Text== "هاي"  then return sendMsg(msg.chat_id_,msg.id_,"هايات عمري 😍🍷")
elseif Text== "🙊"  then return sendMsg(msg.chat_id_,msg.id_,"فديت الخجول 🙊 😍")
elseif Text== "😢"  then return sendMsg(msg.chat_id_,msg.id_,"لتبجي حياتي 😢")
elseif Text== "😭"  then return sendMsg(msg.chat_id_,msg.id_,"لتبجي حياتي 😭😭")
elseif Text== "منور"  then return sendMsg(msg.chat_id_,msg.id_,"نِْـِْـــِْ([💡])ِْــــًِـًًْـــِْـِْـِْـورِْكِْ")
elseif Text== "😒" and not is_sudo then return sendMsg(msg.chat_id_,msg.id_,"شبيك-ج عمو 🤔")
elseif Text== "مح"  then return sendMsg(msg.chat_id_,msg.id_,"محات حياتي🙈❤")
elseif Text== "شكرا" or Text== "ثكرا" then return  sendMsg(msg.chat_id_,msg.id_,"{ •• الـّ~ـعـفو •• }")
elseif Text== "انته وين"  then return sendMsg(msg.chat_id_,msg.id_,"بالــبــ🏠ــيــت")
elseif Text== "😍"  then return sendMsg(msg.chat_id_,msg.id_," يَمـه̷̐ إآلُحــ❤ــب يَمـه̷̐ ❤️😍")
elseif Text== "اكرهك"  then return sendMsg(msg.chat_id_,msg.id_,"ديله شلون اطيق خلقتك اني😾🖖🏿🕷")
elseif Text== "اريد اكبل" then return sendMsg(msg.chat_id_,msg.id_,"خخ اني هم اريد اكبل قابل ربي وحد😹🙌️")
elseif Text== "ضوجه"  then return sendMsg(msg.chat_id_,msg.id_,"شي اكيد الكبل ماكو 😂 لو بعدك/ج مازاحف/ة 🙊😋")
elseif Text== "اروح اصلي" then return sendMsg(msg.chat_id_,msg.id_,"انته حافظ سوره الفاتحة😍❤️️")
elseif Text== "صاك"  then return sendMsg(msg.chat_id_,msg.id_,"زاحفه 😂 منو هذا دزيلي صورهه")
elseif Text== "اجيت" or Text=="اني اجيت" then return  sendMsg(msg.chat_id_,msg.id_,"كْـٌﮩٌﮧٌ﴿😍﴾ـﮩٌول الـ୭ـهـٌ୭ـْلا❤️")
elseif Text== "طفي السبلت" then return sendMsg(msg.chat_id_,msg.id_,"تم اطفاء السبلت بنجاح 🌚🍃")
elseif Text== "شغل السبلت" then return sendMsg(msg.chat_id_,msg.id_,"تم تشغيل السبلت بنجاح بردتو مبردتو معليه  🌚🍃")
elseif Text== "حفلش"  then return sendMsg(msg.chat_id_,msg.id_,"افلش راسك 🤓")
elseif Text== "نايمين" then return sendMsg(msg.chat_id_,msg.id_,"ني سهران احرسكـم😐🍃'")
elseif Text== "اكو احد" then return sendMsg(msg.chat_id_,msg.id_,"يي عيني انـي موجـود🌝🌿")
elseif Text== "شكو" then return sendMsg(msg.chat_id_,msg.id_,"كلشي وكلاشي🐸تگـول عبالك احنـة بالشورجـة🌝")
elseif Text== "انتة منو" then return sendMsg(msg.chat_id_,msg.id_,"آني كـامل مفيد اكبر زنگين أگعدة عالحديـد🙌")
elseif Text== "كلخرا" then return sendMsg(msg.chat_id_,msg.id_,"خرا ليترس حلكك/ج ياخرا يابنلخرا خختفووو ابلع😸🙊💋")
elseif Text== "حبيبتي" then return sendMsg(msg.chat_id_,msg.id_,"منو هاي 😱 تخوني 😔☹")
elseif Text== "حروح اسبح" then return sendMsg(msg.chat_id_,msg.id_,"واخيراً 😂")
elseif Text== "😔"  then return sendMsg(msg.chat_id_,msg.id_,"ليش الحلو ضايج ❤️🍃")
elseif Text== "☹️"  then return sendMsg(msg.chat_id_,msg.id_,"لضوج حبيبي 😢❤️🍃")
elseif Text== "جوعان"  then return sendMsg(msg.chat_id_,msg.id_,"تعال اكلني 😐😂")
elseif Text== "تعال خاص" or Text== "خاصك" or Text=="شوف الخاص" or Text=="شوف خاص" then return "ها شسون 😉"
elseif Text== "لتحجي"  then return sendMsg(msg.chat_id_,msg.id_,"وانت شعليك حاجي من حلگگ😒")
elseif Text== "معليك" or Text== "شعليك" then return sendMsg(msg.chat_id_,msg.id_,"عليه ونص 😡")
elseif Text== "شدسون" or Text== "شداتسوون" or Text== "شدتسون" then return  sendMsg(msg.chat_id_,msg.id_,"نطبخ 😐")
elseif Text:match(Bot_Name.." شلونك$") then 
return sendMsg(msg.chat_id_,msg.id_,"احســن مــن انتهــــہ شــلونـــك شــخــبـارك يـــول مۂــــشتـــاقـــلك شــو ماكـــو 😹🌚")
elseif Text== "يومه فدوه"  then return sendMsg(msg.chat_id_,msg.id_,"فدؤه الج حياتي 😍😙")
elseif Text== "افلش"  then return sendMsg(msg.chat_id_,msg.id_,"باند عام من 30 بوت 😉")
elseif Text== "احبج"  then return sendMsg(msg.chat_id_,msg.id_,"يخي احترم شعوري 😢")
elseif Text== "شكو ماكو"  then return sendMsg(msg.chat_id_,msg.id_,"غيرك/ج بل كلب ماكو يبعد كلبي😍❤️️")
elseif Text== "اغير جو"  then return sendMsg(msg.chat_id_,msg.id_,"😂 تغير جو لو تسحف 🐍 عل بنات")
elseif Text== "😋"  then return sendMsg(msg.chat_id_,msg.id_,"طبب لسانك جوه عيب 😌")
elseif Text== "😡"  then  return sendMsg(msg.chat_id_,msg.id_,"ابرد  🚒"  )
elseif Text== "مرحبا"  then return sendMsg(msg.chat_id_,msg.id_,"مراحب 😍❤️ نورت-ي 🌹")
elseif Text== "سلام" or Text== "السلام عليكم" or Text== "سلام عليكم" or Text=="سلامن عليكم" or Text=="السلامن عليكم" then 
return sendMsg(msg.chat_id_,msg.id_,"وعليكم السلام اغاتي🌝👋" )
elseif Text== "واكف"  then return sendMsg(msg.chat_id_,msg.id_,"يخي مابيه شي ليش تتفاول😢" )
elseif Text== "🚶🏻"  then return sendMsg(msg.chat_id_,msg.id_,"لُـﮩـضڵ تتـمشـﮥ اڪعـد ﺳـﯠڵـف 🤖👋🏻")
elseif Text== "البوت واكف" then return sendMsg(msg.chat_id_,msg.id_,"هياتني 😐")
elseif Text== "ضايج"  then return sendMsg(msg.chat_id_,msg.id_,"ليش ضايج حياتي")
elseif Text== "ضايجه"  then return sendMsg(msg.chat_id_,msg.id_,"منو مضوجج كبدايتي")
elseif Text== "😳" or Text== "😳😳" or Text== "😳😳😳" then return sendMsg(msg.chat_id_,msg.id_,"ها بس لا شفت خالتك الشكره 😳😹🕷")
elseif Text== "صدك"  then return sendMsg(msg.chat_id_,msg.id_,"قابل اجذب عليك!؟ 🌚")
elseif Text== "شغال"  then return sendMsg(msg.chat_id_,msg.id_,"نعم عزيزي باقي واتمدد 😎🌿")
elseif Text== "تخليني"  then return sendMsg(msg.chat_id_,msg.id_,"اخليك بزاويه 380 درجه وانته تعرف الباقي 🐸")
elseif Text== "فديتك" or Text== "فديتنك"  then return  sendMsg(msg.chat_id_,msg.id_,"فداكـ/چ ثولان العالـم😍😂" )
elseif Text== "بوت"  then return sendMsg(msg.chat_id_,msg.id_,"أسمي ["..Bot_Name.."] 🌚🌸")
elseif Text== "مساعدة"  then return sendMsg(msg.chat_id_,msg.id_,"لعرض قائمة المساعدة اكتب الاوامر 🌚❤️")
elseif Text== "زاحف"  then return sendMsg(msg.chat_id_,msg.id_,"زاحف عله خالتك الشكره 🌝")
elseif Text== "حلو"  then return sendMsg(msg.chat_id_,msg.id_,"انت الاحلى 🌚❤️")
elseif Text== "تبادل"  then return sendMsg(msg.chat_id_,msg.id_,"كافي ملينه تبادل 😕💔")
elseif Text== "عاش"  then return sendMsg(msg.chat_id_,msg.id_,"الحلو 🌝🌷")
elseif Text== "مات"  then return sendMsg(msg.chat_id_,msg.id_,"أبو الحمامات 🕊🕊")
elseif Text== "ورده" or Text== "وردة" then return sendMsg(msg.chat_id_,msg.id_,"أنت/ي  عطرها 🌹🌸")
elseif Text== "شسمك"  then return sendMsg(msg.chat_id_,msg.id_,"مكتوب فوك 🌚🌿")
elseif Text== "فديت" or Text=="فطيت" then return sendMsg(msg.chat_id_,msg.id_,"فداك/ج 💞🌸")
elseif Text== "واو"  then return sendMsg(msg.chat_id_,msg.id_,"قميل 🌝🌿")
elseif Text== "زاحفه" or Text== "زاحفة" then return  sendMsg(msg.chat_id_,msg.id_,"لو زاحفتلك جان ماكلت زاحفه 🌝🌸")
elseif Text== "حبيبي" or Text=="حبي" then return  sendMsg(msg.chat_id_,msg.id_,"بعد روحي 😍❤️ تفضل")
elseif Text== "حبيبتي" then return sendMsg(msg.chat_id_,msg.id_,"تحبك وتحب عليك 🌝🌷")
elseif Text== "حياتي" then return sendMsg(msg.chat_id_,msg.id_,"ها حياتي 😍🌿")
elseif Text== "عمري" then return sendMsg(msg.chat_id_,msg.id_,"خلصته دياحه وزحف 🌝🌿 ")
elseif Text== "اسكت" then return sendMsg(msg.chat_id_,msg.id_,"وك معلم 🌚💞")
elseif Text== "بتحبني" then return sendMsg(msg.chat_id_,msg.id_,"بحبك اد الكون 😍🌷")
elseif Text== "المعزوفه" or Text=="المعزوفة" or Text=="معزوفه" then 
return sendMsg(msg.chat_id_,msg.id_,"طرطاا طرطاا طرطاا 😂👌")
elseif Text== "موجود" then return sendMsg(msg.chat_id_,msg.id_,"تفضل عزيزي 🌝🌸")
elseif Text== "اكلك" then return sendMsg(msg.chat_id_,msg.id_,".كول حياتي 😚🌿")
elseif Text== "فدوه" or Text=="فدوة" or Text=="فطوه" or Text=="فطوة" then  
return sendMsg(msg.chat_id_,msg.id_,"لكلبك/ج 😍❤️")
elseif Text== "دي"  then return sendMsg(msg.chat_id_,msg.id_,"خليني احہۣۗبہۜۧ😻ہہۖۗڱֆ ̮⇣  🌝💔")
elseif Text== "اشكرك" then return sendMsg(msg.chat_id_,msg.id_,"بخدمتك/ج حبي ❤")
elseif Text== "😉"  then return sendMsg(msg.chat_id_,msg.id_,"😻🙈")
elseif Text== "اقرالي دعاء" then 
return sendMsg(msg.chat_id_,msg.id_,"اللهم عذب المدرسين 😢 منهم الاحياء والاموات 😭🔥 اللهم عذب ام الانكليزي 😭💔 وكهربها بلتيار الرئيسي 😇 اللهم عذب ام الرياضيات وحولها الى غساله بطانيات 🙊 اللهم عذب ام الاسلاميه واجعلها بائعة الشاميه 😭🍃 اللهم عذب ام العربي وحولها الى بائعه البلبي اللهم عذب ام الجغرافيه واجعلها كلدجاجه الحافية اللهم عذب ام التاريخ وزحلقها بقشره من البطيخ وارسلها الى المريخ اللهم عذب ام الاحياء واجعلها كل مومياء اللهم عذب المعاون اقتله بلمدرسه بهاون 😂😂😂")
elseif Text== "ايديي" or Text=="ايدي 🆔" then 
GetUserID(msg.sender_user_id_,function(arg,data)
if data.username_ then USERNAME = '@'..data.username_ else USERNAME = FlterName(data) end
USERNAME = USERNAME:gsub([[\_]],"_")
USERCAR = utf8.len(USERNAME) 
SendMention(msg.chat_id_,data.id_,msg.id_,"🧟‍♂¦ آضـغط على آلآيدي ليتم آلنسـخ\n\n "..USERNAME.." ~⪼ ( "..data.id_.." )",37,USERCAR)  
return false
end)
elseif Text=="اريد رابط الحذف" or Text=="اريد رابط حذف" or Text=="رابط حذف" or Text=="رابط الحذف" then
return sendMsg(msg.chat_id_,msg.id_,[[
🌿*¦* رابط حذف حـساب التيليگرام ↯
📛¦ لتتندم فڪر قبل ڪلشي  
👨🏽‍⚖️¦ بالتـوفيـق عزيزي ...
🚸 ¦ـ  https://telegram.org/deactivate
]] )
--=====================================
elseif Text== "انجب" or Text== "نجب" or Text=="جب" then
if msg.SudoUser then  
return sendMsg(msg.chat_id_,msg.id_,"حاضر مو تدلل حضره المطور  😇 ")
elseif msg.Creator then 
return sendMsg(msg.chat_id_,msg.id_,"ع راسي تدلل انته المنشئ تاج راسي 😌")
elseif msg.Director then 
return sendMsg(msg.chat_id_,msg.id_,"لخاطرك راح اسكت لان مدير وع راسي  😌")
elseif msg.Admin then 
return sendMsg(msg.chat_id_,msg.id_,"فوك مامصعدك ادمن ؟؟ انته انجب 😏")
else 
return sendMsg(msg.chat_id_,msg.id_,"انجب انته لاتندفر 😏")
end 
end 


end


------------------------------{ End Replay Send }------------------------

------------------------------{ Start Checking CheckExpire }------------------------

if redis:get(boss..'CheckExpire::'..msg.chat_id_) then
local ExpireDate = redis:ttl(boss..'ExpireDate:'..msg.chat_id_)
SUDO_USER = redis:hgetall(boss..'username:'..SUDO_ID).username
if SUDO_USER:match('@[%a%d_]+') then 
SUDO_USERR = "\n👨🏾‍🔧¦ راسل المطور للتجديد ["..SUDO_USER.."]"
else
SUDO_USERR = ""
end
if not ExpireDate and not msg.SudoUser then
rem_data_group(msg.chat_id_)
sendMsg(SUDO_ID,0,'🕵🏼️‍♀️¦ انتهى الاشتراك في احد المجموعات ✋🏿\n👨🏾‍🔧¦ المجموعه : '..FlterName(redis:get(boss..'group:name'..msg.chat_id_))..'🍃\n💂🏻‍♀️¦ ايدي : '..msg.chat_id_)
sendMsg(msg.chat_id_,0,'🕵🏼️‍♀️¦ انتهى الاشتراك البوت✋🏿\n💂🏻‍♀️¦ سوف اغادر المجموعه فرصه سعيده 👋🏿'..SUDO_USERR..' 🍃')
return StatusLeft(msg.chat_id_,our_id)
else
local DaysEx = (redis:ttl(boss..'ExpireDate:'..msg.chat_id_) / 86400)
if tonumber(DaysEx) > 0.208 and ExpireDate ~= -1 and msg.Admin then
if tonumber(DaysEx + 1) == 1 and not msg.SudoUser then
sendMsg(msg.chat_id_,'🕵🏼️‍♀️¦ باقي يوم واحد وينتهي الاشتراك ✋🏿\n '..SUDO_USERR..'\n📛')
end 
end 
end
end

------------------------------{ End Checking CheckExpire }------------------------


end 

return {
Boss = {
"^(اضف رد عشوائي)$",
"^(مسح رد عشوائي)$",
"^(مسح الردود العشوائيه)$",
"^(الردود العشوائيه)$",
"^(اضف رد عشوائي عام)$",
"^(مسح رد عشوائي عام)$",
"^(مسح الردود العشوائيه العامه)$",
"^(الردود العشوائيه العام)$",
"^(مسح المطورين)$",
"^(مسح قائمه العام)$",
"^(مسح الادمنيه)$",
"^(مسح المنشئين الاساسين)$",
"^(مسح المنشئيين الاساسيين)$",
"^(مسح المنشئين الاساسيين)$",
"^(مسح المنشئيين الاساسين)$",
"^(مسح الرسائل المجدوله)$",
"^(مسح الميديا)$",
"^(مسح الوسائط)$",
"^(مسح التعديلات)$",
"^(مسح سحكاتي)$",
"^(مسح تعديلاتي)$",
"^(مسح قائمه المنع)$",
"^(مسح القوانين)$",
"^(مسح الترحيب)$",
"^(مسح المنشئيين)$",
"^(مسح المنشئين)$",
"^(مسح المدراء)$",
"^(مسح المحظورين)$",
"^(مسح المكتومين)$",
"^(مسح المميزين)$",
"^(مسح الرابط)$",

"^(مسح قائمه الرتب)$",
"^(مسح الرتبه)$",
"^(تغير الرتبه)$",
"^(قائمه الرتب)$",
"^(المالك)$",
"^(المنشئ)$",
"^(المنشى)$",
"^(رفع القيود)$",
"^(رفع القيود) (%d+)$",
"^(رفع القيود) (@[%a%d_]+)$",
"^(تقييد) (%d+)$",
"^(تقييد) (@[%a%d_]+)$",
"^(فك التقييد) (%d+)$",
"^(فك التقييد) (@[%a%d_]+)$",
"^(فك تقييد) (%d+)$",
"^(فك تقييد) (@[%a%d_]+)$",
"^(ضع شرط التفعيل) (%d+)$",
"^(التفاعل) (@[%a%d_]+)$",
"^(التفاعل) (%d+)$",
"^(ايدي) (@[%a%d_]+)$",
"^(كشف) (%d+)$",
"^(كشف) (@[%a%d_]+)$",
'^(رفع مميز) (@[%a%d_]+)$',
'^(رفع مميز) (%d+)$',
'^(تنزيل الكل) (@[%a%d_]+)$',
'^(تنزيل الكل) (%d+)$',
'^(تنزيل مميز) (@[%a%d_]+)$',
'^(تنزيل مميز) (%d+)$',
'^(رفع ادمن) (@[%a%d_]+)$',
'^(رفع ادمن) (%d+)$',
'^(تنزيل ادمن) (@[%a%d_]+)$',
'^(تنزيل ادمن) (%d+)$', 
'^(رفع مدير) (@[%a%d_]+)$',
'^(رفع المدير) (@[%a%d_]+)$',
'^(رفع المدير) (%d+)$',
'^(رفع مدير) (%d+)$',
'^(رفع منشئ) (@[%a%d_]+)$',
'^(رفع منشى) (%d+)$',
'^(رفع منشئ) (%d+)$',
'^(رفع منشى) (@[%a%d_]+)$',
'^(رفع مشرف) (@[%a%d_]+)$',
'^(تنزيل مشرف)$',
'^(تنزيل مشرف) (%d+)$',
'^(رفع مشرف)$',
'^(رفع مشرف) (%d+)$',
'^(تنزيل منشئ) (%d+)$',
'^(تنزيل منشى) (%d+)$',
'^(تنزيل مشرف) (@[%a%d_]+)$',
'^(تنزيل منشى) (@[%a%d_]+)$',
'^(تنزيل منشئ) (@[%a%d_]+)$',
'^(تنزيل مدير) (@[%a%d_]+)$',
'^(تنزيل المدير) (@[%a%d_]+)$',
'^(تنزيل المدير) (%d+)$',
'^(تنزيل مدير) (%d+)$',
'^(ضع تكرار) (%d+)$',
'^(ضع وقت التنظيف) (%d+)$',
"^(مسح)$",
"^(مسح) (.+)$",
'^(منع) (.+)$',
'^(الغاء منع) (.+)$',
"^(حظر عام) (@[%a%d_]+)$",
"^(حظر عام) (%d+)$",
"^(الغاء العام) (@[%a%d_]+)$",
"^(الغاء العام) (%d+)$",
"^(الغاء عام) (@[%a%d_]+)$",
"^(الغاء عام) (%d+)$",
"^(حظر) (@[%a%d_]+)$",
"^(حظر) (%d+)$",
"^(الغاء الحظر) (@[%a%d_]+)$",
"^(الغاء الحظر) (%d+)$",
"^(الغاء حظر) (@[%a%d_]+)$",
"^(الغاء حظر) (%d+)$",
"^(طرد) (@[%a%d_]+)$",
"^(طرد) (%d+)$",
"^(كتم) (@[%a%d_]+)$",
"^(كتم) (%d+)$",
"^(الغاء الكتم) (@[%a%d_]+)$",
"^(الغاء الكتم) (%d+)$",
"^(الغاء كتم) (@[%a%d_]+)$",
"^(الغاء كتم) (%d+)$",
"^(رفع مطور) (@[%a%d_]+)$",
"^(رفع مطور) (%d+)$",
"^(تنزيل مطور) (%d+)$",
"^(تنزيل مطور) (@[%a%d_]+)$",
"^(رفع منشئ اساسي) (@[%a%d_]+)$",
"^(رفع منشئ اساسي) (%d+)$",
"^(تنزيل منشئ اساسي) (@[%a%d_]+)$",
"^(تنزيل منشئ اساسي) (%d+)$",

"^(رفع منشى اساسي) (@[%a%d_]+)$",
"^(رفع منشى اساسي) (%d+)$",
"^(تنزيل منشى اساسي) (@[%a%d_]+)$",
"^(تنزيل منشى اساسي) (%d+)$",


"^(الاشتراك) ([123])$",
"^(شحن) (%d+)$",
"^(تعيين امر) (.*)$",
"^(تعين امر) (.*)$",
"^(اضف امر) (.*)$",
"^(اضف امر)$",
"^(مسح امر) (.*)$",
"^(مسح امر)$",

"^([Ss][pP]) ([%a%d_]+.lua)$", 
"^([dD][pP]) ([%a%d_]+.lua)$", 


"^(تاك للكل)$",
"^(تاك للكل) (ل %d+)$",
"^(الأدارين)$",
"^(الأداريين)$",
"^(الاداريين)$",
"^(الادارين)$",

"^(تنزيل الكل)$",
"^(تقييد)$",
"^(فك التقييد)$",
"^(فك تقييد)$",
"^(التفاعل)$",
"^([iI][dD])$",
"^(ايدي)$",
"^(كشف)$",
'^(رفع مميز)$',
'^(تنزيل مميز)$',
'^(رفع ادمن)$',
'^(تنزيل ادمن)$', 
'^(رفع المدير)$',
'^(رفع مدير)$',
'^(رفع منشى)$',
'^(رفع منشئ)$',
'^(تنزيل منشئ)$',
'^(تنزيل منشى)$',
'^(تنزيل المدير)$',
'^(تنزيل مدير)$',
'^(تفعيل)$',
'^(تعطيل)$',
'^(تعطيل) [-]100(%d+)$',

"^(مسح كلايش التعليمات)$",



"^(تعديلاتي)$",
"^(سحكاتي)$",
"^(تعين الايدي)$",
"^(تعيين ايدي)$",
"^(تعيين كليشه الستارت)$",
"^(تعيين كليشه الستارت 📱)$",
"^(مسح كليشة الستارت)$",
"^(مسح كليشه الستارت)$",
"^(مسح كليشه الستارت 🗑)$",
"^(تعيين كليشه الايدي عام)$",
"^(تعيين كليشه الايدي عام 📄)$",
"^(تعيين الايدي عام)$",
"^(تعين الايدي عام)$",
"^(تعيين ايدي عام)$",

"^(تعيين كليشه الايدي)$",
"^(تعيين كليشة الايدي)$",
"^(تعيين الايدي)$",
"^(حظر عام)$",
"^(الغاء العام)$",
"^(الغاء عام)$",
"^(حظر)$",
"^(الغاء الحظر)$",
"^(الغاء حظر)$",
"^(طرد)$",
"^(كتم)$",
"^(الغاء الكتم)$",
"^(الغاء كتم)$",
"^(رفع مطور)$",
"^(تنزيل مطور)$",
"^(رفع منشئ اساسي)$",
"^(تنزيل منشئ اساسي)$",
"^(رفع منشى اساسي)$",
"^(تنزيل منشى اساسي)$",
"^(تعيين قائمه الاوامر)$",
"^(الاشتراك)$",
"^(المجموعه)$",
"^(كشف البوت)$",
"^(انشاء رابط)$",
"^(ضع الرابط)$",
"^(تثبيت)$",
"^(الغاء التثبيت)$",
"^(الغاء تثبيت)$",
"^(رابط)$",
"^(الرابط)$",
"^(القوانين)$",
"^(ضع القوانين)$",
"^(ضع قوانين)$",
"^(ضع تكرار)$",
"^(ضع التكرار)$",
"^(المنشئين)$",
"^(المنشئيين)$",
"^(الادمنيه)$",
"^(قائمه المنع)$",
"^(المدراء)$",
"^(المميزين)$",
"^(المكتومين)$",
"^(ضع الترحيب)$",
"^(الترحيب)$",
"^(المحظورين)$",
"^(ضع اسم)$",
"^(ضع صوره)$",
"^(ضع وصف)$",
"^(طرد البوتات)$",
"^(كشف البوتات)$",
"^(طرد المحذوفين)$",
"^(رسائلي)$",
"^(رسايلي)$",
"^(احصائياتي)$",
"^(معلوماتي)$",
"^(موقعي)$",
"^(رفع الادمنيه)$",
"^(صوره الترحيب)$",
"^(ضع كليشه المطور)$",
"^(مسح كليشه المطور)$",
"^(المطور)$",
"^(شرط التفعيل)$",
"^(قائمه المجموعات)$",
"^(المجموعات)$",
"^(اذاعه)$",
"^(اذاعه عام)$",
"^(اذاعه خاص)$",
"^(اذاعه عام بالتوجيه)$",
"^(اذاعه عام بالتوجيه 📣)$", 
"^(اذاعه خاص 👤)$", 
"^(اذاعه عام 📢)$", 
"^(اذاعه 🗣)$", 
"^(قائمه العام)$",
"^(قائمه العام 📜)$",
"^(المطورين)$",
"^(المطورين 🕹)$",
"^(تيست)$",
"^(test)$",
"^(ايدي 🆔)$",
"^(قناة السورس 📡)$",
"^(الاحصائيات)$",
"^(الاحصائيات 📈)$",
"^(اضف رد عام)$",
"^(اضف رد عام ➕)$",
"^(مسح الردود)$",
"^(مسح الردود العامه)$",
"^(ضع اسم للبوت)$",
"^(حذف صوره)$",
"^(مسح رد)$",
"^(الردود)$",
"^(الردود العامه)$",
"^(الردود العامه 🗨)$",
"^(اضف رد)$",
"^(/UpdateSource)$",
"^(تحديث السورس ™)$",
"^(تحديث السورس)$",
"^(تنظيف المجموعات)$",
"^(تنظيف المشتركين)$",
"^(رتبتي)$",
"^(ضع اسم للبوت ©)$",
"^(ضع صوره للترحيب 🌄)$",
"^(ضع صوره للترحيب)$",
"^(الحمايه)$",
"^(الاعدادات)$",
"^(الوسائط)$",
"^(الغاء الامر ✖️)$",
"^(الرتبه)$",
"^(الغاء)$",
"^(الساعه)$",
"^(التاريخ)$",
"^(متجر الملفات)$",
"^(الملفات 🗂)$",
"^(الملفات)$",
"^(اصدار السورس)$",
"^(الاصدار)$",
"^(server)$",
"^(تعيين امر)$",
"^(تعين امر)$",
"^(السيرفر)$",
"^(اذاعه بالتثبيت)$",
"^(اذاعه بالتثبيت 📬)$",
"^(نسخه احتياطيه للمجموعات)$",
"^(رفع نسخه الاحتياطيه)$", 

"^(تعطيل الردود العشوائيه)$", 
"^(تفعيل الردود العشوائيه)$", 
"^(تفعيل ردود السورس)$", 
"^(تعطيل ردود السورس)$", 
"^(تفعيل التنظيف التلقائي)$", 
"^(تعطيل التنظيف التلقائي)$", 

"^(تفعيل الاشتراك الاجباري)$", 
"^(تعطيل الاشتراك الاجباري)$", 
"^(تغيير الاشتراك الاجباري)$", 
"^(الاشتراك الاجباري)$", 
"^(ادفرني)$", 
"^(مغادره)$", 
"^(قائمه الاوامر)$", 
"^(مسح الاوامر)$", 
"^(احظرني)$", 
"^(اطردني)$", 
"^(جهاتي)$", 
"^(ضع رابط)$", 
"^(نقل ملكيه البوت 📇)$", 
"^(نقل ملكيه البوت)$", 
"^(مسح كليشه الايدي)$", 
"^(مسح الايدي)$", 
"^(مسح ايدي)$", 
"^(مسح كليشة الايدي)$", 
"^(مسح كليشه الايدي عام)$", 
"^(مسح كليشه الايدي عام ??)$", 
"^(مسح الايدي عام)$", 
"^(مسح ايدي عام)$", 
"^(مسح كليشة الايدي عام)$", 
"^(السورس)$",
"^(سورس)$",
"^(م المطور)$", 
"^(اوامر الرد)$",
"^(اوامر الملفات)$",
"^(الاوامر)$",
"^(م1)$",
"^(م2)$",
"^(م3)$", 
"^(/store)$", 
"^(/files)$", 
"^(قفل الصور بالتقييد)$",
"^(قفل الفيديو بالتقييد)$",
"^(قفل المتحركه بالتقييد)$",
"^(قفل التوجيه بالتقييد)$",
"^(قفل الروابط بالتقييد)$",
"^(قفل الدردشه)$",
"^(قفل المتحركه)$",
"^(قفل الصور)$",
"^(قفل الفيديو)$",
"^(قفل البصمات)$",
"^(قفل الصوت)$",
"^(قفل الملصقات)$",
"^(قفل الجهات)$",
"^(قفل التوجيه)$",
"^(قفل الموقع)$",
"^(قفل الملفات)$",
"^(قفل الاشعارات)$",
"^(قفل الانلاين)$",
"^(قفل الالعاب)$",
"^(قفل الكيبورد)$",
"^(قفل الروابط)$",
"^(قفل التاك)$",
"^(قفل المعرفات)$",
"^(قفل التعديل)$",
"^(قفل الكلايش)$",
"^(قفل التكرار)$",
"^(قفل البوتات)$",
"^(قفل البوتات بالطرد)$",
"^(قفل الماركدوان)$",
"^(قفل الويب)$",
"^(قفل التثبيت)$",
"^(قفل الاضافه)$",
"^(قفل الانكليزيه)$",
"^(قفل الفارسيه)$",
"^(قفل الفشار)$",
"^(فتح الصور بالتقييد)$",
"^(فتح الفيديو بالتقييد)$",
"^(فتح المتحركه بالتقييد)$",
"^(فتح التوجيه بالتقييد)$",
"^(فتح الروابط بالتقييد)$",
"^(فتح الدردشه)$",
"^(فتح المتحركه)$",
"^(فتح الصور)$",
"^(فتح الفيديو)$",
"^(فتح البصمات)$",
"^(فتح الصوت)$",
"^(فتح الملصقات)$",
"^(فتح الجهات)$",
"^(فتح التوجيه)$",
"^(فتح الموقع)$",
"^(فتح الملفات)$",
"^(فتح الاشعارات)$",
"^(فتح الانلاين)$",
"^(فتح الالعاب)$",
"^(فتح الكيبورد)$",
"^(فتح الروابط)$",
"^(فتح التاك)$",
"^(فتح المعرفات)$",
"^(فتح التعديل)$",
"^(فتح الكلايش)$",
"^(فتح التكرار)$",
"^(فتح البوتات)$",
"^(فتح البوتات بالطرد)$",
"^(فتح الماركدوان)$",
"^(فتح الويب)$",
"^(فتح التثبيت)$",
"^(فتح الاضافه)$",
"^(فتح الانكليزيه)$",
"^(فتح الفارسيه)$",
"^(فتح الفشار)$",
"^(تعطيل الردود)$",
"^(تعطيل الاذاعه)$",
"^(تعطيل الاذاعه 🔌)$",
"^(تعطيل الايدي)$",
"^(تعطيل الترحيب)$",
"^(تعطيل التحذير)$",
"^(تعطيل الايدي بالصوره)$",
"^(تعطيل الحمايه)$",
"^(تعطيل المغادره)$",
"^(تعطيل تعيين الايدي)$",
"^(تعطيل تعيين الايدي ⚔️)$",
"^(تعطيل الحظر)$",
"^(تعطيل الرابط)$",
"^(تعطيل تاك للكل)$",
"^(تعطيل التحقق)$",
"^(تفعيل الردود)$",
"^(تفعيل الاذاعه)$",
"^(تفعيل الاذاعه 📇)$",
"^(تفعيل الايدي)$",
"^(تفعيل الترحيب)$",
"^(تفعيل التحذير)$",
"^(تفعيل الايدي بالصوره)$",
"^(تفعيل الحمايه)$",
"^(تفعيل المغادره)$",
"^(تفعيل تعيين الايدي)$",
"^(تفعيل تعيين الايدي ⌨️)$",
"^(تفعيل الحظر)$",
"^(تفعيل الرابط)$",
"^(تفعيل تاك للكل)$",
"^(تفعيل التحقق)$",
"^(تفعيل البوت خدمي)$",
"^(تفعيل البوت خدمي 🔃)$",
"^(تعطيل البوت خدمي)$",
"^(تعطيل البوت خدمي 🚫)$",
"^(تفعيل التواصل 🔛)$",
"^(تفعيل التواصل)$",
"^(تعطيل التواصل ✖️)$",
"^(قفل الكل)$",
"^(فتح الكل)$",
"^(قفل الوسائط)$",
"^(فتح الوسائط)$",
"^(منع)$",
},
iBoss = iBoss,
dBoss = dBoss,
} 
