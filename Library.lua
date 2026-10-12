-- [[ GENERATED WITH InfernoHub/Scriptify STUDIO PLUGIN ]] --
-- Scriptify Version: 1.4

--

-- Create objects
local parent = game:GetService("StarterGui");
local objects = {
    ["Instance0"] = Instance.new("ScreenGui");
    ["Instance1"] = Instance.new("ModuleScript");
    ["Instance2"] = Instance.new("ModuleScript");
    ["Instance3"] = Instance.new("ModuleScript");
    ["Instance4"] = Instance.new("ModuleScript");
    ["Instance5"] = Instance.new("ModuleScript");
    ["Instance6"] = Instance.new("ModuleScript");
    ["Instance7"] = Instance.new("ModuleScript");
    ["Instance8"] = Instance.new("ModuleScript");
    ["Instance9"] = Instance.new("ModuleScript");
    ["Instance10"] = Instance.new("ModuleScript");
    ["Instance11"] = Instance.new("Configuration");
    ["Instance12"] = Instance.new("Folder");
    ["Instance13"] = Instance.new("Sound");
    ["Instance14"] = Instance.new("Sound");
    ["Instance15"] = Instance.new("Sound");
    ["Instance16"] = Instance.new("Sound");
    ["Instance17"] = Instance.new("Folder");
    ["Instance18"] = Instance.new("ModuleScript");
    ["Instance19"] = Instance.new("ModuleScript");
    ["Instance20"] = Instance.new("ModuleScript");
    ["Instance21"] = Instance.new("ModuleScript");
    ["Instance22"] = Instance.new("ModuleScript");
    ["Instance23"] = Instance.new("ModuleScript");
    ["Instance24"] = Instance.new("ModuleScript");
    ["Instance25"] = Instance.new("Frame");
    ["Instance26"] = Instance.new("UIAspectRatioConstraint");
    ["Instance27"] = Instance.new("TextButton");
    ["Instance28"] = Instance.new("ImageLabel");
    ["Instance29"] = Instance.new("SoundGroup");
    ["Instance30"] = Instance.new("Frame");
    ["Instance31"] = Instance.new("Frame");
    ["Instance32"] = Instance.new("Frame");
    ["Instance33"] = Instance.new("TextButton");
    ["Instance34"] = Instance.new("UICorner");
    ["Instance35"] = Instance.new("Frame");
    ["Instance36"] = Instance.new("CanvasGroup");
    ["Instance37"] = Instance.new("UIStroke");
    ["Instance38"] = Instance.new("UICorner");
    ["Instance39"] = Instance.new("Frame");
    ["Instance40"] = Instance.new("Frame");
    ["Instance41"] = Instance.new("UIListLayout");
    ["Instance42"] = Instance.new("CanvasGroup");
    ["Instance43"] = Instance.new("TextButton");
    ["Instance44"] = Instance.new("UIStroke");
    ["Instance45"] = Instance.new("UICorner");
    ["Instance46"] = Instance.new("TextLabel");
    ["Instance47"] = Instance.new("ImageLabel");
    ["Instance48"] = Instance.new("CanvasGroup");
    ["Instance49"] = Instance.new("TextButton");
    ["Instance50"] = Instance.new("UIStroke");
    ["Instance51"] = Instance.new("UICorner");
    ["Instance52"] = Instance.new("TextLabel");
    ["Instance53"] = Instance.new("ImageLabel");
    ["Instance54"] = Instance.new("TextButton");
    ["Instance55"] = Instance.new("Frame");
    ["Instance56"] = Instance.new("TextLabel");
    ["Instance57"] = Instance.new("ImageLabel");
    ["Instance58"] = Instance.new("UIAspectRatioConstraint");
    ["Instance59"] = Instance.new("UIStroke");
    ["Instance60"] = Instance.new("UICorner");
    ["Instance61"] = Instance.new("UIListLayout");
    ["Instance62"] = Instance.new("Frame");
    ["Instance63"] = Instance.new("TextLabel");
    ["Instance64"] = Instance.new("TextLabel");
    ["Instance65"] = Instance.new("Frame");
    ["Instance66"] = Instance.new("Frame");
    ["Instance67"] = Instance.new("Frame");
    ["Instance68"] = Instance.new("UIListLayout");
    ["Instance69"] = Instance.new("ImageLabel");
    ["Instance70"] = Instance.new("UIAspectRatioConstraint");
    ["Instance71"] = Instance.new("UICorner");
    ["Instance72"] = Instance.new("TextLabel");
    ["Instance73"] = Instance.new("Frame");
    ["Instance74"] = Instance.new("UIListLayout");
    ["Instance75"] = Instance.new("TextButton");
    ["Instance76"] = Instance.new("UIAspectRatioConstraint");
    ["Instance77"] = Instance.new("ImageLabel");
    ["Instance78"] = Instance.new("TextButton");
    ["Instance79"] = Instance.new("UIAspectRatioConstraint");
    ["Instance80"] = Instance.new("ImageLabel");
    ["Instance81"] = Instance.new("TextButton");
    ["Instance82"] = Instance.new("UIAspectRatioConstraint");
    ["Instance83"] = Instance.new("ImageLabel");
    ["Instance84"] = Instance.new("TextButton");
    ["Instance85"] = Instance.new("UIAspectRatioConstraint");
    ["Instance86"] = Instance.new("ImageLabel");
    ["Instance87"] = Instance.new("Frame");
    ["Instance88"] = Instance.new("Frame");
    ["Instance89"] = Instance.new("TextLabel");
    ["Instance90"] = Instance.new("UIPadding");
    ["Instance91"] = Instance.new("TextButton");
    ["Instance92"] = Instance.new("CanvasGroup");
    ["Instance93"] = Instance.new("ImageLabel");
    ["Instance94"] = Instance.new("UICorner");
    ["Instance95"] = Instance.new("Frame");
    ["Instance96"] = Instance.new("CanvasGroup");
    ["Instance97"] = Instance.new("ImageLabel");
    ["Instance98"] = Instance.new("Frame");
    ["Instance99"] = Instance.new("TextButton");
    ["Instance100"] = Instance.new("Frame");
    ["Instance101"] = Instance.new("UIStroke");
    ["Instance102"] = Instance.new("ImageLabel");
    ["Instance103"] = Instance.new("UIAspectRatioConstraint");
    ["Instance104"] = Instance.new("Frame");
    ["Instance105"] = Instance.new("TextBox");
    ["Instance106"] = Instance.new("UICorner");
    ["Instance107"] = Instance.new("UIPadding");
    ["Instance108"] = Instance.new("TextLabel");
    ["Instance109"] = Instance.new("UICorner");
    ["Instance110"] = Instance.new("TextButton");
    ["Instance111"] = Instance.new("UIPadding");
    ["Instance112"] = Instance.new("UIStroke");
    ["Instance113"] = Instance.new("UICorner");
    ["Instance114"] = Instance.new("Frame");
    ["Instance115"] = Instance.new("UICorner");
    ["Instance116"] = Instance.new("UICorner");
    ["Instance117"] = Instance.new("TextButton");
    ["Instance118"] = Instance.new("Frame");
    ["Instance119"] = Instance.new("Frame");
    ["Instance120"] = Instance.new("ImageLabel");
    ["Instance121"] = Instance.new("UICorner");
    ["Instance122"] = Instance.new("UICorner");
    ["Instance123"] = Instance.new("Frame");
    ["Instance124"] = Instance.new("UICorner");
    ["Instance125"] = Instance.new("ImageLabel");
    ["Instance126"] = Instance.new("UICorner");
    ["Instance127"] = Instance.new("Frame");
    ["Instance128"] = Instance.new("Frame");
    ["Instance129"] = Instance.new("Frame");
    ["Instance130"] = Instance.new("ScrollingFrame");
    ["Instance131"] = Instance.new("UIListLayout");
    ["Instance132"] = Instance.new("Frame");
    ["Instance133"] = Instance.new("TextButton");
    ["Instance134"] = Instance.new("Frame");
    ["Instance135"] = Instance.new("UIListLayout");
    ["Instance136"] = Instance.new("Frame");
    ["Instance137"] = Instance.new("TextLabel");
    ["Instance138"] = Instance.new("Frame");
    ["Instance139"] = Instance.new("Frame");
    ["Instance140"] = Instance.new("TextButton");
    ["Instance141"] = Instance.new("Frame");
    ["Instance142"] = Instance.new("Frame");
    ["Instance143"] = Instance.new("TextButton");
    ["Instance144"] = Instance.new("Frame");
    ["Instance145"] = Instance.new("UIListLayout");
    ["Instance146"] = Instance.new("ImageLabel");
    ["Instance147"] = Instance.new("UIAspectRatioConstraint");
    ["Instance148"] = Instance.new("UICorner");
    ["Instance149"] = Instance.new("TextLabel");
    ["Instance150"] = Instance.new("Frame");
    ["Instance151"] = Instance.new("UICorner");
    ["Instance152"] = Instance.new("ImageLabel");
    ["Instance153"] = Instance.new("Frame");
    ["Instance154"] = Instance.new("Frame");
    ["Instance155"] = Instance.new("Frame");
    ["Instance156"] = Instance.new("Frame");
    ["Instance157"] = Instance.new("ImageLabel");
    ["Instance158"] = Instance.new("UICorner");
    ["Instance159"] = Instance.new("UIAspectRatioConstraint");
    ["Instance160"] = Instance.new("Frame");
    ["Instance161"] = Instance.new("TextLabel");
    ["Instance162"] = Instance.new("TextButton");
    ["Instance163"] = Instance.new("Frame");
    ["Instance164"] = Instance.new("ScrollingFrame");
    ["Instance165"] = Instance.new("UIListLayout");
    ["Instance166"] = Instance.new("Frame");
    ["Instance167"] = Instance.new("TextButton");
    ["Instance168"] = Instance.new("Frame");
    ["Instance169"] = Instance.new("UIListLayout");
    ["Instance170"] = Instance.new("Frame");
    ["Instance171"] = Instance.new("CanvasGroup");
    ["Instance172"] = Instance.new("UIStroke");
    ["Instance173"] = Instance.new("Frame");
    ["Instance174"] = Instance.new("TextLabel");
    ["Instance175"] = Instance.new("UIPadding");
    ["Instance176"] = Instance.new("Frame");
    ["Instance177"] = Instance.new("UIListLayout");
    ["Instance178"] = Instance.new("UICorner");
    ["Instance179"] = Instance.new("UICorner");
    ["Instance180"] = Instance.new("Frame");
    ["Instance181"] = Instance.new("UIListLayout");
    ["Instance182"] = Instance.new("TextButton");
    ["Instance183"] = Instance.new("TextButton");
    ["Instance184"] = Instance.new("Frame");
    ["Instance185"] = Instance.new("ImageLabel");
    ["Instance186"] = Instance.new("UIAspectRatioConstraint");
    ["Instance187"] = Instance.new("UIListLayout");
    ["Instance188"] = Instance.new("TextLabel");
    ["Instance189"] = Instance.new("Frame");
    ["Instance190"] = Instance.new("TextButton");
    ["Instance191"] = Instance.new("Frame");
    ["Instance192"] = Instance.new("UIListLayout");
    ["Instance193"] = Instance.new("TextLabel");
    ["Instance194"] = Instance.new("ImageLabel");
    ["Instance195"] = Instance.new("UIAspectRatioConstraint");
    ["Instance196"] = Instance.new("UIStroke");
    ["Instance197"] = Instance.new("UIGradient");
    ["Instance198"] = Instance.new("Frame");
    ["Instance199"] = Instance.new("UIPadding");
    ["Instance200"] = Instance.new("Frame");
    ["Instance201"] = Instance.new("UIAspectRatioConstraint");
    ["Instance202"] = Instance.new("UICorner");
    ["Instance203"] = Instance.new("UICorner");
    ["Instance204"] = Instance.new("UIStroke");
    ["Instance205"] = Instance.new("UIAspectRatioConstraint");
    ["Instance206"] = Instance.new("UICorner");
    ["Instance207"] = Instance.new("Frame");
    ["Instance208"] = Instance.new("TextButton");
    ["Instance209"] = Instance.new("Frame");
    ["Instance210"] = Instance.new("TextLabel");
    ["Instance211"] = Instance.new("CanvasGroup");
    ["Instance212"] = Instance.new("TextLabel");
    ["Instance213"] = Instance.new("UIPadding");
    ["Instance214"] = Instance.new("UIStroke");
    ["Instance215"] = Instance.new("Frame");
    ["Instance216"] = Instance.new("Frame");
    ["Instance217"] = Instance.new("UIGradient");
    ["Instance218"] = Instance.new("Frame");
    ["Instance219"] = Instance.new("UIGradient");
    ["Instance220"] = Instance.new("TextBox");
    ["Instance221"] = Instance.new("UIPadding");
    ["Instance222"] = Instance.new("UICorner");
    ["Instance223"] = Instance.new("Frame");
    ["Instance224"] = Instance.new("UICorner");
    ["Instance225"] = Instance.new("Frame");
    ["Instance226"] = Instance.new("TextButton");
    ["Instance227"] = Instance.new("Frame");
    ["Instance228"] = Instance.new("TextLabel");
    ["Instance229"] = Instance.new("TextBox");
    ["Instance230"] = Instance.new("UIStroke");
    ["Instance231"] = Instance.new("UIPadding");
    ["Instance232"] = Instance.new("TextLabel");
    ["Instance233"] = Instance.new("UIPadding");
    ["Instance234"] = Instance.new("UICorner");
    ["Instance235"] = Instance.new("TextLabel");
    ["Instance236"] = Instance.new("UIPadding");
    ["Instance237"] = Instance.new("Frame");
    ["Instance238"] = Instance.new("TextButton");
    ["Instance239"] = Instance.new("Frame");
    ["Instance240"] = Instance.new("Frame");
    ["Instance241"] = Instance.new("ImageLabel");
    ["Instance242"] = Instance.new("UIAspectRatioConstraint");
    ["Instance243"] = Instance.new("ImageLabel");
    ["Instance244"] = Instance.new("UIAspectRatioConstraint");
    ["Instance245"] = Instance.new("UIListLayout");
    ["Instance246"] = Instance.new("TextLabel");
    ["Instance247"] = Instance.new("CanvasGroup");
    ["Instance248"] = Instance.new("Frame");
    ["Instance249"] = Instance.new("TextLabel");
    ["Instance250"] = Instance.new("UIPadding");
    ["Instance251"] = Instance.new("Frame");
    ["Instance252"] = Instance.new("UIGradient");
    ["Instance253"] = Instance.new("Frame");
    ["Instance254"] = Instance.new("TextButton");
    ["Instance255"] = Instance.new("UIListLayout");
    ["Instance256"] = Instance.new("TextLabel");
    ["Instance257"] = Instance.new("UIPadding");
    ["Instance258"] = Instance.new("UIStroke");
    ["Instance259"] = Instance.new("UICorner");
    ["Instance260"] = Instance.new("Frame");
    ["Instance261"] = Instance.new("TextButton");
    ["Instance262"] = Instance.new("Frame");
    ["Instance263"] = Instance.new("UIListLayout");
    ["Instance264"] = Instance.new("TextLabel");
    ["Instance265"] = Instance.new("TextLabel");
    ["Instance266"] = Instance.new("UIStroke");
    ["Instance267"] = Instance.new("UIPadding");
    ["Instance268"] = Instance.new("UIAspectRatioConstraint");
    ["Instance269"] = Instance.new("UICorner");
    ["Instance270"] = Instance.new("Frame");
    ["Instance271"] = Instance.new("TextButton");
    ["Instance272"] = Instance.new("Frame");
    ["Instance273"] = Instance.new("TextLabel");
    ["Instance274"] = Instance.new("Frame");
    ["Instance275"] = Instance.new("TextButton");
    ["Instance276"] = Instance.new("UIAspectRatioConstraint");
    ["Instance277"] = Instance.new("CanvasGroup");
    ["Instance278"] = Instance.new("UIStroke");
    ["Instance279"] = Instance.new("Frame");
    ["Instance280"] = Instance.new("UICorner");
    ["Instance281"] = Instance.new("UIListLayout");
    ["Instance282"] = Instance.new("TextButton");
    ["Instance283"] = Instance.new("UIAspectRatioConstraint");
    ["Instance284"] = Instance.new("TextLabel");
    ["Instance285"] = Instance.new("UIPadding");
    ["Instance286"] = Instance.new("UICorner");
    ["Instance287"] = Instance.new("UIStroke");
    ["Instance288"] = Instance.new("TextButton");
    ["Instance289"] = Instance.new("Frame");
    ["Instance290"] = Instance.new("Frame");
    ["Instance291"] = Instance.new("UIListLayout");
    ["Instance292"] = Instance.new("TextButton");
    ["Instance293"] = Instance.new("Frame");
    ["Instance294"] = Instance.new("UIListLayout");
    ["Instance295"] = Instance.new("Frame");
    ["Instance296"] = Instance.new("TextLabel");
    ["Instance297"] = Instance.new("Frame");
    ["Instance298"] = Instance.new("Frame");
    ["Instance299"] = Instance.new("CanvasGroup");
    ["Instance300"] = Instance.new("Frame");
    ["Instance301"] = Instance.new("CanvasGroup");
    ["Instance302"] = Instance.new("TextButton");
    ["Instance303"] = Instance.new("UIGradient");
    ["Instance304"] = Instance.new("UICorner");
    ["Instance305"] = Instance.new("UIStroke");
    ["Instance306"] = Instance.new("UIStroke");
    ["Instance307"] = Instance.new("Frame");
    ["Instance308"] = Instance.new("TextButton");
    ["Instance309"] = Instance.new("UICorner");
    ["Instance310"] = Instance.new("UICorner");
    ["Instance311"] = Instance.new("Folder");
    ["Instance312"] = Instance.new("TextButton");
    ["Instance313"] = Instance.new("CanvasGroup");
    ["Instance314"] = Instance.new("Frame");
    ["Instance315"] = Instance.new("Frame");
    ["Instance316"] = Instance.new("Frame");
    ["Instance317"] = Instance.new("TextButton");
    ["Instance318"] = Instance.new("CanvasGroup");
    ["Instance319"] = Instance.new("UICorner");
    ["Instance320"] = Instance.new("Frame");
    ["Instance321"] = Instance.new("UIGradient");
    ["Instance322"] = Instance.new("Frame");
    ["Instance323"] = Instance.new("UIStroke");
    ["Instance324"] = Instance.new("UICorner");
    ["Instance325"] = Instance.new("Frame");
    ["Instance326"] = Instance.new("UIGradient");
    ["Instance327"] = Instance.new("UIStroke");
    ["Instance328"] = Instance.new("TextButton");
    ["Instance329"] = Instance.new("UIGradient");
    ["Instance330"] = Instance.new("Frame");
    ["Instance331"] = Instance.new("UIStroke");
    ["Instance332"] = Instance.new("UIStroke");
    ["Instance333"] = Instance.new("UICorner");
    ["Instance334"] = Instance.new("Frame");
    ["Instance335"] = Instance.new("UIStroke");
    ["Instance336"] = Instance.new("UICorner");
    ["Instance337"] = Instance.new("Frame");
    ["Instance338"] = Instance.new("Folder");
    ["Instance339"] = Instance.new("UIListLayout");
    ["Instance340"] = Instance.new("TextButton");
    ["Instance341"] = Instance.new("TextLabel");
    ["Instance342"] = Instance.new("UIPadding");
    ["Instance343"] = Instance.new("TextBox");
    ["Instance344"] = Instance.new("UIPadding");
    ["Instance345"] = Instance.new("UIStroke");
    ["Instance346"] = Instance.new("UICorner");
    ["Instance347"] = Instance.new("TextButton");
    ["Instance348"] = Instance.new("TextLabel");
    ["Instance349"] = Instance.new("UIPadding");
    ["Instance350"] = Instance.new("TextBox");
    ["Instance351"] = Instance.new("UIPadding");
    ["Instance352"] = Instance.new("UIStroke");
    ["Instance353"] = Instance.new("UICorner");
    ["Instance354"] = Instance.new("TextButton");
    ["Instance355"] = Instance.new("TextLabel");
    ["Instance356"] = Instance.new("UIPadding");
    ["Instance357"] = Instance.new("TextBox");
    ["Instance358"] = Instance.new("UIPadding");
    ["Instance359"] = Instance.new("UIStroke");
    ["Instance360"] = Instance.new("UICorner");
    ["Instance361"] = Instance.new("TextButton");
    ["Instance362"] = Instance.new("UIPadding");
    ["Instance363"] = Instance.new("UIStroke");
    ["Instance364"] = Instance.new("UICorner");
    ["Instance365"] = Instance.new("Frame");
    ["Instance366"] = Instance.new("Frame");
    ["Instance367"] = Instance.new("UIListLayout");
    ["Instance368"] = Instance.new("TextButton");
    ["Instance369"] = Instance.new("UIAspectRatioConstraint");
    ["Instance370"] = Instance.new("ImageLabel");
    ["Instance371"] = Instance.new("TextLabel");
    ["Instance372"] = Instance.new("Frame");
    ["Instance373"] = Instance.new("UIStroke");
    ["Instance374"] = Instance.new("UICorner");
    ["Instance375"] = Instance.new("UIAspectRatioConstraint");
    ["Instance376"] = Instance.new("Folder");
    ["Instance377"] = Instance.new("TextButton");
    ["Instance378"] = Instance.new("CanvasGroup");
    ["Instance379"] = Instance.new("UIStroke");
    ["Instance380"] = Instance.new("ImageLabel");
    ["Instance381"] = Instance.new("UICorner");
    ["Instance382"] = Instance.new("TextLabel");
    ["Instance383"] = Instance.new("UICorner");
    ["Instance384"] = Instance.new("UIStroke");
    ["Instance385"] = Instance.new("Frame");
    ["Instance386"] = Instance.new("UIStroke");
    ["Instance387"] = Instance.new("TextLabel");
    ["Instance388"] = Instance.new("UIPadding");
    ["Instance389"] = Instance.new("TextLabel");
    ["Instance390"] = Instance.new("Folder");
    ["Instance391"] = Instance.new("Frame");
    ["Instance392"] = Instance.new("UIListLayout");
    ["Instance393"] = Instance.new("Frame");
    ["Instance394"] = Instance.new("UIPadding");
    ["Instance395"] = Instance.new("Frame");
    ["Instance396"] = Instance.new("Frame");
    ["Instance397"] = Instance.new("TextLabel");
    ["Instance398"] = Instance.new("UIPadding");
    ["Instance399"] = Instance.new("Frame");
    ["Instance400"] = Instance.new("TextLabel");
    ["Instance401"] = Instance.new("UIPadding");
    ["Instance402"] = Instance.new("Frame");
    ["Instance403"] = Instance.new("UIAspectRatioConstraint");
    ["Instance404"] = Instance.new("ImageButton");
    ["Instance405"] = Instance.new("ImageButton");
    ["Instance406"] = Instance.new("Frame");
    ["Instance407"] = Instance.new("UICorner");
    ["Instance408"] = Instance.new("Frame");
    ["Instance409"] = Instance.new("Frame");
    ["Instance410"] = Instance.new("CanvasGroup");
    ["Instance411"] = Instance.new("Frame");
    ["Instance412"] = Instance.new("Frame");
    ["Instance413"] = Instance.new("UICorner");
    ["Instance414"] = Instance.new("UIStroke");
    ["Instance415"] = Instance.new("UICorner");
    ["Instance416"] = Instance.new("Frame");
    ["Instance417"] = Instance.new("UIListLayout");
    ["Instance418"] = Instance.new("TextButton");
    ["Instance419"] = Instance.new("CanvasGroup");
    ["Instance420"] = Instance.new("Frame");
    ["Instance421"] = Instance.new("UIStroke");
    ["Instance422"] = Instance.new("Frame");
    ["Instance423"] = Instance.new("TextLabel");
    ["Instance424"] = Instance.new("ImageLabel");
    ["Instance425"] = Instance.new("UIAspectRatioConstraint");
    ["Instance426"] = Instance.new("TextLabel");
    ["Instance427"] = Instance.new("UICorner");
    ["Instance428"] = Instance.new("Folder");
    ["Instance429"] = Instance.new("Folder");
};

do -- Set properties
    objects["Instance0"]["Localize"] = false;
    objects["Instance0"]["AutoLocalize"] = false;
    objects["Instance0"]["Parent"] = parent;
    objects["Instance0"]["IgnoreGuiInset"] = true;
    objects["Instance0"]["ClipToDeviceSafeArea"] = false;
    objects["Instance0"]["Name"] = "FireLibV5";
    objects["Instance0"]["DisplayOrder"] = 2147483646;
    objects["Instance0"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
    objects["Instance0"]["ScreenInsets"] = Enum.ScreenInsets.DeviceSafeInsets;
    objects["Instance0"]["SafeAreaCompatibility"] = Enum.SafeAreaCompatibility.None;
    objects["Instance0"]["ResetOnSpawn"] = false;

    objects["Instance1"]["Parent"] = objects["Instance0"];
    objects["Instance1"]["Name"] = "Main";

    objects["Instance2"]["Parent"] = objects["Instance1"];
    objects["Instance2"]["Name"] = "Data";

    objects["Instance3"]["Parent"] = objects["Instance2"];
    objects["Instance3"]["Name"] = "Backgrounds";

    objects["Instance4"]["Parent"] = objects["Instance2"];
    objects["Instance4"]["Name"] = "DefaultThemes";

    objects["Instance5"]["Parent"] = objects["Instance2"];
    objects["Instance5"]["Name"] = "Icons";

    objects["Instance6"]["Parent"] = objects["Instance2"];
    objects["Instance6"]["Name"] = "Languages";

    objects["Instance7"]["Parent"] = objects["Instance2"];
    objects["Instance7"]["Name"] = "LucideIcons";

    objects["Instance8"]["Parent"] = objects["Instance2"];
    objects["Instance8"]["Name"] = "DEBUG";

    objects["Instance9"]["Parent"] = objects["Instance2"];
    objects["Instance9"]["Name"] = "Translators";

    objects["Instance10"]["Parent"] = objects["Instance1"];
    objects["Instance10"]["Name"] = "Example";

    objects["Instance11"]["Name"] = "Placeholders";
    objects["Instance11"]["Parent"] = objects["Instance1"];

    objects["Instance12"]["Name"] = "Sounds";
    objects["Instance12"]["Parent"] = objects["Instance1"];

    objects["Instance13"]["Parent"] = objects["Instance12"];
    objects["Instance13"]["SoundId"] = "rbxassetid://98797174600699";
    objects["Instance13"]["Name"] = "Notification";
    objects["Instance13"]["AudioContent"] = Content.fromUri("rbxassetid://98797174600699");

    objects["Instance14"]["Parent"] = objects["Instance12"];
    objects["Instance14"]["SoundId"] = "rbxassetid://99955064134003";
    objects["Instance14"]["Name"] = "Click";
    objects["Instance14"]["AudioContent"] = Content.fromUri("rbxassetid://99955064134003");

    objects["Instance15"]["Parent"] = objects["Instance12"];
    objects["Instance15"]["SoundId"] = "rbxassetid://107511012621133";
    objects["Instance15"]["Name"] = "Hover";
    objects["Instance15"]["AudioContent"] = Content.fromUri("rbxassetid://107511012621133");

    objects["Instance16"]["Parent"] = objects["Instance12"];
    objects["Instance16"]["SoundId"] = "rbxassetid://112788871431898";
    objects["Instance16"]["Name"] = "Test";
    objects["Instance16"]["AudioContent"] = Content.fromUri("rbxassetid://112788871431898");

    objects["Instance17"]["Name"] = "Libraries";
    objects["Instance17"]["Parent"] = objects["Instance1"];

    objects["Instance18"]["Parent"] = objects["Instance17"];
    objects["Instance18"]["Name"] = "Event";

    objects["Instance19"]["Parent"] = objects["Instance17"];
    objects["Instance19"]["Name"] = "Other";

    objects["Instance20"]["Parent"] = objects["Instance17"];
    objects["Instance20"]["Name"] = "UIBackgroundBlur";

    objects["Instance21"]["Parent"] = objects["Instance17"];
    objects["Instance21"]["Name"] = "Compressor";

    objects["Instance22"]["Parent"] = objects["Instance17"];
    objects["Instance22"]["Name"] = "Base64";

    objects["Instance23"]["Parent"] = objects["Instance17"];
    objects["Instance23"]["Name"] = "EditableCursor";

    objects["Instance24"]["Parent"] = objects["Instance17"];
    objects["Instance24"]["Name"] = "UIBlur";

    objects["Instance25"]["Parent"] = objects["Instance0"];
    objects["Instance25"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance25"]["BackgroundTransparency"] = 1;
    objects["Instance25"]["Name"] = "Holder";
    objects["Instance25"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance25"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance25"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance25"]["BorderSizePixel"] = 0;
    objects["Instance25"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance26"]["Parent"] = objects["Instance25"];

    objects["Instance27"]["TextTransparency"] = 1;
    objects["Instance27"]["Active"] = false;
    objects["Instance27"]["Selectable"] = false;
    objects["Instance27"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance27"]["BackgroundTransparency"] = 1;
    objects["Instance27"]["AutoButtonColor"] = false;
    objects["Instance27"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance27"]["Parent"] = objects["Instance25"];
    objects["Instance27"]["Name"] = "Window";
    objects["Instance27"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance27"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance27"]["ZIndex"] = 0;
    objects["Instance27"]["BorderSizePixel"] = 0;
    objects["Instance27"]["Size"] = UDim2.new(0.699999988079071, 250, 0.375, 150);

    objects["Instance28"]["ImageColor3"] = Color3.new(0, 0, 0);
    objects["Instance28"]["ImageTransparency"] = 0.20000000298023224;
    objects["Instance28"]["Parent"] = objects["Instance27"];
    objects["Instance28"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance28"]["Image"] = "rbxassetid://8774493213";
    objects["Instance28"]["ImageContent"] = Content.fromUri("rbxassetid://8774493213");
    objects["Instance28"]["ZIndex"] = 0;
    objects["Instance28"]["BorderSizePixel"] = 0;
    objects["Instance28"]["SliceCenter"] = Rect.new(135, 135, 889, 512);
    objects["Instance28"]["Localize"] = false;
    objects["Instance28"]["ScaleType"] = Enum.ScaleType.Slice;
    objects["Instance28"]["AutoLocalize"] = false;
    objects["Instance28"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance28"]["Name"] = "Shadow";
    objects["Instance28"]["Position"] = UDim2.new(0.5, 0, 0.51408451795578, 0);
    objects["Instance28"]["BackgroundTransparency"] = 1;
    objects["Instance28"]["Size"] = UDim2.new(1, 80, 1, 80);
    objects["Instance28"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance29"]["Name"] = "SoundCache";
    objects["Instance29"]["Parent"] = objects["Instance27"];

    objects["Instance30"]["Visible"] = false;
    objects["Instance30"]["Parent"] = objects["Instance27"];
    objects["Instance30"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance30"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance30"]["BackgroundTransparency"] = 1;
    objects["Instance30"]["Name"] = "Blur";
    objects["Instance30"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance30"]["Size"] = UDim2.new(1, -22, 1, -12);
    objects["Instance30"]["ZIndex"] = -1;
    objects["Instance30"]["BorderSizePixel"] = 0;
    objects["Instance30"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance31"]["Name"] = "RealWindow";
    objects["Instance31"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance31"]["Parent"] = objects["Instance27"];
    objects["Instance31"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance31"]["BorderSizePixel"] = 0;
    objects["Instance31"]["BackgroundColor3"] = Color3.new(0.0980392, 0.0980392, 0.0980392);

    objects["Instance32"]["ClipsDescendants"] = true;
    objects["Instance32"]["Parent"] = objects["Instance31"];
    objects["Instance32"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance32"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance32"]["BackgroundTransparency"] = 1;
    objects["Instance32"]["Name"] = "Contents";
    objects["Instance32"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance32"]["Size"] = UDim2.new(1, -2, 1, -2);
    objects["Instance32"]["ZIndex"] = 2;
    objects["Instance32"]["BorderSizePixel"] = 0;
    objects["Instance32"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance33"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance33"]["Active"] = false;
    objects["Instance33"]["Parent"] = objects["Instance32"];
    objects["Instance33"]["ZIndex"] = 99;
    objects["Instance33"]["BorderSizePixel"] = 0;
    objects["Instance33"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance33"]["Modal"] = true;
    objects["Instance33"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance33"]["Text"] = "";
    objects["Instance33"]["TextTransparency"] = 1;
    objects["Instance33"]["AutoButtonColor"] = false;
    objects["Instance33"]["Selected"] = true;
    objects["Instance33"]["BackgroundTransparency"] = 0.25;
    objects["Instance33"]["Name"] = "NotificationsOverlay";
    objects["Instance33"]["SelectionOrder"] = 1;
    objects["Instance33"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance33"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance33"]["TextSize"] = 14;
    objects["Instance33"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance34"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance34"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance34"]["Parent"] = objects["Instance33"];
    objects["Instance34"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance34"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance34"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance35"]["BackgroundTransparency"] = 1;
    objects["Instance35"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance35"]["Name"] = "Offsetter";
    objects["Instance35"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance35"]["Parent"] = objects["Instance33"];
    objects["Instance35"]["ZIndex"] = 100;
    objects["Instance35"]["BorderSizePixel"] = 0;
    objects["Instance35"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance36"]["ClipsDescendants"] = false;
    objects["Instance36"]["Parent"] = objects["Instance35"];
    objects["Instance36"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance36"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance36"]["Name"] = "Notification";
    objects["Instance36"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance36"]["Size"] = UDim2.new(0.20000000298023224, 220, 0.20000000298023224, 120);
    objects["Instance36"]["ZIndex"] = 109;
    objects["Instance36"]["BorderSizePixel"] = 0;
    objects["Instance36"]["BackgroundColor3"] = Color3.new(0.0980392, 0.0980392, 0.0980392);

    objects["Instance37"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance37"]["Transparency"] = 0.3499999940395355;
    objects["Instance37"]["Parent"] = objects["Instance36"];
    objects["Instance37"]["BorderStrokePosition"] = Enum.BorderStrokePosition.Inner;

    objects["Instance38"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance38"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance38"]["Parent"] = objects["Instance36"];
    objects["Instance38"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance38"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance38"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance39"]["Parent"] = objects["Instance36"];
    objects["Instance39"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance39"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance39"]["BackgroundTransparency"] = 1;
    objects["Instance39"]["Name"] = "ButtonsZone";
    objects["Instance39"]["Position"] = UDim2.new(0.5, 0, 1, -4);
    objects["Instance39"]["Size"] = UDim2.new(1, -8, 0.15000000596046448, -4);
    objects["Instance39"]["ZIndex"] = 110;
    objects["Instance39"]["BorderSizePixel"] = 0;
    objects["Instance39"]["BackgroundColor3"] = Color3.new(0.156863, 0.156863, 0.156863);

    objects["Instance40"]["Parent"] = objects["Instance39"];
    objects["Instance40"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance40"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance40"]["BackgroundTransparency"] = 1;
    objects["Instance40"]["Name"] = "Buttons";
    objects["Instance40"]["Position"] = UDim2.new(0, 0, 0.5, 0);
    objects["Instance40"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance40"]["ZIndex"] = 111;
    objects["Instance40"]["BorderSizePixel"] = 0;
    objects["Instance40"]["BackgroundColor3"] = Color3.new(0.156863, 0.156863, 0.156863);

    objects["Instance41"]["FillDirection"] = Enum.FillDirection.Horizontal;
    objects["Instance41"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right;
    objects["Instance41"]["Parent"] = objects["Instance40"];
    objects["Instance41"]["Padding"] = UDim.new(0, 4);
    objects["Instance41"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance42"]["Parent"] = objects["Instance40"];
    objects["Instance42"]["GroupColor3"] = Color3.new(1, 0, 0.490196);
    objects["Instance42"]["BackgroundTransparency"] = 1;
    objects["Instance42"]["Name"] = "Button";
    objects["Instance42"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance42"]["Size"] = UDim2.new(0, 70, 1, 0);
    objects["Instance42"]["ZIndex"] = 112;
    objects["Instance42"]["BorderSizePixel"] = 0;
    objects["Instance42"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance43"]["TextWrapped"] = true;
    objects["Instance43"]["BackgroundColor3"] = Color3.new(0.25098, 0.25098, 0.25098);
    objects["Instance43"]["ClipsDescendants"] = true;
    objects["Instance43"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance43"]["Text"] = "";
    objects["Instance43"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance43"]["TextColor3"] = Color3.new(1, 0, 0.490196);
    objects["Instance43"]["TextSize"] = 18;
    objects["Instance43"]["Parent"] = objects["Instance42"];
    objects["Instance43"]["BackgroundTransparency"] = 0.75;
    objects["Instance43"]["FontSize"] = Enum.FontSize.Size18;
    objects["Instance43"]["Size"] = UDim2.new(0, 70, 1, 0);
    objects["Instance43"]["ZIndex"] = 113;
    objects["Instance43"]["BorderSizePixel"] = 0;
    objects["Instance43"]["TextWrap"] = true;

    objects["Instance44"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance44"]["Transparency"] = 0.6700000166893005;
    objects["Instance44"]["Parent"] = objects["Instance43"];
    objects["Instance44"]["BorderStrokePosition"] = Enum.BorderStrokePosition.Inner;

    objects["Instance45"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance45"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance45"]["Parent"] = objects["Instance43"];
    objects["Instance45"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance45"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance45"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance46"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance46"]["Parent"] = objects["Instance43"];
    objects["Instance46"]["AnchorPoint"] = Vector2.new(1, 0.5);
    objects["Instance46"]["ZIndex"] = 114;
    objects["Instance46"]["BorderSizePixel"] = 0;
    objects["Instance46"]["Size"] = UDim2.new(0.699999988079071, 0, 0, 18);
    objects["Instance46"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance46"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance46"]["Text"] = "NO";
    objects["Instance46"]["TextWrap"] = true;
    objects["Instance46"]["Name"] = "Label";
    objects["Instance46"]["TextWrapped"] = true;
    objects["Instance46"]["BackgroundTransparency"] = 1;
    objects["Instance46"]["Position"] = UDim2.new(1, 0, 0.5, 0);
    objects["Instance46"]["TextSize"] = 14;
    objects["Instance46"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance46"]["TextScaled"] = true;
    objects["Instance46"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance47"]["Parent"] = objects["Instance43"];
    objects["Instance47"]["Size"] = UDim2.new(0, 18, 0, 18);
    objects["Instance47"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance47"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance47"]["Image"] = "rbxassetid://10152135063";
    objects["Instance47"]["BackgroundTransparency"] = 1;
    objects["Instance47"]["Position"] = UDim2.new(0, 8, 0.5, 0);
    objects["Instance47"]["ImageContent"] = Content.fromUri("rbxassetid://10152135063");
    objects["Instance47"]["ZIndex"] = 114;
    objects["Instance47"]["BorderSizePixel"] = 0;
    objects["Instance47"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance48"]["LayoutOrder"] = 1;
    objects["Instance48"]["Parent"] = objects["Instance40"];
    objects["Instance48"]["GroupColor3"] = Color3.new(0.490196, 1, 0);
    objects["Instance48"]["BackgroundTransparency"] = 1;
    objects["Instance48"]["Name"] = "Button";
    objects["Instance48"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance48"]["Size"] = UDim2.new(0, 70, 1, 0);
    objects["Instance48"]["ZIndex"] = 112;
    objects["Instance48"]["BorderSizePixel"] = 0;
    objects["Instance48"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance49"]["TextWrapped"] = true;
    objects["Instance49"]["BackgroundColor3"] = Color3.new(0.25098, 0.25098, 0.25098);
    objects["Instance49"]["ClipsDescendants"] = true;
    objects["Instance49"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance49"]["Text"] = "";
    objects["Instance49"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance49"]["TextColor3"] = Color3.new(1, 0, 0.490196);
    objects["Instance49"]["TextSize"] = 18;
    objects["Instance49"]["Parent"] = objects["Instance48"];
    objects["Instance49"]["BackgroundTransparency"] = 0.75;
    objects["Instance49"]["FontSize"] = Enum.FontSize.Size18;
    objects["Instance49"]["Size"] = UDim2.new(0, 70, 1, 0);
    objects["Instance49"]["ZIndex"] = 113;
    objects["Instance49"]["BorderSizePixel"] = 0;
    objects["Instance49"]["TextWrap"] = true;

    objects["Instance50"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance50"]["Transparency"] = 0.6700000166893005;
    objects["Instance50"]["Parent"] = objects["Instance49"];
    objects["Instance50"]["BorderStrokePosition"] = Enum.BorderStrokePosition.Inner;

    objects["Instance51"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance51"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance51"]["Parent"] = objects["Instance49"];
    objects["Instance51"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance51"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance51"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance52"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance52"]["Parent"] = objects["Instance49"];
    objects["Instance52"]["AnchorPoint"] = Vector2.new(1, 0.5);
    objects["Instance52"]["ZIndex"] = 114;
    objects["Instance52"]["BorderSizePixel"] = 0;
    objects["Instance52"]["Size"] = UDim2.new(0.699999988079071, 0, 0, 18);
    objects["Instance52"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance52"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance52"]["Text"] = "OK";
    objects["Instance52"]["TextWrap"] = true;
    objects["Instance52"]["Name"] = "Label";
    objects["Instance52"]["TextWrapped"] = true;
    objects["Instance52"]["BackgroundTransparency"] = 1;
    objects["Instance52"]["Position"] = UDim2.new(1, 0, 0.5, 0);
    objects["Instance52"]["TextSize"] = 14;
    objects["Instance52"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance52"]["TextScaled"] = true;
    objects["Instance52"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance53"]["Parent"] = objects["Instance49"];
    objects["Instance53"]["Size"] = UDim2.new(0, 18, 0, 18);
    objects["Instance53"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance53"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance53"]["Image"] = "rbxassetid://130396712201457";
    objects["Instance53"]["BackgroundTransparency"] = 1;
    objects["Instance53"]["Position"] = UDim2.new(0, 8, 0.5, 0);
    objects["Instance53"]["ImageContent"] = Content.fromUri("rbxassetid://130396712201457");
    objects["Instance53"]["ZIndex"] = 114;
    objects["Instance53"]["BorderSizePixel"] = 0;
    objects["Instance53"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance54"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance54"]["BackgroundColor3"] = Color3.new(0.156863, 0.156863, 0.156863);
    objects["Instance54"]["ClipsDescendants"] = true;
    objects["Instance54"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance54"]["Text"] = "";
    objects["Instance54"]["BackgroundTransparency"] = 1;
    objects["Instance54"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance54"]["Active"] = false;
    objects["Instance54"]["TextSize"] = 14;
    objects["Instance54"]["Name"] = "Toggle";
    objects["Instance54"]["Parent"] = objects["Instance39"];
    objects["Instance54"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance54"]["ZIndex"] = 111;
    objects["Instance54"]["BorderSizePixel"] = 0;
    objects["Instance54"]["Size"] = UDim2.new(0, 136, 1, 0);

    objects["Instance55"]["Parent"] = objects["Instance54"];
    objects["Instance55"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance55"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance55"]["BackgroundTransparency"] = 1;
    objects["Instance55"]["Name"] = "View";
    objects["Instance55"]["Position"] = UDim2.new(0, 4, 0.5, 0);
    objects["Instance55"]["Size"] = UDim2.new(100, 0, 0, 14);
    objects["Instance55"]["ZIndex"] = 112;
    objects["Instance55"]["BorderSizePixel"] = 0;
    objects["Instance55"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance56"]["LayoutOrder"] = 1;
    objects["Instance56"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance56"]["Parent"] = objects["Instance55"];
    objects["Instance56"]["ZIndex"] = 113;
    objects["Instance56"]["BorderSizePixel"] = 0;
    objects["Instance56"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance56"]["RichText"] = true;
    objects["Instance56"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance56"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance56"]["Text"] = "Never show again";
    objects["Instance56"]["TextSize"] = 14;
    objects["Instance56"]["TextWrap"] = true;
    objects["Instance56"]["TextWrapped"] = true;
    objects["Instance56"]["BackgroundTransparency"] = 1;
    objects["Instance56"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance56"]["Name"] = "Label";
    objects["Instance56"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance56"]["TextScaled"] = true;
    objects["Instance56"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance57"]["ImageColor3"] = Color3.new(1, 0, 0.498039);
    objects["Instance57"]["Parent"] = objects["Instance55"];
    objects["Instance57"]["BackgroundTransparency"] = 1;
    objects["Instance57"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance57"]["Image"] = "rbxassetid://130396712201457";
    objects["Instance57"]["Name"] = "Icon";
    objects["Instance57"]["Size"] = UDim2.new(1.2000000476837158, 0, 1.2000000476837158, 0);
    objects["Instance57"]["ImageContent"] = Content.fromUri("rbxassetid://130396712201457");
    objects["Instance57"]["ZIndex"] = 113;
    objects["Instance57"]["BorderSizePixel"] = 0;
    objects["Instance57"]["BackgroundColor3"] = Color3.new(1, 0, 0.498039);

    objects["Instance58"]["Parent"] = objects["Instance57"];

    objects["Instance59"]["Parent"] = objects["Instance57"];
    objects["Instance59"]["Transparency"] = 0.5;

    objects["Instance60"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance60"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance60"]["Parent"] = objects["Instance57"];
    objects["Instance60"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance60"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance60"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance61"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    objects["Instance61"]["FillDirection"] = Enum.FillDirection.Horizontal;
    objects["Instance61"]["Parent"] = objects["Instance55"];
    objects["Instance61"]["Padding"] = UDim.new(0, 7);
    objects["Instance61"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance62"]["ClipsDescendants"] = true;
    objects["Instance62"]["Parent"] = objects["Instance36"];
    objects["Instance62"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance62"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance62"]["BackgroundTransparency"] = 1;
    objects["Instance62"]["Name"] = "TextZone";
    objects["Instance62"]["Position"] = UDim2.new(0.5, 0, 0, 4);
    objects["Instance62"]["Size"] = UDim2.new(1, -16, 0.8500000238418579, -8);
    objects["Instance62"]["ZIndex"] = 110;
    objects["Instance62"]["BorderSizePixel"] = 0;
    objects["Instance62"]["BackgroundColor3"] = Color3.new(0.156863, 0.156863, 0.156863);

    objects["Instance63"]["TextWrap"] = true;
    objects["Instance63"]["TextWrapped"] = true;
    objects["Instance63"]["TextSize"] = 14;
    objects["Instance63"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance63"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance63"]["Text"] = "In-Window Notification";
    objects["Instance63"]["Name"] = "Title";
    objects["Instance63"]["Parent"] = objects["Instance62"];
    objects["Instance63"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance63"]["TextScaled"] = true;
    objects["Instance63"]["BackgroundTransparency"] = 1;
    objects["Instance63"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance63"]["Size"] = UDim2.new(1, 0, 0, 20);
    objects["Instance63"]["ZIndex"] = 111;
    objects["Instance63"]["BorderSizePixel"] = 0;
    objects["Instance63"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance64"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance64"]["Parent"] = objects["Instance62"];
    objects["Instance64"]["AnchorPoint"] = Vector2.new(0, 1);
    objects["Instance64"]["ZIndex"] = 111;
    objects["Instance64"]["BorderSizePixel"] = 0;
    objects["Instance64"]["Size"] = UDim2.new(1, 0, 1, -24);
    objects["Instance64"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance64"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance64"]["Text"] = "Hello, I wanted to warn you about something. Yeah, I know that this UI library is not really forkable or difficult to fork. I'm developing it in Roblox Studio, so I can see what I'm doing correct or wrong in real time. If you have suggestions, please DM me on discord";
    objects["Instance64"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance64"]["TextWrap"] = true;
    objects["Instance64"]["Name"] = "Text";
    objects["Instance64"]["TextWrapped"] = true;
    objects["Instance64"]["BackgroundTransparency"] = 1;
    objects["Instance64"]["Position"] = UDim2.new(0, 0, 1, 0);
    objects["Instance64"]["TextSize"] = 16;
    objects["Instance64"]["TextYAlignment"] = Enum.TextYAlignment.Top;
    objects["Instance64"]["FontSize"] = Enum.FontSize.Size18;
    objects["Instance64"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance65"]["BackgroundTransparency"] = 1;
    objects["Instance65"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance65"]["Name"] = "Shading";
    objects["Instance65"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance65"]["Parent"] = objects["Instance36"];
    objects["Instance65"]["ZIndex"] = 115;
    objects["Instance65"]["BorderSizePixel"] = 0;
    objects["Instance65"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance66"]["BackgroundTransparency"] = 1;
    objects["Instance66"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance66"]["Name"] = "TopbarZone";
    objects["Instance66"]["Size"] = UDim2.new(1, 0, 0, 40);
    objects["Instance66"]["Parent"] = objects["Instance32"];
    objects["Instance66"]["ZIndex"] = 70;
    objects["Instance66"]["BorderSizePixel"] = 0;
    objects["Instance66"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance67"]["ClipsDescendants"] = true;
    objects["Instance67"]["Parent"] = objects["Instance66"];
    objects["Instance67"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance67"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance67"]["BackgroundTransparency"] = 1;
    objects["Instance67"]["Name"] = "TitleZone";
    objects["Instance67"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance67"]["Size"] = UDim2.new(100, 0, 1, -16);
    objects["Instance67"]["ZIndex"] = 100;
    objects["Instance67"]["BorderSizePixel"] = 0;
    objects["Instance67"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance68"]["Wraps"] = true;
    objects["Instance68"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
    objects["Instance68"]["Parent"] = objects["Instance67"];
    objects["Instance68"]["Padding"] = UDim.new(0, 7);
    objects["Instance68"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
    objects["Instance68"]["FillDirection"] = Enum.FillDirection.Horizontal;

    objects["Instance69"]["ScaleType"] = Enum.ScaleType.Crop;
    objects["Instance69"]["Parent"] = objects["Instance67"];
    objects["Instance69"]["BackgroundTransparency"] = 1;
    objects["Instance69"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance69"]["Image"] = "rbxassetid://4705269490";
    objects["Instance69"]["Name"] = "Icon";
    objects["Instance69"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance69"]["ImageContent"] = Content.fromUri("rbxassetid://4705269490");
    objects["Instance69"]["ZIndex"] = 101;
    objects["Instance69"]["BorderSizePixel"] = 0;
    objects["Instance69"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance70"]["Parent"] = objects["Instance69"];
    objects["Instance70"]["AspectRatio"] = 0.9750000238418579;

    objects["Instance71"]["TopLeftRadius"] = UDim.new(0, 6);
    objects["Instance71"]["CornerRadius"] = UDim.new(0, 6);
    objects["Instance71"]["Parent"] = objects["Instance69"];
    objects["Instance71"]["BottomRightRadius"] = UDim.new(0, 6);
    objects["Instance71"]["TopRightRadius"] = UDim.new(0, 6);
    objects["Instance71"]["BottomLeftRadius"] = UDim.new(0, 6);

    objects["Instance72"]["LayoutOrder"] = 1;
    objects["Instance72"]["FontSize"] = Enum.FontSize.Size24;
    objects["Instance72"]["RichText"] = true;
    objects["Instance72"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance72"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance72"]["Text"] = "Fire Library";
    objects["Instance72"]["TextSize"] = 24;
    objects["Instance72"]["Name"] = "Title";
    objects["Instance72"]["Parent"] = objects["Instance67"];
    objects["Instance72"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance72"]["BackgroundTransparency"] = 1;
    objects["Instance72"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance72"]["Size"] = UDim2.new(0, 110, 1, 0);
    objects["Instance72"]["ZIndex"] = 101;
    objects["Instance72"]["BorderSizePixel"] = 0;
    objects["Instance72"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance73"]["BackgroundTransparency"] = 1;
    objects["Instance73"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance73"]["Name"] = "Right";
    objects["Instance73"]["Size"] = UDim2.new(1, -5, 1, 0);
    objects["Instance73"]["Parent"] = objects["Instance66"];
    objects["Instance73"]["ZIndex"] = 80;
    objects["Instance73"]["BorderSizePixel"] = 0;
    objects["Instance73"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance74"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    objects["Instance74"]["FillDirection"] = Enum.FillDirection.Horizontal;
    objects["Instance74"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right;
    objects["Instance74"]["Parent"] = objects["Instance73"];
    objects["Instance74"]["Padding"] = UDim.new(0, 5);
    objects["Instance74"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance75"]["LayoutOrder"] = 1;
    objects["Instance75"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance75"]["Active"] = false;
    objects["Instance75"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance75"]["Text"] = "";
    objects["Instance75"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance75"]["BackgroundTransparency"] = 1;
    objects["Instance75"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance75"]["TextSize"] = 14;
    objects["Instance75"]["Name"] = "ToggleUI";
    objects["Instance75"]["Parent"] = objects["Instance73"];
    objects["Instance75"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance75"]["ZIndex"] = 90;
    objects["Instance75"]["BorderSizePixel"] = 0;
    objects["Instance75"]["Size"] = UDim2.new(1, 0, 1, 0);

    objects["Instance76"]["Parent"] = objects["Instance75"];
    objects["Instance76"]["AspectRatio"] = 0.699999988079071;

    objects["Instance77"]["ScaleType"] = Enum.ScaleType.Fit;
    objects["Instance77"]["ImageTransparency"] = 0.25;
    objects["Instance77"]["Parent"] = objects["Instance75"];
    objects["Instance77"]["Size"] = UDim2.new(1, 0, 0.5, 0);
    objects["Instance77"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance77"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance77"]["Image"] = "rbxassetid://9405925508";
    objects["Instance77"]["BackgroundTransparency"] = 1;
    objects["Instance77"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance77"]["ImageContent"] = Content.fromUri("rbxassetid://9405925508");
    objects["Instance77"]["ZIndex"] = 95;
    objects["Instance77"]["BorderSizePixel"] = 0;
    objects["Instance77"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance78"]["LayoutOrder"] = 2;
    objects["Instance78"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance78"]["Active"] = false;
    objects["Instance78"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance78"]["Text"] = "";
    objects["Instance78"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance78"]["BackgroundTransparency"] = 1;
    objects["Instance78"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance78"]["TextSize"] = 14;
    objects["Instance78"]["Name"] = "Settings";
    objects["Instance78"]["Parent"] = objects["Instance73"];
    objects["Instance78"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance78"]["ZIndex"] = 90;
    objects["Instance78"]["BorderSizePixel"] = 0;
    objects["Instance78"]["Size"] = UDim2.new(1, 0, 1, 0);

    objects["Instance79"]["Parent"] = objects["Instance78"];
    objects["Instance79"]["AspectRatio"] = 0.699999988079071;

    objects["Instance80"]["ScaleType"] = Enum.ScaleType.Fit;
    objects["Instance80"]["ImageTransparency"] = 0.25;
    objects["Instance80"]["Parent"] = objects["Instance78"];
    objects["Instance80"]["Size"] = UDim2.new(1, 0, 0.5, 0);
    objects["Instance80"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance80"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance80"]["Image"] = "rbxassetid://4492476121";
    objects["Instance80"]["BackgroundTransparency"] = 1;
    objects["Instance80"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance80"]["ImageContent"] = Content.fromUri("rbxassetid://4492476121");
    objects["Instance80"]["ZIndex"] = 95;
    objects["Instance80"]["BorderSizePixel"] = 0;
    objects["Instance80"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance81"]["Visible"] = false;
    objects["Instance81"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance81"]["Active"] = false;
    objects["Instance81"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance81"]["Text"] = "";
    objects["Instance81"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance81"]["BackgroundTransparency"] = 1;
    objects["Instance81"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance81"]["TextSize"] = 14;
    objects["Instance81"]["Name"] = "Discord";
    objects["Instance81"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance81"]["Parent"] = objects["Instance73"];
    objects["Instance81"]["ZIndex"] = 90;
    objects["Instance81"]["BorderSizePixel"] = 0;
    objects["Instance81"]["Size"] = UDim2.new(1, 0, 1, 0);

    objects["Instance82"]["Parent"] = objects["Instance81"];
    objects["Instance82"]["AspectRatio"] = 0.699999988079071;

    objects["Instance83"]["ScaleType"] = Enum.ScaleType.Fit;
    objects["Instance83"]["ImageTransparency"] = 0.25;
    objects["Instance83"]["Parent"] = objects["Instance81"];
    objects["Instance83"]["Size"] = UDim2.new(1, 0, 0.5, 0);
    objects["Instance83"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance83"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance83"]["Image"] = "rbxassetid://91037557794799";
    objects["Instance83"]["BackgroundTransparency"] = 1;
    objects["Instance83"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance83"]["ImageContent"] = Content.fromUri("rbxassetid://91037557794799");
    objects["Instance83"]["ZIndex"] = 95;
    objects["Instance83"]["BorderSizePixel"] = 0;
    objects["Instance83"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance84"]["Visible"] = false;
    objects["Instance84"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance84"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance84"]["Active"] = false;
    objects["Instance84"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance84"]["Text"] = "";
    objects["Instance84"]["BackgroundTransparency"] = 1;
    objects["Instance84"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance84"]["TextSize"] = 14;
    objects["Instance84"]["LayoutOrder"] = 3;
    objects["Instance84"]["Name"] = "Close";
    objects["Instance84"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance84"]["Parent"] = objects["Instance73"];
    objects["Instance84"]["ZIndex"] = 90;
    objects["Instance84"]["BorderSizePixel"] = 0;
    objects["Instance84"]["Size"] = UDim2.new(1, 0, 1, 0);

    objects["Instance85"]["Parent"] = objects["Instance84"];
    objects["Instance85"]["AspectRatio"] = 0.699999988079071;

    objects["Instance86"]["ScaleType"] = Enum.ScaleType.Fit;
    objects["Instance86"]["ImageTransparency"] = 0.25;
    objects["Instance86"]["Parent"] = objects["Instance84"];
    objects["Instance86"]["Size"] = UDim2.new(1, 0, 0.5, 0);
    objects["Instance86"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance86"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance86"]["Image"] = "rbxassetid://10152135063";
    objects["Instance86"]["BackgroundTransparency"] = 1;
    objects["Instance86"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance86"]["ImageContent"] = Content.fromUri("rbxassetid://10152135063");
    objects["Instance86"]["ZIndex"] = 95;
    objects["Instance86"]["BorderSizePixel"] = 0;
    objects["Instance86"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance87"]["Parent"] = objects["Instance32"];
    objects["Instance87"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance87"]["AnchorPoint"] = Vector2.new(0, 1);
    objects["Instance87"]["BackgroundTransparency"] = 1;
    objects["Instance87"]["Name"] = "Footer";
    objects["Instance87"]["Position"] = UDim2.new(0, 0, 1, 0);
    objects["Instance87"]["Size"] = UDim2.new(1, 0, 0, 15);
    objects["Instance87"]["ZIndex"] = 3;
    objects["Instance87"]["BorderSizePixel"] = 0;
    objects["Instance87"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance88"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance88"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance88"]["Name"] = "SeparatorTop";
    objects["Instance88"]["Size"] = UDim2.new(1, 0, 0, 1);
    objects["Instance88"]["Parent"] = objects["Instance87"];
    objects["Instance88"]["ZIndex"] = 4;
    objects["Instance88"]["BorderSizePixel"] = 0;
    objects["Instance88"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance89"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance89"]["TextTransparency"] = 0.25;
    objects["Instance89"]["ZIndex"] = 4;
    objects["Instance89"]["BorderSizePixel"] = 0;
    objects["Instance89"]["Size"] = UDim2.new(1, 0, 1, -1);
    objects["Instance89"]["RichText"] = true;
    objects["Instance89"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance89"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance89"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance89"]["Text"] = "© 2026 NullFire, 4.0.2";
    objects["Instance89"]["TextWrap"] = true;
    objects["Instance89"]["TextSize"] = 14;
    objects["Instance89"]["TextWrapped"] = true;
    objects["Instance89"]["Name"] = "Label";
    objects["Instance89"]["BackgroundTransparency"] = 1;
    objects["Instance89"]["Position"] = UDim2.new(0, 0, 0, 1);
    objects["Instance89"]["Parent"] = objects["Instance87"];
    objects["Instance89"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal, true);
    objects["Instance89"]["TextScaled"] = true;
    objects["Instance89"]["BackgroundColor3"] = Color3.new(0.972549, 0.972549, 0.972549);

    objects["Instance90"]["Parent"] = objects["Instance89"];
    objects["Instance90"]["PaddingTop"] = UDim.new(0, 2);
    objects["Instance90"]["PaddingLeft"] = UDim.new(0, 5);
    objects["Instance90"]["PaddingBottom"] = UDim.new(0, 1);

    objects["Instance91"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance91"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance91"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance91"]["Text"] = "";
    objects["Instance91"]["BackgroundColor3"] = Color3.new(0.0980392, 0.0980392, 0.0980392);
    objects["Instance91"]["AutoButtonColor"] = false;
    objects["Instance91"]["BackgroundTransparency"] = 1;
    objects["Instance91"]["TextSize"] = 14;
    objects["Instance91"]["Name"] = "KeySystemOverlay";
    objects["Instance91"]["Parent"] = objects["Instance32"];
    objects["Instance91"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance91"]["ZIndex"] = 69;
    objects["Instance91"]["BorderSizePixel"] = 0;
    objects["Instance91"]["Size"] = UDim2.new(1, 0, 1, 0);

    objects["Instance92"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance92"]["Name"] = "Canvas";
    objects["Instance92"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance92"]["Parent"] = objects["Instance91"];
    objects["Instance92"]["ZIndex"] = 69;
    objects["Instance92"]["BorderSizePixel"] = 0;
    objects["Instance92"]["BackgroundColor3"] = Color3.new(0.0980392, 0.0980392, 0.0980392);

    objects["Instance93"]["ScaleType"] = Enum.ScaleType.Crop;
    objects["Instance93"]["ImageTransparency"] = 0.8500000238418579;
    objects["Instance93"]["Parent"] = objects["Instance92"];
    objects["Instance93"]["BackgroundTransparency"] = 1;
    objects["Instance93"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance93"]["Image"] = "rbxassetid://12727588434";
    objects["Instance93"]["Name"] = "BackgroundImage";
    objects["Instance93"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance93"]["ImageContent"] = Content.fromUri("rbxassetid://12727588434");
    objects["Instance93"]["ZIndex"] = 70;
    objects["Instance93"]["BorderSizePixel"] = 0;
    objects["Instance93"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance94"]["TopLeftRadius"] = UDim.new(0, 0);
    objects["Instance94"]["CornerRadius"] = UDim.new(0, 0);
    objects["Instance94"]["Parent"] = objects["Instance93"];
    objects["Instance94"]["BottomRightRadius"] = UDim.new(0, 0);
    objects["Instance94"]["TopRightRadius"] = UDim.new(0, 0);
    objects["Instance94"]["BottomLeftRadius"] = UDim.new(0, 0);

    objects["Instance95"]["Parent"] = objects["Instance92"];
    objects["Instance95"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance95"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance95"]["BackgroundTransparency"] = 1;
    objects["Instance95"]["Name"] = "Holder";
    objects["Instance95"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance95"]["Size"] = UDim2.new(0.30000001192092896, 100, 0, 110);
    objects["Instance95"]["ZIndex"] = 74;
    objects["Instance95"]["BorderSizePixel"] = 0;
    objects["Instance95"]["BackgroundColor3"] = Color3.new(0.0980392, 0.0980392, 0.0980392);

    objects["Instance96"]["ClipsDescendants"] = false;
    objects["Instance96"]["Parent"] = objects["Instance95"];
    objects["Instance96"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance96"]["BackgroundTransparency"] = 1;
    objects["Instance96"]["Name"] = "Upscaler";
    objects["Instance96"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance96"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance96"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance96"]["BorderSizePixel"] = 0;
    objects["Instance96"]["BackgroundColor3"] = Color3.new(0.972549, 0.972549, 0.972549);

    objects["Instance97"]["ImageColor3"] = Color3.new(0, 0, 0);
    objects["Instance97"]["ImageTransparency"] = 0.5;
    objects["Instance97"]["Parent"] = objects["Instance96"];
    objects["Instance97"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance97"]["Image"] = "rbxassetid://8774493213";
    objects["Instance97"]["ImageContent"] = Content.fromUri("rbxassetid://8774493213");
    objects["Instance97"]["ZIndex"] = 73;
    objects["Instance97"]["BorderSizePixel"] = 0;
    objects["Instance97"]["SliceCenter"] = Rect.new(135, 135, 889, 512);
    objects["Instance97"]["Localize"] = false;
    objects["Instance97"]["ScaleType"] = Enum.ScaleType.Slice;
    objects["Instance97"]["AutoLocalize"] = false;
    objects["Instance97"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance97"]["Name"] = "Shadow";
    objects["Instance97"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance97"]["BackgroundTransparency"] = 1;
    objects["Instance97"]["Size"] = UDim2.new(1, 30, 1, 30);
    objects["Instance97"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance98"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance98"]["Name"] = "Contents";
    objects["Instance98"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance98"]["Parent"] = objects["Instance96"];
    objects["Instance98"]["ZIndex"] = 74;
    objects["Instance98"]["BorderSizePixel"] = 0;
    objects["Instance98"]["BackgroundColor3"] = Color3.new(0.0980392, 0.0980392, 0.0980392);

    objects["Instance99"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance99"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance99"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance99"]["Text"] = "";
    objects["Instance99"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance99"]["BackgroundTransparency"] = 1;
    objects["Instance99"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance99"]["TextSize"] = 14;
    objects["Instance99"]["Name"] = "Bar";
    objects["Instance99"]["Position"] = UDim2.new(0.5, 0, 0.3499999940395355, 0);
    objects["Instance99"]["Parent"] = objects["Instance98"];
    objects["Instance99"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance99"]["BorderSizePixel"] = 0;
    objects["Instance99"]["Size"] = UDim2.new(0.949999988079071, 0, 0.2750000059604645, 0);

    objects["Instance100"]["ClipsDescendants"] = true;
    objects["Instance100"]["Parent"] = objects["Instance99"];
    objects["Instance100"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance100"]["BackgroundTransparency"] = 0.5;
    objects["Instance100"]["Name"] = "Bar";
    objects["Instance100"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance100"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance100"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance100"]["BorderSizePixel"] = 0;
    objects["Instance100"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance101"]["Color"] = Color3.new(1, 1, 1);
    objects["Instance101"]["Transparency"] = 0.8999999761581421;
    objects["Instance101"]["Parent"] = objects["Instance100"];

    objects["Instance102"]["ImageTransparency"] = 0.25;
    objects["Instance102"]["Parent"] = objects["Instance100"];
    objects["Instance102"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance102"]["BackgroundTransparency"] = 1;
    objects["Instance102"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance102"]["Image"] = "rbxassetid://117047144730308";
    objects["Instance102"]["Name"] = "Icon";
    objects["Instance102"]["Position"] = UDim2.new(0, 7, 0.5, 0);
    objects["Instance102"]["ImageContent"] = Content.fromUri("rbxassetid://117047144730308");
    objects["Instance102"]["Size"] = UDim2.new(0.699999988079071, 0, 0.699999988079071, 0);
    objects["Instance102"]["BorderSizePixel"] = 0;
    objects["Instance102"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance103"]["Parent"] = objects["Instance102"];

    objects["Instance104"]["Parent"] = objects["Instance102"];
    objects["Instance104"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance104"]["BackgroundTransparency"] = 0.8999999761581421;
    objects["Instance104"]["Name"] = "Separator";
    objects["Instance104"]["Position"] = UDim2.new(1.25, 0, 0.5, 0);
    objects["Instance104"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance104"]["Size"] = UDim2.new(0, 1, 0.699999988079071, 0);
    objects["Instance104"]["BorderSizePixel"] = 0;
    objects["Instance104"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance105"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance105"]["Parent"] = objects["Instance102"];
    objects["Instance105"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance105"]["PlaceholderColor3"] = Color3.new(0.7, 0.7, 0.7);
    objects["Instance105"]["PlaceholderText"] = "Your key here...";
    objects["Instance105"]["BorderSizePixel"] = 0;
    objects["Instance105"]["Size"] = UDim2.new(0, 10000, 0.800000011920929, 0);
    objects["Instance105"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance105"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance105"]["Text"] = "";
    objects["Instance105"]["TextSize"] = 14;
    objects["Instance105"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance105"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance105"]["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance105"]["BackgroundTransparency"] = 1;
    objects["Instance105"]["Position"] = UDim2.new(1.600000023841858, 1, 0.5, 0);
    objects["Instance105"]["TextWrapped"] = true;
    objects["Instance105"]["ClearTextOnFocus"] = false;
    objects["Instance105"]["TextScaled"] = true;
    objects["Instance105"]["TextWrap"] = true;

    objects["Instance106"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance106"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance106"]["Parent"] = objects["Instance100"];
    objects["Instance106"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance106"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance106"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance107"]["PaddingTop"] = UDim.new(0, 1);
    objects["Instance107"]["PaddingBottom"] = UDim.new(0, 1);
    objects["Instance107"]["PaddingRight"] = UDim.new(0, 1);
    objects["Instance107"]["PaddingLeft"] = UDim.new(0, 1);
    objects["Instance107"]["Parent"] = objects["Instance99"];

    objects["Instance108"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance108"]["Parent"] = objects["Instance98"];
    objects["Instance108"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance108"]["BorderSizePixel"] = 0;
    objects["Instance108"]["Size"] = UDim2.new(1, 0, 0.20000000298023224, 0);
    objects["Instance108"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance108"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance108"]["Text"] = "Key Required";
    objects["Instance108"]["TextWrap"] = true;
    objects["Instance108"]["Name"] = "Title";
    objects["Instance108"]["TextWrapped"] = true;
    objects["Instance108"]["BackgroundTransparency"] = 1;
    objects["Instance108"]["Position"] = UDim2.new(0.5, 0, 0.07500000298023224, 0);
    objects["Instance108"]["TextSize"] = 14;
    objects["Instance108"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance108"]["TextScaled"] = true;
    objects["Instance108"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance109"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance109"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance109"]["Parent"] = objects["Instance98"];
    objects["Instance109"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance109"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance109"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance110"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance110"]["Parent"] = objects["Instance98"];
    objects["Instance110"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance110"]["BorderSizePixel"] = 0;
    objects["Instance110"]["Size"] = UDim2.new(0.949999988079071, -2, 0.22499999403953552, -2);
    objects["Instance110"]["ClipsDescendants"] = true;
    objects["Instance110"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance110"]["Text"] = "Get Key";
    objects["Instance110"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance110"]["BackgroundTransparency"] = 0.8500000238418579;
    objects["Instance110"]["TextSize"] = 14;
    objects["Instance110"]["TextWrapped"] = true;
    objects["Instance110"]["Name"] = "Button";
    objects["Instance110"]["Position"] = UDim2.new(0.5, 0, 0.925000011920929, -1);
    objects["Instance110"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance110"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance110"]["TextScaled"] = true;
    objects["Instance110"]["TextWrap"] = true;

    objects["Instance111"]["Parent"] = objects["Instance110"];
    objects["Instance111"]["PaddingTop"] = UDim.new(0, 4);
    objects["Instance111"]["PaddingBottom"] = UDim.new(0, 4);

    objects["Instance112"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance112"]["Transparency"] = 0.8999999761581421;
    objects["Instance112"]["Parent"] = objects["Instance110"];
    objects["Instance112"]["Color"] = Color3.new(1, 1, 1);

    objects["Instance113"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance113"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance113"]["Parent"] = objects["Instance110"];
    objects["Instance113"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance113"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance113"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance114"]["BackgroundTransparency"] = 0.5;
    objects["Instance114"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance114"]["Name"] = "Darkener";
    objects["Instance114"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance114"]["Parent"] = objects["Instance92"];
    objects["Instance114"]["ZIndex"] = 72;
    objects["Instance114"]["BorderSizePixel"] = 0;
    objects["Instance114"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance115"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance115"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance115"]["Parent"] = objects["Instance114"];
    objects["Instance115"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance115"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance115"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance116"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance116"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance116"]["Parent"] = objects["Instance92"];
    objects["Instance116"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance116"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance116"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance117"]["Visible"] = false;
    objects["Instance117"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance117"]["Active"] = false;
    objects["Instance117"]["Parent"] = objects["Instance32"];
    objects["Instance117"]["ZIndex"] = 39;
    objects["Instance117"]["BorderSizePixel"] = 0;
    objects["Instance117"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance117"]["Modal"] = true;
    objects["Instance117"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance117"]["Text"] = "";
    objects["Instance117"]["TextTransparency"] = 1;
    objects["Instance117"]["AutoButtonColor"] = false;
    objects["Instance117"]["Selected"] = true;
    objects["Instance117"]["BackgroundTransparency"] = 0.5;
    objects["Instance117"]["Name"] = "SettingsOverlay";
    objects["Instance117"]["SelectionOrder"] = 1;
    objects["Instance117"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance117"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance117"]["TextSize"] = 14;
    objects["Instance117"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance118"]["ClipsDescendants"] = true;
    objects["Instance118"]["Parent"] = objects["Instance117"];
    objects["Instance118"]["AnchorPoint"] = Vector2.new(0, 1);
    objects["Instance118"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance118"]["Name"] = "SettingsHub";
    objects["Instance118"]["Position"] = UDim2.new(0, 0, 1, 0);
    objects["Instance118"]["Size"] = UDim2.new(1, 0, 1, -75);
    objects["Instance118"]["ZIndex"] = 40;
    objects["Instance118"]["BorderSizePixel"] = 0;
    objects["Instance118"]["BackgroundColor3"] = Color3.new(0.0784314, 0.0784314, 0.0784314);

    objects["Instance119"]["Parent"] = objects["Instance118"];
    objects["Instance119"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance119"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance119"]["BackgroundTransparency"] = 0.8999999761581421;
    objects["Instance119"]["Name"] = "Separator";
    objects["Instance119"]["Position"] = UDim2.new(0.5, 0, 0, 0);
    objects["Instance119"]["Size"] = UDim2.new(1, -28, 0, 1);
    objects["Instance119"]["ZIndex"] = 43;
    objects["Instance119"]["BorderSizePixel"] = 0;
    objects["Instance119"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance120"]["ScaleType"] = Enum.ScaleType.Crop;
    objects["Instance120"]["ImageTransparency"] = 0.8500000238418579;
    objects["Instance120"]["Parent"] = objects["Instance118"];
    objects["Instance120"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance120"]["AnchorPoint"] = Vector2.new(0, 1);
    objects["Instance120"]["BackgroundTransparency"] = 1;
    objects["Instance120"]["Name"] = "Image";
    objects["Instance120"]["Position"] = UDim2.new(0, 0, 1, 0);
    objects["Instance120"]["Size"] = UDim2.new(1, 0, 1, 75);
    objects["Instance120"]["ZIndex"] = 41;
    objects["Instance120"]["BorderSizePixel"] = 0;
    objects["Instance120"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance121"]["TopLeftRadius"] = UDim.new(0, 0);
    objects["Instance121"]["CornerRadius"] = UDim.new(0, 0);
    objects["Instance121"]["Parent"] = objects["Instance120"];
    objects["Instance121"]["BottomRightRadius"] = UDim.new(0, 0);
    objects["Instance121"]["TopRightRadius"] = UDim.new(0, 0);
    objects["Instance121"]["BottomLeftRadius"] = UDim.new(0, 0);

    objects["Instance122"]["TopLeftRadius"] = UDim.new(0, 0);
    objects["Instance122"]["CornerRadius"] = UDim.new(0, 0);
    objects["Instance122"]["Parent"] = objects["Instance118"];
    objects["Instance122"]["BottomRightRadius"] = UDim.new(0, 0);
    objects["Instance122"]["TopRightRadius"] = UDim.new(0, 0);
    objects["Instance122"]["BottomLeftRadius"] = UDim.new(0, 0);

    objects["Instance123"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance123"]["Name"] = "AntiCorner";
    objects["Instance123"]["Size"] = UDim2.new(1, 0, 0.5, 0);
    objects["Instance123"]["Parent"] = objects["Instance118"];
    objects["Instance123"]["ZIndex"] = 40;
    objects["Instance123"]["BorderSizePixel"] = 0;
    objects["Instance123"]["BackgroundColor3"] = Color3.new(0.0784314, 0.0784314, 0.0784314);

    objects["Instance124"]["TopLeftRadius"] = UDim.new(0, 0);
    objects["Instance124"]["CornerRadius"] = UDim.new(0, 0);
    objects["Instance124"]["Parent"] = objects["Instance117"];
    objects["Instance124"]["BottomRightRadius"] = UDim.new(0, 0);
    objects["Instance124"]["TopRightRadius"] = UDim.new(0, 0);
    objects["Instance124"]["BottomLeftRadius"] = UDim.new(0, 0);

    objects["Instance125"]["ScaleType"] = Enum.ScaleType.Crop;
    objects["Instance125"]["ImageTransparency"] = 0.8500000238418579;
    objects["Instance125"]["Parent"] = objects["Instance32"];
    objects["Instance125"]["BackgroundTransparency"] = 1;
    objects["Instance125"]["Image"] = "rbxassetid://12727588434";
    objects["Instance125"]["Name"] = "BackgroundImage";
    objects["Instance125"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance125"]["ImageContent"] = Content.fromUri("rbxassetid://12727588434");
    objects["Instance125"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance125"]["BorderSizePixel"] = 0;
    objects["Instance125"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance126"]["TopLeftRadius"] = UDim.new(0, 0);
    objects["Instance126"]["CornerRadius"] = UDim.new(0, 0);
    objects["Instance126"]["Parent"] = objects["Instance125"];
    objects["Instance126"]["BottomRightRadius"] = UDim.new(0, 0);
    objects["Instance126"]["TopRightRadius"] = UDim.new(0, 0);
    objects["Instance126"]["BottomLeftRadius"] = UDim.new(0, 0);

    objects["Instance127"]["BackgroundTransparency"] = 1;
    objects["Instance127"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance127"]["Name"] = "Display";
    objects["Instance127"]["Size"] = UDim2.new(1, 0, 1, -15);
    objects["Instance127"]["Parent"] = objects["Instance32"];
    objects["Instance127"]["ZIndex"] = 2;
    objects["Instance127"]["BorderSizePixel"] = 0;
    objects["Instance127"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance128"]["Parent"] = objects["Instance127"];
    objects["Instance128"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance128"]["BackgroundTransparency"] = 1;
    objects["Instance128"]["Name"] = "PageButtons";
    objects["Instance128"]["Position"] = UDim2.new(0, 0, 0, 40);
    objects["Instance128"]["Size"] = UDim2.new(0, 145, 1, -40);
    objects["Instance128"]["ZIndex"] = 3;
    objects["Instance128"]["BorderSizePixel"] = 0;
    objects["Instance128"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance129"]["Parent"] = objects["Instance128"];
    objects["Instance129"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance129"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance129"]["Name"] = "SeparatorLeft";
    objects["Instance129"]["Position"] = UDim2.new(1, 0, 0, 0);
    objects["Instance129"]["Size"] = UDim2.new(0, 1, 1, 0);
    objects["Instance129"]["ZIndex"] = 4;
    objects["Instance129"]["BorderSizePixel"] = 0;
    objects["Instance129"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance130"]["ScrollBarImageColor3"] = Color3.new(0, 0, 0);
    objects["Instance130"]["Parent"] = objects["Instance128"];
    objects["Instance130"]["ScrollBarThickness"] = 0;
    objects["Instance130"]["BackgroundTransparency"] = 1;
    objects["Instance130"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance130"]["Size"] = UDim2.new(1, 0, 1, -45);
    objects["Instance130"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
    objects["Instance130"]["Name"] = "List";
    objects["Instance130"]["ScrollingDirection"] = Enum.ScrollingDirection.Y;
    objects["Instance130"]["BackgroundColor3"] = Color3.new(1, 0, 0);
    objects["Instance130"]["ZIndex"] = 4;
    objects["Instance130"]["BorderSizePixel"] = 0;
    objects["Instance130"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);

    objects["Instance131"]["Parent"] = objects["Instance130"];
    objects["Instance131"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance132"]["LayoutOrder"] = 2147483647;
    objects["Instance132"]["BackgroundTransparency"] = 1;
    objects["Instance132"]["Name"] = "MobileSizeFix";
    objects["Instance132"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance132"]["Parent"] = objects["Instance130"];
    objects["Instance132"]["Size"] = UDim2.new(1, 0, 0, 1);
    objects["Instance132"]["BorderSizePixel"] = 0;
    objects["Instance132"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance133"]["ClipsDescendants"] = true;
    objects["Instance133"]["Selectable"] = false;
    objects["Instance133"]["TextTransparency"] = 1;
    objects["Instance133"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance133"]["BackgroundTransparency"] = 1;
    objects["Instance133"]["Active"] = false;
    objects["Instance133"]["Name"] = "PageHeader";
    objects["Instance133"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance133"]["Parent"] = objects["Instance130"];
    objects["Instance133"]["ZIndex"] = 50;
    objects["Instance133"]["BorderSizePixel"] = 0;
    objects["Instance133"]["Size"] = UDim2.new(1, 0, 0, 18);

    objects["Instance134"]["ClipsDescendants"] = true;
    objects["Instance134"]["Parent"] = objects["Instance133"];
    objects["Instance134"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance134"]["BackgroundTransparency"] = 1;
    objects["Instance134"]["Name"] = "View";
    objects["Instance134"]["Position"] = UDim2.new(0, 7, 0, 1);
    objects["Instance134"]["Size"] = UDim2.new(1, -15, 1, -2);
    objects["Instance134"]["ZIndex"] = 51;
    objects["Instance134"]["BorderSizePixel"] = 0;
    objects["Instance134"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance135"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    objects["Instance135"]["FillDirection"] = Enum.FillDirection.Horizontal;
    objects["Instance135"]["Parent"] = objects["Instance134"];
    objects["Instance135"]["Padding"] = UDim.new(0, 5);
    objects["Instance135"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance136"]["Parent"] = objects["Instance134"];
    objects["Instance136"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance136"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance136"]["BackgroundTransparency"] = 0.75;
    objects["Instance136"]["Name"] = "Left";
    objects["Instance136"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance136"]["Size"] = UDim2.new(0, 10, 0, 1);
    objects["Instance136"]["ZIndex"] = 51;
    objects["Instance136"]["BorderSizePixel"] = 0;
    objects["Instance136"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance137"]["LayoutOrder"] = 1;
    objects["Instance137"]["FontSize"] = Enum.FontSize.Size12;
    objects["Instance137"]["Parent"] = objects["Instance134"];
    objects["Instance137"]["ZIndex"] = 51;
    objects["Instance137"]["BorderSizePixel"] = 0;
    objects["Instance137"]["Size"] = UDim2.new(0, 36, 1, 0);
    objects["Instance137"]["RichText"] = true;
    objects["Instance137"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance137"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance137"]["Text"] = "Header";
    objects["Instance137"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance137"]["TextWrap"] = true;
    objects["Instance137"]["TextWrapped"] = true;
    objects["Instance137"]["TextSize"] = 12;
    objects["Instance137"]["BackgroundTransparency"] = 1;
    objects["Instance137"]["Position"] = UDim2.new(0, 15, 0, 12);
    objects["Instance137"]["Name"] = "Label";
    objects["Instance137"]["TextTransparency"] = 0.6000000238418579;
    objects["Instance137"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance137"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance138"]["LayoutOrder"] = 2;
    objects["Instance138"]["Parent"] = objects["Instance134"];
    objects["Instance138"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance138"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance138"]["BackgroundTransparency"] = 0.75;
    objects["Instance138"]["Name"] = "Right";
    objects["Instance138"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance138"]["Size"] = UDim2.new(1, 0, 0, 1);
    objects["Instance138"]["ZIndex"] = 51;
    objects["Instance138"]["BorderSizePixel"] = 0;
    objects["Instance138"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance139"]["Parent"] = objects["Instance133"];
    objects["Instance139"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance139"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance139"]["Name"] = "Separator";
    objects["Instance139"]["Position"] = UDim2.new(0, 7, 0, 0);
    objects["Instance139"]["Size"] = UDim2.new(1, -15, 0, 1);
    objects["Instance139"]["ZIndex"] = 51;
    objects["Instance139"]["BorderSizePixel"] = 0;
    objects["Instance139"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance140"]["ClipsDescendants"] = true;
    objects["Instance140"]["Selectable"] = false;
    objects["Instance140"]["TextTransparency"] = 1;
    objects["Instance140"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance140"]["BackgroundTransparency"] = 1;
    objects["Instance140"]["Active"] = false;
    objects["Instance140"]["Name"] = "PageSeparator";
    objects["Instance140"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance140"]["Parent"] = objects["Instance130"];
    objects["Instance140"]["ZIndex"] = 50;
    objects["Instance140"]["BorderSizePixel"] = 0;
    objects["Instance140"]["Size"] = UDim2.new(1, 0, 0, 10);

    objects["Instance141"]["Parent"] = objects["Instance140"];
    objects["Instance141"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance141"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance141"]["Name"] = "Separator";
    objects["Instance141"]["Position"] = UDim2.new(0, 7, 0, 0);
    objects["Instance141"]["Size"] = UDim2.new(1, -15, 0, 1);
    objects["Instance141"]["ZIndex"] = 51;
    objects["Instance141"]["BorderSizePixel"] = 0;
    objects["Instance141"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance142"]["Parent"] = objects["Instance140"];
    objects["Instance142"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance142"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance142"]["BackgroundTransparency"] = 0.75;
    objects["Instance142"]["Name"] = "SeparatorMiddle";
    objects["Instance142"]["Position"] = UDim2.new(0, 7, 0.5, 0);
    objects["Instance142"]["Size"] = UDim2.new(1, -15, 0, 1);
    objects["Instance142"]["ZIndex"] = 51;
    objects["Instance142"]["BorderSizePixel"] = 0;
    objects["Instance142"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance143"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance143"]["BackgroundColor3"] = Color3.new(1, 0, 0.498039);
    objects["Instance143"]["ClipsDescendants"] = true;
    objects["Instance143"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance143"]["Text"] = "";
    objects["Instance143"]["BackgroundTransparency"] = 1;
    objects["Instance143"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance143"]["Active"] = false;
    objects["Instance143"]["TextSize"] = 14;
    objects["Instance143"]["Name"] = "PageButton";
    objects["Instance143"]["Parent"] = objects["Instance130"];
    objects["Instance143"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance143"]["ZIndex"] = 5;
    objects["Instance143"]["BorderSizePixel"] = 0;
    objects["Instance143"]["Size"] = UDim2.new(1, 0, 0, 35);

    objects["Instance144"]["Parent"] = objects["Instance143"];
    objects["Instance144"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance144"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance144"]["BackgroundTransparency"] = 1;
    objects["Instance144"]["Name"] = "ButtonItself";
    objects["Instance144"]["Position"] = UDim2.new(0, 11, 0.5, 0);
    objects["Instance144"]["Size"] = UDim2.new(100, 0, 0, 18);
    objects["Instance144"]["ZIndex"] = 5;
    objects["Instance144"]["BorderSizePixel"] = 0;
    objects["Instance144"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance145"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    objects["Instance145"]["FillDirection"] = Enum.FillDirection.Horizontal;
    objects["Instance145"]["Parent"] = objects["Instance144"];
    objects["Instance145"]["Padding"] = UDim.new(0, 7);
    objects["Instance145"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance146"]["ScaleType"] = Enum.ScaleType.Fit;
    objects["Instance146"]["ImageTransparency"] = 0.25;
    objects["Instance146"]["Parent"] = objects["Instance144"];
    objects["Instance146"]["BackgroundTransparency"] = 1;
    objects["Instance146"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance146"]["Image"] = "rbxassetid://14456045412";
    objects["Instance146"]["Name"] = "Icon";
    objects["Instance146"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance146"]["ImageContent"] = Content.fromUri("rbxassetid://14456045412");
    objects["Instance146"]["ZIndex"] = 6;
    objects["Instance146"]["BorderSizePixel"] = 0;
    objects["Instance146"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance147"]["Parent"] = objects["Instance146"];

    objects["Instance148"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance148"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance148"]["Parent"] = objects["Instance146"];
    objects["Instance148"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance148"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance148"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance149"]["LayoutOrder"] = 1;
    objects["Instance149"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance149"]["Parent"] = objects["Instance144"];
    objects["Instance149"]["ZIndex"] = 6;
    objects["Instance149"]["BorderSizePixel"] = 0;
    objects["Instance149"]["Size"] = UDim2.new(1, 1024, 1.25, 0);
    objects["Instance149"]["RichText"] = true;
    objects["Instance149"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance149"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance149"]["Text"] = "Home";
    objects["Instance149"]["Name"] = "Title";
    objects["Instance149"]["TextWrap"] = true;
    objects["Instance149"]["TextWrapped"] = true;
    objects["Instance149"]["TextSize"] = 14;
    objects["Instance149"]["BackgroundTransparency"] = 1;
    objects["Instance149"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance149"]["TextTransparency"] = 0.25;
    objects["Instance149"]["FontFace"] = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance149"]["TextScaled"] = true;
    objects["Instance149"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance150"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance150"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance150"]["Name"] = "Indicator";
    objects["Instance150"]["Position"] = UDim2.new(0, -2, 0.5, 0);
    objects["Instance150"]["Parent"] = objects["Instance143"];
    objects["Instance150"]["Size"] = UDim2.new(0, 4, 0.5, 0);
    objects["Instance150"]["BorderSizePixel"] = 0;
    objects["Instance150"]["BackgroundColor3"] = Color3.new(1, 0, 0.494118);

    objects["Instance151"]["TopLeftRadius"] = UDim.new(1, 0);
    objects["Instance151"]["CornerRadius"] = UDim.new(1, 0);
    objects["Instance151"]["Parent"] = objects["Instance150"];
    objects["Instance151"]["BottomRightRadius"] = UDim.new(1, 0);
    objects["Instance151"]["TopRightRadius"] = UDim.new(1, 0);
    objects["Instance151"]["BottomLeftRadius"] = UDim.new(1, 0);

    objects["Instance152"]["ScaleType"] = Enum.ScaleType.Crop;
    objects["Instance152"]["ImageTransparency"] = 0.875;
    objects["Instance152"]["Parent"] = objects["Instance143"];
    objects["Instance152"]["Image"] = "rbxassetid://139437521";
    objects["Instance152"]["BackgroundTransparency"] = 1;
    objects["Instance152"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance152"]["ImageContent"] = Content.fromUri("rbxassetid://139437521");
    objects["Instance152"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance152"]["BorderSizePixel"] = 0;
    objects["Instance152"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance153"]["Parent"] = objects["Instance143"];
    objects["Instance153"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance153"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance153"]["Name"] = "Filler";
    objects["Instance153"]["Position"] = UDim2.new(0, 7, 0, 0);
    objects["Instance153"]["Size"] = UDim2.new(1, -15, 0, 1);
    objects["Instance153"]["ZIndex"] = 51;
    objects["Instance153"]["BorderSizePixel"] = 0;
    objects["Instance153"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance154"]["Parent"] = objects["Instance128"];
    objects["Instance154"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance154"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance154"]["BackgroundTransparency"] = 0.925000011920929;
    objects["Instance154"]["Name"] = "Filler";
    objects["Instance154"]["Position"] = UDim2.new(0.5, 0, 1, -5);
    objects["Instance154"]["Size"] = UDim2.new(1, -15, 0, 1);
    objects["Instance154"]["ZIndex"] = 4;
    objects["Instance154"]["BorderSizePixel"] = 0;
    objects["Instance154"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance155"]["Parent"] = objects["Instance128"];
    objects["Instance155"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance155"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance155"]["Name"] = "SeparatorTop";
    objects["Instance155"]["Position"] = UDim2.new(1, 1, 0, 0);
    objects["Instance155"]["Size"] = UDim2.new(10, 10000, 0, 1);
    objects["Instance155"]["ZIndex"] = 4;
    objects["Instance155"]["BorderSizePixel"] = 0;
    objects["Instance155"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance156"]["ClipsDescendants"] = true;
    objects["Instance156"]["Parent"] = objects["Instance128"];
    objects["Instance156"]["AnchorPoint"] = Vector2.new(0, 1);
    objects["Instance156"]["BackgroundTransparency"] = 1;
    objects["Instance156"]["Name"] = "UserProfile";
    objects["Instance156"]["Position"] = UDim2.new(0, 0, 1, -5);
    objects["Instance156"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance156"]["Size"] = UDim2.new(1, 0, 0, 40);
    objects["Instance156"]["BorderSizePixel"] = 0;
    objects["Instance156"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance157"]["Parent"] = objects["Instance156"];
    objects["Instance157"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance157"]["BackgroundTransparency"] = 0.8999999761581421;
    objects["Instance157"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance157"]["Image"] = "rbxthumb://type=AvatarHeadShot&id=3287524975&w=420&h=420";
    objects["Instance157"]["Name"] = "User";
    objects["Instance157"]["Position"] = UDim2.new(0, 5, 0.5, 0);
    objects["Instance157"]["ImageContent"] = Content.fromUri("rbxthumb://type=AvatarHeadShot&id=3287524975&w=420&h=420");
    objects["Instance157"]["Size"] = UDim2.new(0.800000011920929, 0, 0.800000011920929, 0);
    objects["Instance157"]["BorderSizePixel"] = 0;
    objects["Instance157"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance158"]["Parent"] = objects["Instance157"];

    objects["Instance159"]["Parent"] = objects["Instance157"];

    objects["Instance160"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance160"]["BackgroundTransparency"] = 1;
    objects["Instance160"]["Name"] = "Profile";
    objects["Instance160"]["Position"] = UDim2.new(1, 5, 0, 0);
    objects["Instance160"]["Parent"] = objects["Instance157"];
    objects["Instance160"]["Size"] = UDim2.new(0, 1024, 1, 0);
    objects["Instance160"]["BorderSizePixel"] = 0;
    objects["Instance160"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance161"]["RichText"] = true;
    objects["Instance161"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance161"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance161"]["Text"] = "Kawi\n<font size=\"10\" transparency=\"0.25\">NEVER EXPIRES AHAHAHA</font>";
    objects["Instance161"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance161"]["TextSize"] = 16;
    objects["Instance161"]["Parent"] = objects["Instance160"];
    objects["Instance161"]["BackgroundTransparency"] = 1;
    objects["Instance161"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance161"]["FontSize"] = Enum.FontSize.Size18;
    objects["Instance161"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance161"]["BorderSizePixel"] = 0;
    objects["Instance161"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance162"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance162"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance162"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance162"]["Text"] = "";
    objects["Instance162"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance162"]["BackgroundTransparency"] = 1;
    objects["Instance162"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance162"]["TextSize"] = 14;
    objects["Instance162"]["Name"] = "Resizer";
    objects["Instance162"]["Position"] = UDim2.new(1, 0, 0, 1);
    objects["Instance162"]["Parent"] = objects["Instance128"];
    objects["Instance162"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance162"]["BorderSizePixel"] = 0;
    objects["Instance162"]["Size"] = UDim2.new(0, 6, 1, -1);

    objects["Instance163"]["Parent"] = objects["Instance127"];
    objects["Instance163"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance163"]["AnchorPoint"] = Vector2.new(1, 0);
    objects["Instance163"]["BackgroundTransparency"] = 1;
    objects["Instance163"]["Name"] = "Pages";
    objects["Instance163"]["Position"] = UDim2.new(1, 1, 0, 40);
    objects["Instance163"]["Size"] = UDim2.new(1, -145, 1, -40);
    objects["Instance163"]["ZIndex"] = 3;
    objects["Instance163"]["BorderSizePixel"] = 0;
    objects["Instance163"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance164"]["ScrollBarImageColor3"] = Color3.new(1, 0, 0.498039);
    objects["Instance164"]["BottomImage"] = "rbxasset://textures/ui/Scroll/scroll-middle.png";
    objects["Instance164"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance164"]["BackgroundTransparency"] = 1;
    objects["Instance164"]["Parent"] = objects["Instance163"];
    objects["Instance164"]["ScrollBarThickness"] = 4;
    objects["Instance164"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance164"]["Size"] = UDim2.new(1, -1, 1, 0);
    objects["Instance164"]["TopImageContent"] = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png");
    objects["Instance164"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
    objects["Instance164"]["TopImage"] = "rbxasset://textures/ui/Scroll/scroll-middle.png";
    objects["Instance164"]["BottomImageContent"] = Content.fromUri("rbxasset://textures/ui/Scroll/scroll-middle.png");
    objects["Instance164"]["Name"] = "Page";
    objects["Instance164"]["ZIndex"] = 4;
    objects["Instance164"]["BorderSizePixel"] = 0;
    objects["Instance164"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);

    objects["Instance165"]["Parent"] = objects["Instance164"];
    objects["Instance165"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance166"]["LayoutOrder"] = 2147483647;
    objects["Instance166"]["BackgroundTransparency"] = 1;
    objects["Instance166"]["Name"] = "MobileSizeFix";
    objects["Instance166"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance166"]["Parent"] = objects["Instance164"];
    objects["Instance166"]["Size"] = UDim2.new(1, 0, 0, 1);
    objects["Instance166"]["BorderSizePixel"] = 0;
    objects["Instance166"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance167"]["LayoutOrder"] = 1;
    objects["Instance167"]["Active"] = false;
    objects["Instance167"]["Selectable"] = false;
    objects["Instance167"]["Text"] = "";
    objects["Instance167"]["TextTransparency"] = 1;
    objects["Instance167"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance167"]["BackgroundTransparency"] = 1;
    objects["Instance167"]["Name"] = "GroupboxZone";
    objects["Instance167"]["Parent"] = objects["Instance164"];
    objects["Instance167"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance167"]["ZIndex"] = 5;
    objects["Instance167"]["BorderSizePixel"] = 0;
    objects["Instance167"]["Size"] = UDim2.new(1, 0, 0, 75);

    objects["Instance168"]["BackgroundTransparency"] = 1;
    objects["Instance168"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance168"]["Name"] = "LeftGroupboxZone";
    objects["Instance168"]["Size"] = UDim2.new(0.5, 0, 0, 75);
    objects["Instance168"]["Parent"] = objects["Instance167"];
    objects["Instance168"]["ZIndex"] = 6;
    objects["Instance168"]["BorderSizePixel"] = 0;
    objects["Instance168"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance169"]["Parent"] = objects["Instance168"];
    objects["Instance169"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance170"]["BackgroundTransparency"] = 1;
    objects["Instance170"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance170"]["Name"] = "Groupbox";
    objects["Instance170"]["Size"] = UDim2.new(1, 0, 0, 75);
    objects["Instance170"]["Parent"] = objects["Instance168"];
    objects["Instance170"]["ZIndex"] = 7;
    objects["Instance170"]["BorderSizePixel"] = 0;
    objects["Instance170"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance171"]["Parent"] = objects["Instance170"];
    objects["Instance171"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance171"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance171"]["BackgroundTransparency"] = 0.9750000238418579;
    objects["Instance171"]["Name"] = "Holder";
    objects["Instance171"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance171"]["Size"] = UDim2.new(1, -10, 1, -10);
    objects["Instance171"]["ZIndex"] = 8;
    objects["Instance171"]["BorderSizePixel"] = 0;
    objects["Instance171"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance172"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance172"]["Transparency"] = 0.5;
    objects["Instance172"]["Parent"] = objects["Instance171"];

    objects["Instance173"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance173"]["Size"] = UDim2.new(1, 0, 0, 2);
    objects["Instance173"]["Parent"] = objects["Instance171"];
    objects["Instance173"]["ZIndex"] = 9;
    objects["Instance173"]["BorderSizePixel"] = 0;
    objects["Instance173"]["BackgroundColor3"] = Color3.new(1, 0, 0.498039);

    objects["Instance174"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance174"]["Parent"] = objects["Instance171"];
    objects["Instance174"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance174"]["ZIndex"] = 9;
    objects["Instance174"]["BorderSizePixel"] = 0;
    objects["Instance174"]["Size"] = UDim2.new(1, 0, 0, 20);
    objects["Instance174"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance174"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance174"]["Text"] = "Groupbox";
    objects["Instance174"]["TextWrap"] = true;
    objects["Instance174"]["Name"] = "Title";
    objects["Instance174"]["TextWrapped"] = true;
    objects["Instance174"]["BackgroundTransparency"] = 1;
    objects["Instance174"]["Position"] = UDim2.new(0.5, 0, 0, 2);
    objects["Instance174"]["TextSize"] = 14;
    objects["Instance174"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance174"]["TextScaled"] = true;
    objects["Instance174"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance175"]["Parent"] = objects["Instance174"];
    objects["Instance175"]["PaddingTop"] = UDim.new(0.100000001, 0);
    objects["Instance175"]["PaddingBottom"] = UDim.new(0.200000003, 0);

    objects["Instance176"]["ClipsDescendants"] = true;
    objects["Instance176"]["Parent"] = objects["Instance171"];
    objects["Instance176"]["Size"] = UDim2.new(1, -10, 1, -25);
    objects["Instance176"]["BackgroundTransparency"] = 0.75;
    objects["Instance176"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance176"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance176"]["Name"] = "Contents";
    objects["Instance176"]["Position"] = UDim2.new(0.5, 0, 0, 20);
    objects["Instance176"]["SelectionGroup"] = true;
    objects["Instance176"]["ZIndex"] = 9;
    objects["Instance176"]["BorderSizePixel"] = 0;
    objects["Instance176"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance177"]["Parent"] = objects["Instance176"];
    objects["Instance177"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance178"]["TopLeftRadius"] = UDim.new(0, 3);
    objects["Instance178"]["CornerRadius"] = UDim.new(0, 3);
    objects["Instance178"]["Parent"] = objects["Instance176"];
    objects["Instance178"]["BottomRightRadius"] = UDim.new(0, 3);
    objects["Instance178"]["TopRightRadius"] = UDim.new(0, 3);
    objects["Instance178"]["BottomLeftRadius"] = UDim.new(0, 3);

    objects["Instance179"]["TopLeftRadius"] = UDim.new(0, 3);
    objects["Instance179"]["CornerRadius"] = UDim.new(0, 3);
    objects["Instance179"]["Parent"] = objects["Instance171"];
    objects["Instance179"]["BottomRightRadius"] = UDim.new(0, 3);
    objects["Instance179"]["TopRightRadius"] = UDim.new(0, 3);
    objects["Instance179"]["BottomLeftRadius"] = UDim.new(0, 3);

    objects["Instance180"]["Parent"] = objects["Instance167"];
    objects["Instance180"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance180"]["BackgroundTransparency"] = 1;
    objects["Instance180"]["Name"] = "RightGroupboxZone";
    objects["Instance180"]["Position"] = UDim2.new(0.5, 0, 0, 0);
    objects["Instance180"]["Size"] = UDim2.new(0.5, 0, 0, 240);
    objects["Instance180"]["ZIndex"] = 6;
    objects["Instance180"]["BorderSizePixel"] = 0;
    objects["Instance180"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance181"]["Parent"] = objects["Instance180"];
    objects["Instance181"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance182"]["TextTransparency"] = 1;
    objects["Instance182"]["ClipsDescendants"] = true;
    objects["Instance182"]["Selectable"] = false;
    objects["Instance182"]["Text"] = "";
    objects["Instance182"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance182"]["BackgroundTransparency"] = 1;
    objects["Instance182"]["TextColor3"] = Color3.new(0.105882, 0.164706, 0.207843);
    objects["Instance182"]["Active"] = false;
    objects["Instance182"]["Name"] = "NormalZone";
    objects["Instance182"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance182"]["Parent"] = objects["Instance164"];
    objects["Instance182"]["ZIndex"] = 5;
    objects["Instance182"]["BorderSizePixel"] = 0;
    objects["Instance182"]["Size"] = UDim2.new(1, 0, 0, 360);

    objects["Instance183"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance183"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance183"]["ClipsDescendants"] = true;
    objects["Instance183"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance183"]["Text"] = "";
    objects["Instance183"]["BackgroundTransparency"] = 1;
    objects["Instance183"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance183"]["Active"] = false;
    objects["Instance183"]["TextSize"] = 14;
    objects["Instance183"]["Name"] = "Button";
    objects["Instance183"]["Parent"] = objects["Instance182"];
    objects["Instance183"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance183"]["ZIndex"] = 50;
    objects["Instance183"]["BorderSizePixel"] = 0;
    objects["Instance183"]["Size"] = UDim2.new(1, 0, 0, 40);

    objects["Instance184"]["Parent"] = objects["Instance183"];
    objects["Instance184"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance184"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance184"]["BackgroundTransparency"] = 1;
    objects["Instance184"]["Name"] = "View";
    objects["Instance184"]["Position"] = UDim2.new(0, 17, 0.5, 0);
    objects["Instance184"]["Size"] = UDim2.new(100, 0, 0, 16);
    objects["Instance184"]["ZIndex"] = 51;
    objects["Instance184"]["BorderSizePixel"] = 0;
    objects["Instance184"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance185"]["Parent"] = objects["Instance184"];
    objects["Instance185"]["BackgroundTransparency"] = 1;
    objects["Instance185"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance185"]["Image"] = "rbxassetid://14913216473";
    objects["Instance185"]["Name"] = "Icon";
    objects["Instance185"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance185"]["ImageContent"] = Content.fromUri("rbxassetid://14913216473");
    objects["Instance185"]["ZIndex"] = 52;
    objects["Instance185"]["BorderSizePixel"] = 0;
    objects["Instance185"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance186"]["Parent"] = objects["Instance185"];
    objects["Instance186"]["AspectRatio"] = 0.9750000238418579;

    objects["Instance187"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    objects["Instance187"]["FillDirection"] = Enum.FillDirection.Horizontal;
    objects["Instance187"]["Parent"] = objects["Instance184"];
    objects["Instance187"]["Padding"] = UDim.new(0, 9);
    objects["Instance187"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance188"]["LayoutOrder"] = 1;
    objects["Instance188"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance188"]["Parent"] = objects["Instance184"];
    objects["Instance188"]["ZIndex"] = 52;
    objects["Instance188"]["BorderSizePixel"] = 0;
    objects["Instance188"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance188"]["RichText"] = true;
    objects["Instance188"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance188"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance188"]["Text"] = "Button";
    objects["Instance188"]["TextSize"] = 14;
    objects["Instance188"]["TextWrap"] = true;
    objects["Instance188"]["TextWrapped"] = true;
    objects["Instance188"]["BackgroundTransparency"] = 1;
    objects["Instance188"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance188"]["Name"] = "Label";
    objects["Instance188"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance188"]["TextScaled"] = true;
    objects["Instance188"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance189"]["Parent"] = objects["Instance183"];
    objects["Instance189"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance189"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance189"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance189"]["Name"] = "Separator";
    objects["Instance189"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance189"]["Size"] = UDim2.new(1, -20, 0, 1);
    objects["Instance189"]["ZIndex"] = 51;
    objects["Instance189"]["BorderSizePixel"] = 0;
    objects["Instance189"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance190"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance190"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance190"]["ClipsDescendants"] = true;
    objects["Instance190"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance190"]["Text"] = "";
    objects["Instance190"]["BackgroundTransparency"] = 1;
    objects["Instance190"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance190"]["Active"] = false;
    objects["Instance190"]["TextSize"] = 14;
    objects["Instance190"]["Name"] = "Toggle";
    objects["Instance190"]["Parent"] = objects["Instance182"];
    objects["Instance190"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance190"]["ZIndex"] = 50;
    objects["Instance190"]["BorderSizePixel"] = 0;
    objects["Instance190"]["Size"] = UDim2.new(1, 0, 0, 40);

    objects["Instance191"]["Parent"] = objects["Instance190"];
    objects["Instance191"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance191"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance191"]["BackgroundTransparency"] = 1;
    objects["Instance191"]["Name"] = "View";
    objects["Instance191"]["Position"] = UDim2.new(0, 15, 0.5, 0);
    objects["Instance191"]["Size"] = UDim2.new(100, 0, 0, 16);
    objects["Instance191"]["ZIndex"] = 51;
    objects["Instance191"]["BorderSizePixel"] = 0;
    objects["Instance191"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance192"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    objects["Instance192"]["FillDirection"] = Enum.FillDirection.Horizontal;
    objects["Instance192"]["Parent"] = objects["Instance191"];
    objects["Instance192"]["Padding"] = UDim.new(0, 7);
    objects["Instance192"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance193"]["LayoutOrder"] = 1;
    objects["Instance193"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance193"]["Parent"] = objects["Instance191"];
    objects["Instance193"]["ZIndex"] = 52;
    objects["Instance193"]["BorderSizePixel"] = 0;
    objects["Instance193"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance193"]["RichText"] = true;
    objects["Instance193"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance193"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance193"]["Text"] = "Checkbox / toggle";
    objects["Instance193"]["TextSize"] = 14;
    objects["Instance193"]["TextWrap"] = true;
    objects["Instance193"]["TextWrapped"] = true;
    objects["Instance193"]["BackgroundTransparency"] = 1;
    objects["Instance193"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance193"]["Name"] = "Label";
    objects["Instance193"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance193"]["TextScaled"] = true;
    objects["Instance193"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance194"]["ImageColor3"] = Color3.new(1, 0, 0.498039);
    objects["Instance194"]["Parent"] = objects["Instance191"];
    objects["Instance194"]["BackgroundTransparency"] = 1;
    objects["Instance194"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance194"]["Image"] = "rbxassetid://130396712201457";
    objects["Instance194"]["Name"] = "Icon";
    objects["Instance194"]["Size"] = UDim2.new(1.2000000476837158, 0, 1.2000000476837158, 0);
    objects["Instance194"]["ImageContent"] = Content.fromUri("rbxassetid://130396712201457");
    objects["Instance194"]["ZIndex"] = 52;
    objects["Instance194"]["BorderSizePixel"] = 0;
    objects["Instance194"]["BackgroundColor3"] = Color3.new(1, 0, 0.498039);

    objects["Instance195"]["Parent"] = objects["Instance194"];

    objects["Instance196"]["Parent"] = objects["Instance194"];
    objects["Instance196"]["Transparency"] = 0.5;

    objects["Instance197"]["Rotation"] = 90;
    objects["Instance197"]["Parent"] = objects["Instance194"];
    objects["Instance197"]["Color"] = ColorSequence.new({
    [1] = ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
    [2] = ColorSequenceKeypoint.new(0.5, Color3.new(1, 1, 1)),
    [3] = ColorSequenceKeypoint.new(1, Color3.new(0.784314, 0.784314, 0.784314))
});

    objects["Instance198"]["Visible"] = false;
    objects["Instance198"]["Parent"] = objects["Instance194"];
    objects["Instance198"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance198"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance198"]["BackgroundTransparency"] = 0.75;
    objects["Instance198"]["Position"] = UDim2.new(0, 0, 0.5, 0);
    objects["Instance198"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance198"]["ZIndex"] = 53;
    objects["Instance198"]["BorderSizePixel"] = 0;
    objects["Instance198"]["BackgroundColor3"] = Color3.new(1, 0, 0.490196);

    objects["Instance199"]["PaddingTop"] = UDim.new(0, 2);
    objects["Instance199"]["PaddingBottom"] = UDim.new(0, 2);
    objects["Instance199"]["PaddingRight"] = UDim.new(0, 2);
    objects["Instance199"]["PaddingLeft"] = UDim.new(0, 2);
    objects["Instance199"]["Parent"] = objects["Instance198"];

    objects["Instance200"]["Parent"] = objects["Instance198"];
    objects["Instance200"]["AnchorPoint"] = Vector2.new(1, 0);
    objects["Instance200"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance200"]["Name"] = "State";
    objects["Instance200"]["Position"] = UDim2.new(1, 0, 0, 0);
    objects["Instance200"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance200"]["ZIndex"] = 54;
    objects["Instance200"]["BorderSizePixel"] = 0;
    objects["Instance200"]["BackgroundColor3"] = Color3.new(1, 0, 0.490196);

    objects["Instance201"]["Parent"] = objects["Instance200"];

    objects["Instance202"]["TopLeftRadius"] = UDim.new(0, 0);
    objects["Instance202"]["CornerRadius"] = UDim.new(0, 0);
    objects["Instance202"]["Parent"] = objects["Instance200"];
    objects["Instance202"]["BottomRightRadius"] = UDim.new(0, 0);
    objects["Instance202"]["TopRightRadius"] = UDim.new(0, 0);
    objects["Instance202"]["BottomLeftRadius"] = UDim.new(0, 0);

    objects["Instance203"]["TopLeftRadius"] = UDim.new(0, 0);
    objects["Instance203"]["CornerRadius"] = UDim.new(0, 0);
    objects["Instance203"]["Parent"] = objects["Instance198"];
    objects["Instance203"]["BottomRightRadius"] = UDim.new(0, 0);
    objects["Instance203"]["TopRightRadius"] = UDim.new(0, 0);
    objects["Instance203"]["BottomLeftRadius"] = UDim.new(0, 0);

    objects["Instance204"]["Parent"] = objects["Instance198"];

    objects["Instance205"]["Parent"] = objects["Instance198"];
    objects["Instance205"]["AspectRatio"] = 2.0999999046325684;

    objects["Instance206"]["TopLeftRadius"] = UDim.new(0, 3);
    objects["Instance206"]["CornerRadius"] = UDim.new(0, 3);
    objects["Instance206"]["Parent"] = objects["Instance194"];
    objects["Instance206"]["BottomRightRadius"] = UDim.new(0, 3);
    objects["Instance206"]["TopRightRadius"] = UDim.new(0, 3);
    objects["Instance206"]["BottomLeftRadius"] = UDim.new(0, 3);

    objects["Instance207"]["Parent"] = objects["Instance190"];
    objects["Instance207"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance207"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance207"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance207"]["Name"] = "Separator";
    objects["Instance207"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance207"]["Size"] = UDim2.new(1, -20, 0, 1);
    objects["Instance207"]["ZIndex"] = 51;
    objects["Instance207"]["BorderSizePixel"] = 0;
    objects["Instance207"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance208"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance208"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance208"]["ClipsDescendants"] = true;
    objects["Instance208"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance208"]["Text"] = "";
    objects["Instance208"]["BackgroundTransparency"] = 1;
    objects["Instance208"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance208"]["Active"] = false;
    objects["Instance208"]["TextSize"] = 14;
    objects["Instance208"]["Name"] = "Slider";
    objects["Instance208"]["Parent"] = objects["Instance182"];
    objects["Instance208"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance208"]["ZIndex"] = 50;
    objects["Instance208"]["BorderSizePixel"] = 0;
    objects["Instance208"]["Size"] = UDim2.new(1, 0, 0, 50);

    objects["Instance209"]["Parent"] = objects["Instance208"];
    objects["Instance209"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance209"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance209"]["BackgroundTransparency"] = 1;
    objects["Instance209"]["Name"] = "View";
    objects["Instance209"]["Position"] = UDim2.new(0, 15, 0.30000001192092896, 0);
    objects["Instance209"]["Size"] = UDim2.new(1, -30, 0, 16);
    objects["Instance209"]["ZIndex"] = 51;
    objects["Instance209"]["BorderSizePixel"] = 0;
    objects["Instance209"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance210"]["LayoutOrder"] = 1;
    objects["Instance210"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance210"]["Parent"] = objects["Instance209"];
    objects["Instance210"]["ZIndex"] = 52;
    objects["Instance210"]["BorderSizePixel"] = 0;
    objects["Instance210"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance210"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance210"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance210"]["Text"] = "Slider / progress bar";
    objects["Instance210"]["TextSize"] = 14;
    objects["Instance210"]["TextWrap"] = true;
    objects["Instance210"]["TextWrapped"] = true;
    objects["Instance210"]["BackgroundTransparency"] = 1;
    objects["Instance210"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance210"]["Name"] = "Label";
    objects["Instance210"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance210"]["TextScaled"] = true;
    objects["Instance210"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance211"]["Parent"] = objects["Instance209"];
    objects["Instance211"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance211"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance211"]["BackgroundTransparency"] = 0.75;
    objects["Instance211"]["Name"] = "Bar";
    objects["Instance211"]["Position"] = UDim2.new(0.5, 0, 1.649999976158142, 0);
    objects["Instance211"]["Size"] = UDim2.new(1, 0, 0.8999999761581421, 0);
    objects["Instance211"]["ZIndex"] = 52;
    objects["Instance211"]["BorderSizePixel"] = 0;
    objects["Instance211"]["BackgroundColor3"] = Color3.new(0.0666667, 0.0666667, 0.0666667);

    objects["Instance212"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance212"]["Parent"] = objects["Instance211"];
    objects["Instance212"]["TextStrokeTransparency"] = 0;
    objects["Instance212"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance212"]["ZIndex"] = 55;
    objects["Instance212"]["BorderSizePixel"] = 0;
    objects["Instance212"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance212"]["RichText"] = true;
    objects["Instance212"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance212"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance212"]["Text"] = "50 / 100";
    objects["Instance212"]["TextWrap"] = true;
    objects["Instance212"]["TextSize"] = 14;
    objects["Instance212"]["Name"] = "Progress";
    objects["Instance212"]["BackgroundTransparency"] = 1;
    objects["Instance212"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance212"]["TextWrapped"] = true;
    objects["Instance212"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal, true);
    objects["Instance212"]["TextScaled"] = true;
    objects["Instance212"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance213"]["PaddingTop"] = UDim.new(0.0399999991, 1);
    objects["Instance213"]["PaddingBottom"] = UDim.new(0.0500000007, 1);
    objects["Instance213"]["PaddingRight"] = UDim.new(0, 5);
    objects["Instance213"]["PaddingLeft"] = UDim.new(0, 5);
    objects["Instance213"]["Parent"] = objects["Instance212"];

    objects["Instance214"]["Parent"] = objects["Instance211"];
    objects["Instance214"]["Transparency"] = 0.5;

    objects["Instance215"]["Visible"] = false;
    objects["Instance215"]["Parent"] = objects["Instance211"];
    objects["Instance215"]["BackgroundTransparency"] = 1;
    objects["Instance215"]["Name"] = "Style";
    objects["Instance215"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance215"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance215"]["ZIndex"] = 54;
    objects["Instance215"]["BorderSizePixel"] = 0;
    objects["Instance215"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance216"]["BackgroundTransparency"] = 0.800000011920929;
    objects["Instance216"]["Name"] = "Shine";
    objects["Instance216"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance216"]["Parent"] = objects["Instance215"];
    objects["Instance216"]["Size"] = UDim2.new(1, 0, 0.5, 0);
    objects["Instance216"]["BorderSizePixel"] = 0;
    objects["Instance216"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance217"]["Rotation"] = 90;
    objects["Instance217"]["Transparency"] = NumberSequence.new({
    [1] = NumberSequenceKeypoint.new(0, 1, 0),
    [2] = NumberSequenceKeypoint.new(1, 0, 0)
});
    objects["Instance217"]["Parent"] = objects["Instance216"];

    objects["Instance218"]["Parent"] = objects["Instance215"];
    objects["Instance218"]["AnchorPoint"] = Vector2.new(0, 1);
    objects["Instance218"]["BackgroundTransparency"] = 0.8999999761581421;
    objects["Instance218"]["Name"] = "Shadow";
    objects["Instance218"]["Position"] = UDim2.new(0, 0, 1, 0);
    objects["Instance218"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance218"]["Size"] = UDim2.new(1, 0, 0.5, 0);
    objects["Instance218"]["BorderSizePixel"] = 0;
    objects["Instance218"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance219"]["Rotation"] = -90;
    objects["Instance219"]["Transparency"] = NumberSequence.new({
    [1] = NumberSequenceKeypoint.new(0, 1, 0),
    [2] = NumberSequenceKeypoint.new(1, 0, 0)
});
    objects["Instance219"]["Parent"] = objects["Instance218"];

    objects["Instance220"]["Visible"] = false;
    objects["Instance220"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance220"]["Active"] = false;
    objects["Instance220"]["Parent"] = objects["Instance211"];
    objects["Instance220"]["TextStrokeTransparency"] = 0;
    objects["Instance220"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance220"]["ZIndex"] = 55;
    objects["Instance220"]["BorderSizePixel"] = 0;
    objects["Instance220"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance220"]["RichText"] = true;
    objects["Instance220"]["TextSize"] = 14;
    objects["Instance220"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance220"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance220"]["Text"] = "1488";
    objects["Instance220"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance220"]["Selectable"] = false;
    objects["Instance220"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal, true);
    objects["Instance220"]["TextWrapped"] = true;
    objects["Instance220"]["BackgroundTransparency"] = 1;
    objects["Instance220"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance220"]["Name"] = "InputProgress";
    objects["Instance220"]["ClearTextOnFocus"] = false;
    objects["Instance220"]["TextScaled"] = true;
    objects["Instance220"]["TextWrap"] = true;

    objects["Instance221"]["PaddingTop"] = UDim.new(0.0399999991, 1);
    objects["Instance221"]["PaddingBottom"] = UDim.new(0.0500000007, 1);
    objects["Instance221"]["PaddingRight"] = UDim.new(0, 5);
    objects["Instance221"]["PaddingLeft"] = UDim.new(0, 5);
    objects["Instance221"]["Parent"] = objects["Instance220"];

    objects["Instance222"]["TopLeftRadius"] = UDim.new(0, 3);
    objects["Instance222"]["CornerRadius"] = UDim.new(0, 3);
    objects["Instance222"]["Parent"] = objects["Instance211"];
    objects["Instance222"]["BottomRightRadius"] = UDim.new(0, 3);
    objects["Instance222"]["TopRightRadius"] = UDim.new(0, 3);
    objects["Instance222"]["BottomLeftRadius"] = UDim.new(0, 3);

    objects["Instance223"]["ClipsDescendants"] = true;
    objects["Instance223"]["Parent"] = objects["Instance211"];
    objects["Instance223"]["AnchorPoint"] = Vector2.new(1, 0);
    objects["Instance223"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance223"]["Name"] = "Fill";
    objects["Instance223"]["Position"] = UDim2.new(0.5, 0, 0, 0);
    objects["Instance223"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance223"]["ZIndex"] = 53;
    objects["Instance223"]["BorderSizePixel"] = 0;
    objects["Instance223"]["BackgroundColor3"] = Color3.new(1, 0, 0.490196);

    objects["Instance224"]["TopLeftRadius"] = UDim.new(0, 3);
    objects["Instance224"]["CornerRadius"] = UDim.new(0, 3);
    objects["Instance224"]["Parent"] = objects["Instance223"];
    objects["Instance224"]["BottomRightRadius"] = UDim.new(0, 3);
    objects["Instance224"]["TopRightRadius"] = UDim.new(0, 3);
    objects["Instance224"]["BottomLeftRadius"] = UDim.new(0, 3);

    objects["Instance225"]["Parent"] = objects["Instance208"];
    objects["Instance225"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance225"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance225"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance225"]["Name"] = "Separator";
    objects["Instance225"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance225"]["Size"] = UDim2.new(1, -20, 0, 1);
    objects["Instance225"]["ZIndex"] = 51;
    objects["Instance225"]["BorderSizePixel"] = 0;
    objects["Instance225"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance226"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance226"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance226"]["ClipsDescendants"] = true;
    objects["Instance226"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance226"]["Text"] = "";
    objects["Instance226"]["BackgroundTransparency"] = 1;
    objects["Instance226"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance226"]["Active"] = false;
    objects["Instance226"]["TextSize"] = 14;
    objects["Instance226"]["Name"] = "TextBox";
    objects["Instance226"]["Parent"] = objects["Instance182"];
    objects["Instance226"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance226"]["ZIndex"] = 50;
    objects["Instance226"]["BorderSizePixel"] = 0;
    objects["Instance226"]["Size"] = UDim2.new(1, 0, 0, 50);

    objects["Instance227"]["Parent"] = objects["Instance226"];
    objects["Instance227"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance227"]["BackgroundTransparency"] = 1;
    objects["Instance227"]["Name"] = "View";
    objects["Instance227"]["Position"] = UDim2.new(0, 15, 0, 8);
    objects["Instance227"]["Size"] = UDim2.new(1, -30, 0, 16);
    objects["Instance227"]["ZIndex"] = 51;
    objects["Instance227"]["BorderSizePixel"] = 0;
    objects["Instance227"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance228"]["LayoutOrder"] = 1;
    objects["Instance228"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance228"]["Parent"] = objects["Instance227"];
    objects["Instance228"]["ZIndex"] = 53;
    objects["Instance228"]["BorderSizePixel"] = 0;
    objects["Instance228"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance228"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance228"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance228"]["Text"] = "TextBox";
    objects["Instance228"]["TextSize"] = 14;
    objects["Instance228"]["TextWrap"] = true;
    objects["Instance228"]["TextWrapped"] = true;
    objects["Instance228"]["BackgroundTransparency"] = 1;
    objects["Instance228"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance228"]["Name"] = "Label";
    objects["Instance228"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance228"]["TextScaled"] = true;
    objects["Instance228"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance229"]["FontFace"] = Font.new("rbxasset://fonts/families/LegacyArial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal, true);
    objects["Instance229"]["Active"] = false;
    objects["Instance229"]["Parent"] = objects["Instance227"];
    objects["Instance229"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance229"]["PlaceholderColor3"] = Color3.new(1, 1, 1);
    objects["Instance229"]["ZIndex"] = 53;
    objects["Instance229"]["BorderSizePixel"] = 0;
    objects["Instance229"]["Size"] = UDim2.new(1, 0, 0, 14);
    objects["Instance229"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance229"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance229"]["Text"] = "";
    objects["Instance229"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance229"]["BackgroundColor3"] = Color3.new(0, 0, 0);
    objects["Instance229"]["Selectable"] = false;
    objects["Instance229"]["TextWrapped"] = true;
    objects["Instance229"]["BackgroundTransparency"] = 0.75;
    objects["Instance229"]["Position"] = UDim2.new(0.5, 0, 0, 20);
    objects["Instance229"]["ClearTextOnFocus"] = false;
    objects["Instance229"]["TextYAlignment"] = Enum.TextYAlignment.Top;
    objects["Instance229"]["Name"] = "Bar";
    objects["Instance229"]["TextWrap"] = true;

    objects["Instance230"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance230"]["Transparency"] = 0.4000000059604645;
    objects["Instance230"]["Parent"] = objects["Instance229"];

    objects["Instance231"]["Parent"] = objects["Instance229"];
    objects["Instance231"]["PaddingTop"] = UDim.new(0, 1);
    objects["Instance231"]["PaddingLeft"] = UDim.new(0, 10);
    objects["Instance231"]["PaddingRight"] = UDim.new(0, 10);

    objects["Instance232"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance232"]["Parent"] = objects["Instance229"];
    objects["Instance232"]["ZIndex"] = 54;
    objects["Instance232"]["BorderSizePixel"] = 0;
    objects["Instance232"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance232"]["RichText"] = true;
    objects["Instance232"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance232"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance232"]["Text"] = "Placeholder text...";
    objects["Instance232"]["TextSize"] = 14;
    objects["Instance232"]["TextWrap"] = true;
    objects["Instance232"]["Name"] = "Placeholder";
    objects["Instance232"]["TextWrapped"] = true;
    objects["Instance232"]["BackgroundTransparency"] = 1;
    objects["Instance232"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance232"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal, true);
    objects["Instance232"]["TextYAlignment"] = Enum.TextYAlignment.Top;
    objects["Instance232"]["TextScaled"] = true;
    objects["Instance232"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance233"]["Parent"] = objects["Instance232"];
    objects["Instance233"]["PaddingBottom"] = UDim.new(0, 1);

    objects["Instance234"]["TopLeftRadius"] = UDim.new(0, 3);
    objects["Instance234"]["CornerRadius"] = UDim.new(0, 3);
    objects["Instance234"]["Parent"] = objects["Instance229"];
    objects["Instance234"]["BottomRightRadius"] = UDim.new(0, 3);
    objects["Instance234"]["TopRightRadius"] = UDim.new(0, 3);
    objects["Instance234"]["BottomLeftRadius"] = UDim.new(0, 3);

    objects["Instance235"]["FontSize"] = Enum.FontSize.Size12;
    objects["Instance235"]["Parent"] = objects["Instance227"];
    objects["Instance235"]["ZIndex"] = 53;
    objects["Instance235"]["BorderSizePixel"] = 0;
    objects["Instance235"]["Size"] = UDim2.new(1, 0, 100, 0);
    objects["Instance235"]["RichText"] = true;
    objects["Instance235"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance235"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance235"]["Text"] = "";
    objects["Instance235"]["TextSize"] = 12;
    objects["Instance235"]["TextWrap"] = true;
    objects["Instance235"]["Name"] = "BarInvisible";
    objects["Instance235"]["TextWrapped"] = true;
    objects["Instance235"]["BackgroundTransparency"] = 1;
    objects["Instance235"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance235"]["TextTransparency"] = 1;
    objects["Instance235"]["TextYAlignment"] = Enum.TextYAlignment.Top;
    objects["Instance235"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance235"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance236"]["Parent"] = objects["Instance235"];
    objects["Instance236"]["PaddingTop"] = UDim.new(0, 1);
    objects["Instance236"]["PaddingLeft"] = UDim.new(0, 10);
    objects["Instance236"]["PaddingRight"] = UDim.new(0, 10);

    objects["Instance237"]["Parent"] = objects["Instance226"];
    objects["Instance237"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance237"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance237"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance237"]["Name"] = "Separator";
    objects["Instance237"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance237"]["Size"] = UDim2.new(1, -20, 0, 1);
    objects["Instance237"]["ZIndex"] = 51;
    objects["Instance237"]["BorderSizePixel"] = 0;
    objects["Instance237"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance238"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance238"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance238"]["ClipsDescendants"] = true;
    objects["Instance238"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance238"]["Text"] = "";
    objects["Instance238"]["BackgroundTransparency"] = 1;
    objects["Instance238"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance238"]["Active"] = false;
    objects["Instance238"]["TextSize"] = 14;
    objects["Instance238"]["Name"] = "Dropdown";
    objects["Instance238"]["Parent"] = objects["Instance182"];
    objects["Instance238"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance238"]["ZIndex"] = 50;
    objects["Instance238"]["BorderSizePixel"] = 0;
    objects["Instance238"]["Size"] = UDim2.new(1, 0, 0, 50);

    objects["Instance239"]["Parent"] = objects["Instance238"];
    objects["Instance239"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance239"]["BackgroundTransparency"] = 1;
    objects["Instance239"]["Name"] = "View";
    objects["Instance239"]["Position"] = UDim2.new(0, 15, 0, 8);
    objects["Instance239"]["Size"] = UDim2.new(1, -30, 0, 16);
    objects["Instance239"]["ZIndex"] = 51;
    objects["Instance239"]["BorderSizePixel"] = 0;
    objects["Instance239"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance240"]["Parent"] = objects["Instance239"];
    objects["Instance240"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance240"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance240"]["BackgroundTransparency"] = 1;
    objects["Instance240"]["Name"] = "Label";
    objects["Instance240"]["Position"] = UDim2.new(0.5, 0, 0, 0);
    objects["Instance240"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance240"]["ZIndex"] = 52;
    objects["Instance240"]["BorderSizePixel"] = 0;
    objects["Instance240"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance241"]["Parent"] = objects["Instance240"];
    objects["Instance241"]["BackgroundTransparency"] = 1;
    objects["Instance241"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance241"]["Image"] = "rbxassetid://12338895277";
    objects["Instance241"]["Name"] = "Icon";
    objects["Instance241"]["Size"] = UDim2.new(1, 0, 0.8999999761581421, 0);
    objects["Instance241"]["ImageContent"] = Content.fromUri("rbxassetid://12338895277");
    objects["Instance241"]["ZIndex"] = 53;
    objects["Instance241"]["BorderSizePixel"] = 0;
    objects["Instance241"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance242"]["Parent"] = objects["Instance241"];
    objects["Instance242"]["AspectRatio"] = 0.9750000238418579;

    objects["Instance243"]["Visible"] = false;
    objects["Instance243"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance243"]["Parent"] = objects["Instance241"];
    objects["Instance243"]["BackgroundTransparency"] = 1;
    objects["Instance243"]["Rotation"] = 90;
    objects["Instance243"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance243"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance243"]["Image"] = "rbxassetid://12338895277";
    objects["Instance243"]["Name"] = "Opened";
    objects["Instance243"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance243"]["ImageContent"] = Content.fromUri("rbxassetid://12338895277");
    objects["Instance243"]["ZIndex"] = 54;
    objects["Instance243"]["BorderSizePixel"] = 0;
    objects["Instance243"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance244"]["Parent"] = objects["Instance243"];
    objects["Instance244"]["AspectRatio"] = 0.9750000238418579;

    objects["Instance245"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    objects["Instance245"]["FillDirection"] = Enum.FillDirection.Horizontal;
    objects["Instance245"]["Parent"] = objects["Instance240"];
    objects["Instance245"]["Padding"] = UDim.new(0, 5);
    objects["Instance245"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance246"]["LayoutOrder"] = 1;
    objects["Instance246"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance246"]["Parent"] = objects["Instance240"];
    objects["Instance246"]["ZIndex"] = 53;
    objects["Instance246"]["BorderSizePixel"] = 0;
    objects["Instance246"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance246"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance246"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance246"]["Text"] = "Dropdown";
    objects["Instance246"]["TextSize"] = 14;
    objects["Instance246"]["TextWrap"] = true;
    objects["Instance246"]["TextWrapped"] = true;
    objects["Instance246"]["BackgroundTransparency"] = 1;
    objects["Instance246"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance246"]["Name"] = "Label";
    objects["Instance246"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance246"]["TextScaled"] = true;
    objects["Instance246"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance247"]["Parent"] = objects["Instance239"];
    objects["Instance247"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance247"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance247"]["BackgroundTransparency"] = 0.75;
    objects["Instance247"]["Name"] = "List";
    objects["Instance247"]["Position"] = UDim2.new(0.5, 0, 0, 20);
    objects["Instance247"]["Size"] = UDim2.new(1, 0, 0, 14);
    objects["Instance247"]["ZIndex"] = 52;
    objects["Instance247"]["BorderSizePixel"] = 0;
    objects["Instance247"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance248"]["BackgroundTransparency"] = 1;
    objects["Instance248"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance248"]["Name"] = "Selected";
    objects["Instance248"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance248"]["Parent"] = objects["Instance247"];
    objects["Instance248"]["ZIndex"] = 53;
    objects["Instance248"]["BorderSizePixel"] = 0;
    objects["Instance248"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance249"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal, true);
    objects["Instance249"]["TextTransparency"] = 0.3499999940395355;
    objects["Instance249"]["TextStrokeTransparency"] = 0;
    objects["Instance249"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance249"]["ZIndex"] = 55;
    objects["Instance249"]["BorderSizePixel"] = 0;
    objects["Instance249"]["Size"] = UDim2.new(100, 0, 0.8999999761581421, 0);
    objects["Instance249"]["TextColor3"] = Color3.new(1, 0, 0.498039);
    objects["Instance249"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance249"]["Text"] = "DEFAULT VALUE";
    objects["Instance249"]["TextWrap"] = true;
    objects["Instance249"]["TextSize"] = 14;
    objects["Instance249"]["Name"] = "Value";
    objects["Instance249"]["TextWrapped"] = true;
    objects["Instance249"]["BackgroundTransparency"] = 1;
    objects["Instance249"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance249"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance249"]["Parent"] = objects["Instance248"];
    objects["Instance249"]["TextScaled"] = true;
    objects["Instance249"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance250"]["Parent"] = objects["Instance249"];
    objects["Instance250"]["PaddingTop"] = UDim.new(0, 1);

    objects["Instance251"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance251"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance251"]["Name"] = "Gradient";
    objects["Instance251"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance251"]["Parent"] = objects["Instance248"];
    objects["Instance251"]["ZIndex"] = 54;
    objects["Instance251"]["BorderSizePixel"] = 0;
    objects["Instance251"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance252"]["Rotation"] = 90;
    objects["Instance252"]["Transparency"] = NumberSequence.new({
    [1] = NumberSequenceKeypoint.new(0, 1, 0),
    [2] = NumberSequenceKeypoint.new(1, 0, 0)
});
    objects["Instance252"]["Parent"] = objects["Instance251"];

    objects["Instance253"]["Visible"] = false;
    objects["Instance253"]["Parent"] = objects["Instance247"];
    objects["Instance253"]["BackgroundTransparency"] = 1;
    objects["Instance253"]["Name"] = "List";
    objects["Instance253"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance253"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance253"]["ZIndex"] = 53;
    objects["Instance253"]["BorderSizePixel"] = 0;
    objects["Instance253"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance254"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance254"]["Active"] = false;
    objects["Instance254"]["Parent"] = objects["Instance253"];
    objects["Instance254"]["TextStrokeTransparency"] = 0;
    objects["Instance254"]["ZIndex"] = 64;
    objects["Instance254"]["BorderSizePixel"] = 0;
    objects["Instance254"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance254"]["ClipsDescendants"] = true;
    objects["Instance254"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance254"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance254"]["BackgroundTransparency"] = 1;
    objects["Instance254"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance254"]["Name"] = "Row";
    objects["Instance254"]["TextWrapped"] = true;
    objects["Instance254"]["TextSize"] = 14;
    objects["Instance254"]["FontFace"] = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal, true);
    objects["Instance254"]["TextScaled"] = true;
    objects["Instance254"]["TextWrap"] = true;

    objects["Instance255"]["Parent"] = objects["Instance253"];
    objects["Instance255"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance256"]["Visible"] = false;
    objects["Instance256"]["TextWrapped"] = true;
    objects["Instance256"]["TextWrap"] = true;
    objects["Instance256"]["TextColor3"] = Color3.new(1, 0, 0.498039);
    objects["Instance256"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance256"]["Text"] = "NO ELEMENTS";
    objects["Instance256"]["Name"] = "NoContents";
    objects["Instance256"]["TextStrokeTransparency"] = 0;
    objects["Instance256"]["Parent"] = objects["Instance247"];
    objects["Instance256"]["FontFace"] = Font.new("rbxasset://fonts/families/LegacyArial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal, true);
    objects["Instance256"]["BackgroundTransparency"] = 1;
    objects["Instance256"]["TextScaled"] = true;
    objects["Instance256"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance256"]["ZIndex"] = 53;
    objects["Instance256"]["BorderSizePixel"] = 0;
    objects["Instance256"]["BackgroundColor3"] = Color3.new(0.972549, 0.972549, 0.972549);

    objects["Instance257"]["Parent"] = objects["Instance256"];
    objects["Instance257"]["PaddingTop"] = UDim.new(0, 1);
    objects["Instance257"]["PaddingBottom"] = UDim.new(0, 1);

    objects["Instance258"]["Parent"] = objects["Instance247"];
    objects["Instance258"]["Transparency"] = 0.5;

    objects["Instance259"]["TopLeftRadius"] = UDim.new(0, 3);
    objects["Instance259"]["CornerRadius"] = UDim.new(0, 3);
    objects["Instance259"]["Parent"] = objects["Instance247"];
    objects["Instance259"]["BottomRightRadius"] = UDim.new(0, 3);
    objects["Instance259"]["TopRightRadius"] = UDim.new(0, 3);
    objects["Instance259"]["BottomLeftRadius"] = UDim.new(0, 3);

    objects["Instance260"]["Parent"] = objects["Instance238"];
    objects["Instance260"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance260"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance260"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance260"]["Name"] = "Separator";
    objects["Instance260"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance260"]["Size"] = UDim2.new(1, -20, 0, 1);
    objects["Instance260"]["ZIndex"] = 51;
    objects["Instance260"]["BorderSizePixel"] = 0;
    objects["Instance260"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance261"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance261"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance261"]["ClipsDescendants"] = true;
    objects["Instance261"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance261"]["Text"] = "";
    objects["Instance261"]["BackgroundTransparency"] = 1;
    objects["Instance261"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance261"]["Active"] = false;
    objects["Instance261"]["TextSize"] = 14;
    objects["Instance261"]["Name"] = "Input";
    objects["Instance261"]["Parent"] = objects["Instance182"];
    objects["Instance261"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance261"]["ZIndex"] = 50;
    objects["Instance261"]["BorderSizePixel"] = 0;
    objects["Instance261"]["Size"] = UDim2.new(1, 0, 0, 40);

    objects["Instance262"]["Parent"] = objects["Instance261"];
    objects["Instance262"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance262"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance262"]["BackgroundTransparency"] = 1;
    objects["Instance262"]["Name"] = "View";
    objects["Instance262"]["Position"] = UDim2.new(0, 15, 0.5, 0);
    objects["Instance262"]["Size"] = UDim2.new(100, 0, 0, 16);
    objects["Instance262"]["ZIndex"] = 51;
    objects["Instance262"]["BorderSizePixel"] = 0;
    objects["Instance262"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance263"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    objects["Instance263"]["FillDirection"] = Enum.FillDirection.Horizontal;
    objects["Instance263"]["Parent"] = objects["Instance262"];
    objects["Instance263"]["Padding"] = UDim.new(0, 7);
    objects["Instance263"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance264"]["LayoutOrder"] = 1;
    objects["Instance264"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance264"]["Parent"] = objects["Instance262"];
    objects["Instance264"]["ZIndex"] = 52;
    objects["Instance264"]["BorderSizePixel"] = 0;
    objects["Instance264"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance264"]["RichText"] = true;
    objects["Instance264"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance264"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance264"]["Text"] = "InputBox";
    objects["Instance264"]["TextSize"] = 14;
    objects["Instance264"]["TextWrap"] = true;
    objects["Instance264"]["TextWrapped"] = true;
    objects["Instance264"]["BackgroundTransparency"] = 1;
    objects["Instance264"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance264"]["Name"] = "Label";
    objects["Instance264"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance264"]["TextScaled"] = true;
    objects["Instance264"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance265"]["TextWrapped"] = true;
    objects["Instance265"]["TextColor3"] = Color3.new(1, 0, 0.498039);
    objects["Instance265"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance265"]["Text"] = "LShift";
    objects["Instance265"]["TextWrap"] = true;
    objects["Instance265"]["Name"] = "Display";
    objects["Instance265"]["Parent"] = objects["Instance262"];
    objects["Instance265"]["BackgroundTransparency"] = 0.75;
    objects["Instance265"]["TextScaled"] = true;
    objects["Instance265"]["Size"] = UDim2.new(1.25, 0, 1.25, 0);
    objects["Instance265"]["ZIndex"] = 52;
    objects["Instance265"]["BorderSizePixel"] = 0;
    objects["Instance265"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance266"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance266"]["Transparency"] = 0.3499999940395355;
    objects["Instance266"]["Parent"] = objects["Instance265"];

    objects["Instance267"]["PaddingTop"] = UDim.new(0, 3);
    objects["Instance267"]["PaddingBottom"] = UDim.new(0, 3);
    objects["Instance267"]["PaddingRight"] = UDim.new(0, 3);
    objects["Instance267"]["PaddingLeft"] = UDim.new(0, 3);
    objects["Instance267"]["Parent"] = objects["Instance265"];

    objects["Instance268"]["Parent"] = objects["Instance265"];
    objects["Instance268"]["AspectRatio"] = 3;

    objects["Instance269"]["TopLeftRadius"] = UDim.new(0, 3);
    objects["Instance269"]["CornerRadius"] = UDim.new(0, 3);
    objects["Instance269"]["Parent"] = objects["Instance265"];
    objects["Instance269"]["BottomRightRadius"] = UDim.new(0, 3);
    objects["Instance269"]["TopRightRadius"] = UDim.new(0, 3);
    objects["Instance269"]["BottomLeftRadius"] = UDim.new(0, 3);

    objects["Instance270"]["Parent"] = objects["Instance261"];
    objects["Instance270"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance270"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance270"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance270"]["Name"] = "Separator";
    objects["Instance270"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance270"]["Size"] = UDim2.new(1, -20, 0, 1);
    objects["Instance270"]["ZIndex"] = 51;
    objects["Instance270"]["BorderSizePixel"] = 0;
    objects["Instance270"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance271"]["ClipsDescendants"] = true;
    objects["Instance271"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance271"]["TextTransparency"] = 1;
    objects["Instance271"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance271"]["BackgroundTransparency"] = 1;
    objects["Instance271"]["Name"] = "Label";
    objects["Instance271"]["Active"] = false;
    objects["Instance271"]["Parent"] = objects["Instance182"];
    objects["Instance271"]["ZIndex"] = 50;
    objects["Instance271"]["BorderSizePixel"] = 0;
    objects["Instance271"]["Size"] = UDim2.new(1, 0, 0, 40);

    objects["Instance272"]["Parent"] = objects["Instance271"];
    objects["Instance272"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance272"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance272"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance272"]["Name"] = "Separator";
    objects["Instance272"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance272"]["Size"] = UDim2.new(1, -20, 0, 1);
    objects["Instance272"]["ZIndex"] = 51;
    objects["Instance272"]["BorderSizePixel"] = 0;
    objects["Instance272"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance273"]["LayoutOrder"] = 1;
    objects["Instance273"]["FontSize"] = Enum.FontSize.Size18;
    objects["Instance273"]["Parent"] = objects["Instance271"];
    objects["Instance273"]["ZIndex"] = 51;
    objects["Instance273"]["BorderSizePixel"] = 0;
    objects["Instance273"]["Size"] = UDim2.new(1, -30, 0, 16);
    objects["Instance273"]["RichText"] = true;
    objects["Instance273"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance273"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance273"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance273"]["TextWrap"] = true;
    objects["Instance273"]["TextWrapped"] = true;
    objects["Instance273"]["TextSize"] = 16;
    objects["Instance273"]["BackgroundTransparency"] = 1;
    objects["Instance273"]["Position"] = UDim2.new(0, 15, 0, 12);
    objects["Instance273"]["Name"] = "Label";
    objects["Instance273"]["TextYAlignment"] = Enum.TextYAlignment.Top;
    objects["Instance273"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance273"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance274"]["Parent"] = objects["Instance271"];
    objects["Instance274"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance274"]["AnchorPoint"] = Vector2.new(1, 0);
    objects["Instance274"]["BackgroundTransparency"] = 1;
    objects["Instance274"]["Name"] = "ColorPickers";
    objects["Instance274"]["Position"] = UDim2.new(1, -10, 0, 0);
    objects["Instance274"]["Size"] = UDim2.new(1, -20, 1, 0);
    objects["Instance274"]["ZIndex"] = 51;
    objects["Instance274"]["BorderSizePixel"] = 0;
    objects["Instance274"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance275"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance275"]["Active"] = false;
    objects["Instance275"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance275"]["Text"] = "";
    objects["Instance275"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance275"]["BackgroundTransparency"] = 1;
    objects["Instance275"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance275"]["TextSize"] = 14;
    objects["Instance275"]["Name"] = "Picker";
    objects["Instance275"]["Parent"] = objects["Instance274"];
    objects["Instance275"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance275"]["ZIndex"] = 52;
    objects["Instance275"]["BorderSizePixel"] = 0;
    objects["Instance275"]["Size"] = UDim2.new(1, 0, 1, 0);

    objects["Instance276"]["Parent"] = objects["Instance275"];
    objects["Instance276"]["AspectRatio"] = 0.5;

    objects["Instance277"]["LayoutOrder"] = 1;
    objects["Instance277"]["Parent"] = objects["Instance275"];
    objects["Instance277"]["AnchorPoint"] = Vector2.new(1, 0.5);
    objects["Instance277"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance277"]["Name"] = "Display";
    objects["Instance277"]["Position"] = UDim2.new(1, -1, 0.5, 0);
    objects["Instance277"]["Size"] = UDim2.new(1, 0, 0.3499999940395355, 0);
    objects["Instance277"]["ZIndex"] = 53;
    objects["Instance277"]["BorderSizePixel"] = 0;
    objects["Instance277"]["BackgroundColor3"] = Color3.new(1, 0, 0.490196);

    objects["Instance278"]["Thickness"] = 2;
    objects["Instance278"]["Transparency"] = 0.5;
    objects["Instance278"]["Parent"] = objects["Instance277"];
    objects["Instance278"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance278"]["BorderStrokePosition"] = Enum.BorderStrokePosition.Center;

    objects["Instance279"]["Visible"] = false;
    objects["Instance279"]["Parent"] = objects["Instance277"];
    objects["Instance279"]["BackgroundTransparency"] = 0.5;
    objects["Instance279"]["Name"] = "Darker";
    objects["Instance279"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance279"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance279"]["ZIndex"] = 54;
    objects["Instance279"]["BorderSizePixel"] = 0;
    objects["Instance279"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance280"]["TopLeftRadius"] = UDim.new(0, 3);
    objects["Instance280"]["CornerRadius"] = UDim.new(0, 3);
    objects["Instance280"]["Parent"] = objects["Instance277"];
    objects["Instance280"]["BottomRightRadius"] = UDim.new(0, 3);
    objects["Instance280"]["TopRightRadius"] = UDim.new(0, 3);
    objects["Instance280"]["BottomLeftRadius"] = UDim.new(0, 3);

    objects["Instance281"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    objects["Instance281"]["FillDirection"] = Enum.FillDirection.Horizontal;
    objects["Instance281"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right;
    objects["Instance281"]["Parent"] = objects["Instance274"];
    objects["Instance281"]["Padding"] = UDim.new(0, 4);
    objects["Instance281"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance282"]["LayoutOrder"] = 1;
    objects["Instance282"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance282"]["Active"] = false;
    objects["Instance282"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance282"]["Text"] = "";
    objects["Instance282"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance282"]["BackgroundTransparency"] = 1;
    objects["Instance282"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance282"]["TextSize"] = 14;
    objects["Instance282"]["Name"] = "KeybindPicker";
    objects["Instance282"]["Parent"] = objects["Instance274"];
    objects["Instance282"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance282"]["ZIndex"] = 52;
    objects["Instance282"]["BorderSizePixel"] = 0;
    objects["Instance282"]["Size"] = UDim2.new(0.5, 0, 1, 0);

    objects["Instance283"]["Parent"] = objects["Instance282"];
    objects["Instance283"]["AspectRatio"] = 1.649999976158142;

    objects["Instance284"]["LayoutOrder"] = 1;
    objects["Instance284"]["TextWrapped"] = true;
    objects["Instance284"]["TextWrap"] = true;
    objects["Instance284"]["TextColor3"] = Color3.new(1, 0, 0.498039);
    objects["Instance284"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance284"]["Text"] = "LShift";
    objects["Instance284"]["Name"] = "Display";
    objects["Instance284"]["Parent"] = objects["Instance282"];
    objects["Instance284"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance284"]["TextScaled"] = true;
    objects["Instance284"]["BackgroundTransparency"] = 0.75;
    objects["Instance284"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance284"]["Size"] = UDim2.new(1, 0, 0.5, 0);
    objects["Instance284"]["ZIndex"] = 52;
    objects["Instance284"]["BorderSizePixel"] = 0;
    objects["Instance284"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance285"]["PaddingTop"] = UDim.new(0, 3);
    objects["Instance285"]["PaddingBottom"] = UDim.new(0, 3);
    objects["Instance285"]["PaddingRight"] = UDim.new(0, 3);
    objects["Instance285"]["PaddingLeft"] = UDim.new(0, 3);
    objects["Instance285"]["Parent"] = objects["Instance284"];

    objects["Instance286"]["TopLeftRadius"] = UDim.new(0, 3);
    objects["Instance286"]["CornerRadius"] = UDim.new(0, 3);
    objects["Instance286"]["Parent"] = objects["Instance284"];
    objects["Instance286"]["BottomRightRadius"] = UDim.new(0, 3);
    objects["Instance286"]["TopRightRadius"] = UDim.new(0, 3);
    objects["Instance286"]["BottomLeftRadius"] = UDim.new(0, 3);

    objects["Instance287"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance287"]["Transparency"] = 0.3499999940395355;
    objects["Instance287"]["Parent"] = objects["Instance284"];

    objects["Instance288"]["Visible"] = false;
    objects["Instance288"]["ClipsDescendants"] = true;
    objects["Instance288"]["Selectable"] = false;
    objects["Instance288"]["TextTransparency"] = 1;
    objects["Instance288"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance288"]["BackgroundTransparency"] = 1;
    objects["Instance288"]["Active"] = false;
    objects["Instance288"]["Name"] = "Separator";
    objects["Instance288"]["Parent"] = objects["Instance182"];
    objects["Instance288"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance288"]["ZIndex"] = 50;
    objects["Instance288"]["BorderSizePixel"] = 0;
    objects["Instance288"]["Size"] = UDim2.new(1, 0, 0, 10);

    objects["Instance289"]["Parent"] = objects["Instance288"];
    objects["Instance289"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance289"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance289"]["BackgroundTransparency"] = 0.75;
    objects["Instance289"]["Name"] = "SeparatorMiddle";
    objects["Instance289"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance289"]["Size"] = UDim2.new(1, -20, 0, 1);
    objects["Instance289"]["ZIndex"] = 51;
    objects["Instance289"]["BorderSizePixel"] = 0;
    objects["Instance289"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance290"]["Parent"] = objects["Instance288"];
    objects["Instance290"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance290"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance290"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance290"]["Name"] = "Separator";
    objects["Instance290"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance290"]["Size"] = UDim2.new(1, -20, 0, 1);
    objects["Instance290"]["ZIndex"] = 51;
    objects["Instance290"]["BorderSizePixel"] = 0;
    objects["Instance290"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance291"]["Parent"] = objects["Instance182"];
    objects["Instance291"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance292"]["ClipsDescendants"] = true;
    objects["Instance292"]["Selectable"] = false;
    objects["Instance292"]["TextTransparency"] = 1;
    objects["Instance292"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance292"]["BackgroundTransparency"] = 1;
    objects["Instance292"]["Active"] = false;
    objects["Instance292"]["Name"] = "Header";
    objects["Instance292"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance292"]["Parent"] = objects["Instance182"];
    objects["Instance292"]["ZIndex"] = 50;
    objects["Instance292"]["BorderSizePixel"] = 0;
    objects["Instance292"]["Size"] = UDim2.new(1, 0, 0, 18);

    objects["Instance293"]["ClipsDescendants"] = true;
    objects["Instance293"]["Parent"] = objects["Instance292"];
    objects["Instance293"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance293"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance293"]["BackgroundTransparency"] = 1;
    objects["Instance293"]["Name"] = "View";
    objects["Instance293"]["Position"] = UDim2.new(0.5, 0, 0, 1);
    objects["Instance293"]["Size"] = UDim2.new(1, -20, 1, -2);
    objects["Instance293"]["ZIndex"] = 51;
    objects["Instance293"]["BorderSizePixel"] = 0;
    objects["Instance293"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance294"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    objects["Instance294"]["FillDirection"] = Enum.FillDirection.Horizontal;
    objects["Instance294"]["Parent"] = objects["Instance293"];
    objects["Instance294"]["Padding"] = UDim.new(0, 5);
    objects["Instance294"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance295"]["Parent"] = objects["Instance293"];
    objects["Instance295"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance295"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance295"]["BackgroundTransparency"] = 0.75;
    objects["Instance295"]["Name"] = "Left";
    objects["Instance295"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance295"]["Size"] = UDim2.new(0, 10, 0, 1);
    objects["Instance295"]["ZIndex"] = 51;
    objects["Instance295"]["BorderSizePixel"] = 0;
    objects["Instance295"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance296"]["LayoutOrder"] = 1;
    objects["Instance296"]["FontSize"] = Enum.FontSize.Size12;
    objects["Instance296"]["Parent"] = objects["Instance293"];
    objects["Instance296"]["ZIndex"] = 51;
    objects["Instance296"]["BorderSizePixel"] = 0;
    objects["Instance296"]["Size"] = UDim2.new(0, 36, 1, 0);
    objects["Instance296"]["RichText"] = true;
    objects["Instance296"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance296"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance296"]["Text"] = "Header";
    objects["Instance296"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance296"]["TextWrap"] = true;
    objects["Instance296"]["TextWrapped"] = true;
    objects["Instance296"]["TextSize"] = 12;
    objects["Instance296"]["BackgroundTransparency"] = 1;
    objects["Instance296"]["Position"] = UDim2.new(0, 15, 0, 12);
    objects["Instance296"]["Name"] = "Label";
    objects["Instance296"]["TextTransparency"] = 0.6000000238418579;
    objects["Instance296"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance296"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance297"]["LayoutOrder"] = 2;
    objects["Instance297"]["Parent"] = objects["Instance293"];
    objects["Instance297"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance297"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance297"]["BackgroundTransparency"] = 0.75;
    objects["Instance297"]["Name"] = "Right";
    objects["Instance297"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance297"]["Size"] = UDim2.new(1, 0, 0, 1);
    objects["Instance297"]["ZIndex"] = 51;
    objects["Instance297"]["BorderSizePixel"] = 0;
    objects["Instance297"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance298"]["Parent"] = objects["Instance292"];
    objects["Instance298"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance298"]["AnchorPoint"] = Vector2.new(0.5, 1);
    objects["Instance298"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance298"]["Name"] = "Separator";
    objects["Instance298"]["Position"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance298"]["Size"] = UDim2.new(1, -20, 0, 1);
    objects["Instance298"]["ZIndex"] = 51;
    objects["Instance298"]["BorderSizePixel"] = 0;
    objects["Instance298"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance299"]["BackgroundTransparency"] = 1;
    objects["Instance299"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance299"]["Name"] = "CustomPage";
    objects["Instance299"]["Size"] = UDim2.new(1, -1, 1, 0);
    objects["Instance299"]["Parent"] = objects["Instance163"];
    objects["Instance299"]["ZIndex"] = 5;
    objects["Instance299"]["BorderSizePixel"] = 0;
    objects["Instance299"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance300"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance300"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance300"]["Name"] = "PagesDark";
    objects["Instance300"]["Size"] = UDim2.new(1, -1, 1, 0);
    objects["Instance300"]["Parent"] = objects["Instance163"];
    objects["Instance300"]["ZIndex"] = 2;
    objects["Instance300"]["BorderSizePixel"] = 0;
    objects["Instance300"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance301"]["Parent"] = objects["Instance31"];
    objects["Instance301"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance301"]["BackgroundTransparency"] = 1;
    objects["Instance301"]["Name"] = "Corner";
    objects["Instance301"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance301"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance301"]["ZIndex"] = 49;
    objects["Instance301"]["BorderSizePixel"] = 0;
    objects["Instance301"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance302"]["Active"] = false;
    objects["Instance302"]["Selectable"] = false;
    objects["Instance302"]["Text"] = "";
    objects["Instance302"]["BackgroundColor3"] = Color3.new(1, 0, 0.498039);
    objects["Instance302"]["AutoButtonColor"] = false;
    objects["Instance302"]["AnchorPoint"] = Vector2.new(1, 1);
    objects["Instance302"]["Parent"] = objects["Instance301"];
    objects["Instance302"]["Name"] = "Resize";
    objects["Instance302"]["Position"] = UDim2.new(1, 0, 1, 0);
    objects["Instance302"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance302"]["ZIndex"] = 50;
    objects["Instance302"]["BorderSizePixel"] = 0;
    objects["Instance302"]["Size"] = UDim2.new(0, 20, 0, 20);

    objects["Instance303"]["Rotation"] = 45;
    objects["Instance303"]["Transparency"] = NumberSequence.new({
    [1] = NumberSequenceKeypoint.new(0, 1, 0),
    [2] = NumberSequenceKeypoint.new(0.5, 1, 0),
    [3] = NumberSequenceKeypoint.new(0.5009999871253967, 0, 0),
    [4] = NumberSequenceKeypoint.new(1, 0, 0)
});
    objects["Instance303"]["Parent"] = objects["Instance302"];

    objects["Instance304"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance304"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance304"]["Parent"] = objects["Instance301"];
    objects["Instance304"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance304"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance304"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance305"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance305"]["Name"] = "InsideStroke";
    objects["Instance305"]["Color"] = Color3.new(1, 0, 0.498039);
    objects["Instance305"]["ZIndex"] = 999;
    objects["Instance305"]["Parent"] = objects["Instance31"];
    objects["Instance305"]["BorderStrokePosition"] = Enum.BorderStrokePosition.Inner;

    objects["Instance306"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance306"]["ZIndex"] = 999;
    objects["Instance306"]["Name"] = "OutsideStroke";
    objects["Instance306"]["Parent"] = objects["Instance31"];

    objects["Instance307"]["Visible"] = false;
    objects["Instance307"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance307"]["Name"] = "TopNeon";
    objects["Instance307"]["Size"] = UDim2.new(1, 0, 0, 1);
    objects["Instance307"]["Parent"] = objects["Instance31"];
    objects["Instance307"]["ZIndex"] = 3;
    objects["Instance307"]["BorderSizePixel"] = 0;
    objects["Instance307"]["BackgroundColor3"] = Color3.new(1, 0, 0.498039);

    objects["Instance308"]["Visible"] = false;
    objects["Instance308"]["BackgroundColor3"] = Color3.new(0.0784314, 0.0784314, 0.0784314);
    objects["Instance308"]["Active"] = false;
    objects["Instance308"]["Selectable"] = false;
    objects["Instance308"]["Text"] = "";
    objects["Instance308"]["BackgroundTransparency"] = 1;
    objects["Instance308"]["AutoButtonColor"] = false;
    objects["Instance308"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance308"]["Parent"] = objects["Instance31"];
    objects["Instance308"]["Name"] = "Overlay";
    objects["Instance308"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance308"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance308"]["ZIndex"] = 99;
    objects["Instance308"]["BorderSizePixel"] = 0;
    objects["Instance308"]["Size"] = UDim2.new(1, 0, 1, 0);

    objects["Instance309"]["TopLeftRadius"] = UDim.new(0, 0);
    objects["Instance309"]["CornerRadius"] = UDim.new(0, 0);
    objects["Instance309"]["Parent"] = objects["Instance308"];
    objects["Instance309"]["BottomRightRadius"] = UDim.new(0, 0);
    objects["Instance309"]["TopRightRadius"] = UDim.new(0, 0);
    objects["Instance309"]["BottomLeftRadius"] = UDim.new(0, 0);

    objects["Instance310"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance310"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance310"]["Parent"] = objects["Instance31"];
    objects["Instance310"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance310"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance310"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance311"]["Name"] = "Windows";
    objects["Instance311"]["Parent"] = objects["Instance25"];

    objects["Instance312"]["Visible"] = false;
    objects["Instance312"]["TextTransparency"] = 1;
    objects["Instance312"]["Active"] = false;
    objects["Instance312"]["Selectable"] = false;
    objects["Instance312"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance312"]["BackgroundTransparency"] = 1;
    objects["Instance312"]["AutoButtonColor"] = false;
    objects["Instance312"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance312"]["Parent"] = objects["Instance25"];
    objects["Instance312"]["Name"] = "ColorPickerWindow";
    objects["Instance312"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance312"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance312"]["ZIndex"] = 202;
    objects["Instance312"]["BorderSizePixel"] = 0;
    objects["Instance312"]["Size"] = UDim2.new(0.20000000298023224, 350, 0.20000000298023224, 250);

    objects["Instance313"]["Name"] = "Contents";
    objects["Instance313"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance313"]["Parent"] = objects["Instance312"];
    objects["Instance313"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance313"]["BorderSizePixel"] = 0;
    objects["Instance313"]["BackgroundColor3"] = Color3.new(0.0784314, 0.0784314, 0.0784314);

    objects["Instance314"]["ClipsDescendants"] = true;
    objects["Instance314"]["Parent"] = objects["Instance313"];
    objects["Instance314"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance314"]["BackgroundTransparency"] = 1;
    objects["Instance314"]["Name"] = "Contents";
    objects["Instance314"]["Position"] = UDim2.new(0, 0, 0, 1);
    objects["Instance314"]["Size"] = UDim2.new(1, -2, 1, -2);
    objects["Instance314"]["ZIndex"] = 203;
    objects["Instance314"]["BorderSizePixel"] = 0;
    objects["Instance314"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance315"]["Parent"] = objects["Instance314"];
    objects["Instance315"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance315"]["BackgroundTransparency"] = 1;
    objects["Instance315"]["Name"] = "Display";
    objects["Instance315"]["Position"] = UDim2.new(0, 5, 0, 45);
    objects["Instance315"]["Size"] = UDim2.new(1, -10, 1, -50);
    objects["Instance315"]["ZIndex"] = 204;
    objects["Instance315"]["BorderSizePixel"] = 0;
    objects["Instance315"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance316"]["BackgroundTransparency"] = 1;
    objects["Instance316"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance316"]["Name"] = "ColorZone";
    objects["Instance316"]["Size"] = UDim2.new(1, 0, 1, -30);
    objects["Instance316"]["Parent"] = objects["Instance315"];
    objects["Instance316"]["ZIndex"] = 205;
    objects["Instance316"]["BorderSizePixel"] = 0;
    objects["Instance316"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance317"]["ClipsDescendants"] = true;
    objects["Instance317"]["Selectable"] = false;
    objects["Instance317"]["Text"] = "";
    objects["Instance317"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance317"]["AutoButtonColor"] = false;
    objects["Instance317"]["BackgroundTransparency"] = 1;
    objects["Instance317"]["Active"] = false;
    objects["Instance317"]["Name"] = "PickerZone";
    objects["Instance317"]["Parent"] = objects["Instance316"];
    objects["Instance317"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance317"]["ZIndex"] = 206;
    objects["Instance317"]["BorderSizePixel"] = 0;
    objects["Instance317"]["Size"] = UDim2.new(1, -30, 1, 0);

    objects["Instance318"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance318"]["Name"] = "Contents";
    objects["Instance318"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance318"]["Parent"] = objects["Instance317"];
    objects["Instance318"]["ZIndex"] = 206;
    objects["Instance318"]["BorderSizePixel"] = 0;
    objects["Instance318"]["BackgroundColor3"] = Color3.new(1, 0, 0);

    objects["Instance319"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance319"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance319"]["Parent"] = objects["Instance318"];
    objects["Instance319"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance319"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance319"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance320"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance320"]["Name"] = "Black";
    objects["Instance320"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance320"]["Parent"] = objects["Instance318"];
    objects["Instance320"]["ZIndex"] = 208;
    objects["Instance320"]["BorderSizePixel"] = 0;
    objects["Instance320"]["BackgroundColor3"] = Color3.new(0, 0, 0);

    objects["Instance321"]["Rotation"] = -90;
    objects["Instance321"]["Transparency"] = NumberSequence.new({
    [1] = NumberSequenceKeypoint.new(0, 0, 0),
    [2] = NumberSequenceKeypoint.new(1, 1, 0)
});
    objects["Instance321"]["Parent"] = objects["Instance320"];

    objects["Instance322"]["Parent"] = objects["Instance318"];
    objects["Instance322"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance322"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance322"]["BackgroundTransparency"] = 0.25;
    objects["Instance322"]["Name"] = "Cursor";
    objects["Instance322"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance322"]["Size"] = UDim2.new(0, 5, 0, 5);
    objects["Instance322"]["ZIndex"] = 209;
    objects["Instance322"]["BorderSizePixel"] = 0;
    objects["Instance322"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance323"]["Thickness"] = 2;
    objects["Instance323"]["ZIndex"] = 210;
    objects["Instance323"]["Parent"] = objects["Instance322"];
    objects["Instance323"]["Transparency"] = 0.5;

    objects["Instance324"]["Parent"] = objects["Instance322"];

    objects["Instance325"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance325"]["Name"] = "White";
    objects["Instance325"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance325"]["Parent"] = objects["Instance318"];
    objects["Instance325"]["ZIndex"] = 207;
    objects["Instance325"]["BorderSizePixel"] = 0;
    objects["Instance325"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance326"]["Parent"] = objects["Instance325"];
    objects["Instance326"]["Transparency"] = NumberSequence.new({
    [1] = NumberSequenceKeypoint.new(0, 0, 0),
    [2] = NumberSequenceKeypoint.new(1, 1, 0)
});

    objects["Instance327"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance327"]["ZIndex"] = 211;
    objects["Instance327"]["Parent"] = objects["Instance318"];
    objects["Instance327"]["BorderStrokePosition"] = Enum.BorderStrokePosition.Inner;

    objects["Instance328"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance328"]["ClipsDescendants"] = true;
    objects["Instance328"]["Selectable"] = false;
    objects["Instance328"]["Text"] = "";
    objects["Instance328"]["Active"] = false;
    objects["Instance328"]["AutoButtonColor"] = false;
    objects["Instance328"]["AnchorPoint"] = Vector2.new(1, 0);
    objects["Instance328"]["Parent"] = objects["Instance316"];
    objects["Instance328"]["Name"] = "HUEZone";
    objects["Instance328"]["Position"] = UDim2.new(1, 0, 0, 30);
    objects["Instance328"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance328"]["ZIndex"] = 206;
    objects["Instance328"]["BorderSizePixel"] = 0;
    objects["Instance328"]["Size"] = UDim2.new(0, 25, 1, -30);

    objects["Instance329"]["Rotation"] = 90;
    objects["Instance329"]["Parent"] = objects["Instance328"];
    objects["Instance329"]["Color"] = ColorSequence.new({
    [1] = ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),
    [2] = ColorSequenceKeypoint.new(0.17499999701976776, Color3.new(1, 1, 0)),
    [3] = ColorSequenceKeypoint.new(0.3499999940395355, Color3.new(0.333333, 1, 0)),
    [4] = ColorSequenceKeypoint.new(0.5249999761581421, Color3.new(0, 1, 1)),
    [5] = ColorSequenceKeypoint.new(0.699999988079071, Color3.new(0, 0, 1)),
    [6] = ColorSequenceKeypoint.new(0.875, Color3.new(1, 0, 1)),
    [7] = ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
});

    objects["Instance330"]["Parent"] = objects["Instance328"];
    objects["Instance330"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance330"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance330"]["BackgroundTransparency"] = 0.25;
    objects["Instance330"]["Name"] = "Cursor";
    objects["Instance330"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance330"]["Size"] = UDim2.new(1, 2, 0, 2);
    objects["Instance330"]["ZIndex"] = 207;
    objects["Instance330"]["BorderSizePixel"] = 0;
    objects["Instance330"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance331"]["Thickness"] = 2;
    objects["Instance331"]["Transparency"] = 0.5;
    objects["Instance331"]["Parent"] = objects["Instance330"];

    objects["Instance332"]["Parent"] = objects["Instance328"];
    objects["Instance332"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance332"]["BorderStrokePosition"] = Enum.BorderStrokePosition.Inner;

    objects["Instance333"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance333"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance333"]["Parent"] = objects["Instance328"];
    objects["Instance333"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance333"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance333"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance334"]["Parent"] = objects["Instance316"];
    objects["Instance334"]["AnchorPoint"] = Vector2.new(1, 0);
    objects["Instance334"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance334"]["Name"] = "Preview";
    objects["Instance334"]["Position"] = UDim2.new(1, 0, 0, 0);
    objects["Instance334"]["Size"] = UDim2.new(0, 25, 0, 25);
    objects["Instance334"]["ZIndex"] = 206;
    objects["Instance334"]["BorderSizePixel"] = 0;
    objects["Instance334"]["BackgroundColor3"] = Color3.new(0.501961, 0.25098, 0.25098);

    objects["Instance335"]["Parent"] = objects["Instance334"];
    objects["Instance335"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance335"]["BorderStrokePosition"] = Enum.BorderStrokePosition.Inner;

    objects["Instance336"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance336"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance336"]["Parent"] = objects["Instance334"];
    objects["Instance336"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance336"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance336"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance337"]["Parent"] = objects["Instance315"];
    objects["Instance337"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance337"]["AnchorPoint"] = Vector2.new(0, 1);
    objects["Instance337"]["BackgroundTransparency"] = 1;
    objects["Instance337"]["Name"] = "BottomZone";
    objects["Instance337"]["Position"] = UDim2.new(0, 0, 1, 0);
    objects["Instance337"]["Size"] = UDim2.new(1, 0, 0, 25);
    objects["Instance337"]["ZIndex"] = 205;
    objects["Instance337"]["BorderSizePixel"] = 0;
    objects["Instance337"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance338"]["Name"] = "TextBoxes";
    objects["Instance338"]["Parent"] = objects["Instance337"];

    objects["Instance339"]["Parent"] = objects["Instance338"];
    objects["Instance339"]["FillDirection"] = Enum.FillDirection.Horizontal;
    objects["Instance339"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
    objects["Instance339"]["Padding"] = UDim.new(0, 5);

    objects["Instance340"]["LayoutOrder"] = 2;
    objects["Instance340"]["Active"] = false;
    objects["Instance340"]["Selectable"] = false;
    objects["Instance340"]["TextTransparency"] = 1;
    objects["Instance340"]["BackgroundColor3"] = Color3.new(0, 0, 0);
    objects["Instance340"]["BackgroundTransparency"] = 0.800000011920929;
    objects["Instance340"]["Name"] = "B";
    objects["Instance340"]["Parent"] = objects["Instance338"];
    objects["Instance340"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance340"]["ZIndex"] = 207;
    objects["Instance340"]["BorderSizePixel"] = 0;
    objects["Instance340"]["Size"] = UDim2.new(0, 75, 1, 0);

    objects["Instance341"]["TextWrapped"] = true;
    objects["Instance341"]["TextWrap"] = true;
    objects["Instance341"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance341"]["TextTransparency"] = 0.5;
    objects["Instance341"]["Text"] = "B:";
    objects["Instance341"]["TextSize"] = 14;
    objects["Instance341"]["Parent"] = objects["Instance340"];
    objects["Instance341"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance341"]["TextScaled"] = true;
    objects["Instance341"]["BackgroundTransparency"] = 1;
    objects["Instance341"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance341"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance341"]["Size"] = UDim2.new(0, 20, 1, 0);
    objects["Instance341"]["BorderSizePixel"] = 0;
    objects["Instance341"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance342"]["Parent"] = objects["Instance341"];
    objects["Instance342"]["PaddingTop"] = UDim.new(0.200000003, 0);
    objects["Instance342"]["PaddingLeft"] = UDim.new(0.200000003, 0);
    objects["Instance342"]["PaddingBottom"] = UDim.new(0.200000003, 0);

    objects["Instance343"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance343"]["Active"] = false;
    objects["Instance343"]["Parent"] = objects["Instance340"];
    objects["Instance343"]["PlaceholderColor3"] = Color3.new(0.698039, 0.698039, 0.698039);
    objects["Instance343"]["BorderSizePixel"] = 0;
    objects["Instance343"]["Size"] = UDim2.new(1, -25, 1, 0);
    objects["Instance343"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance343"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance343"]["Text"] = "255";
    objects["Instance343"]["TextSize"] = 14;
    objects["Instance343"]["BackgroundColor3"] = Color3.new(0, 0, 0);
    objects["Instance343"]["TextWrapped"] = true;
    objects["Instance343"]["BackgroundTransparency"] = 1;
    objects["Instance343"]["Position"] = UDim2.new(0, 25, 0, 0);
    objects["Instance343"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance343"]["ClearTextOnFocus"] = false;
    objects["Instance343"]["TextScaled"] = true;
    objects["Instance343"]["TextWrap"] = true;

    objects["Instance344"]["PaddingTop"] = UDim.new(0.150000006, 0);
    objects["Instance344"]["PaddingBottom"] = UDim.new(0.150000006, 0);
    objects["Instance344"]["PaddingRight"] = UDim.new(0.100000001, 0);
    objects["Instance344"]["PaddingLeft"] = UDim.new(0.100000001, 0);
    objects["Instance344"]["Parent"] = objects["Instance343"];

    objects["Instance345"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance345"]["Transparency"] = 0.5;
    objects["Instance345"]["Parent"] = objects["Instance340"];
    objects["Instance345"]["BorderStrokePosition"] = Enum.BorderStrokePosition.Inner;

    objects["Instance346"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance346"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance346"]["Parent"] = objects["Instance340"];
    objects["Instance346"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance346"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance346"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance347"]["Active"] = false;
    objects["Instance347"]["Selectable"] = false;
    objects["Instance347"]["TextTransparency"] = 1;
    objects["Instance347"]["BackgroundColor3"] = Color3.new(0, 0, 0);
    objects["Instance347"]["BackgroundTransparency"] = 0.800000011920929;
    objects["Instance347"]["Name"] = "R";
    objects["Instance347"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance347"]["Parent"] = objects["Instance338"];
    objects["Instance347"]["ZIndex"] = 207;
    objects["Instance347"]["BorderSizePixel"] = 0;
    objects["Instance347"]["Size"] = UDim2.new(0, 75, 1, 0);

    objects["Instance348"]["TextWrapped"] = true;
    objects["Instance348"]["TextWrap"] = true;
    objects["Instance348"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance348"]["TextTransparency"] = 0.5;
    objects["Instance348"]["Text"] = "R:";
    objects["Instance348"]["TextSize"] = 14;
    objects["Instance348"]["Parent"] = objects["Instance347"];
    objects["Instance348"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance348"]["TextScaled"] = true;
    objects["Instance348"]["BackgroundTransparency"] = 1;
    objects["Instance348"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance348"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance348"]["Size"] = UDim2.new(0, 20, 1, 0);
    objects["Instance348"]["BorderSizePixel"] = 0;
    objects["Instance348"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance349"]["Parent"] = objects["Instance348"];
    objects["Instance349"]["PaddingTop"] = UDim.new(0.200000003, 0);
    objects["Instance349"]["PaddingLeft"] = UDim.new(0.200000003, 0);
    objects["Instance349"]["PaddingBottom"] = UDim.new(0.200000003, 0);

    objects["Instance350"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance350"]["Active"] = false;
    objects["Instance350"]["Parent"] = objects["Instance347"];
    objects["Instance350"]["PlaceholderColor3"] = Color3.new(0.698039, 0.698039, 0.698039);
    objects["Instance350"]["BorderSizePixel"] = 0;
    objects["Instance350"]["Size"] = UDim2.new(1, -25, 1, 0);
    objects["Instance350"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance350"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance350"]["Text"] = "255";
    objects["Instance350"]["TextSize"] = 14;
    objects["Instance350"]["BackgroundColor3"] = Color3.new(0, 0, 0);
    objects["Instance350"]["TextWrapped"] = true;
    objects["Instance350"]["BackgroundTransparency"] = 1;
    objects["Instance350"]["Position"] = UDim2.new(0, 25, 0, 0);
    objects["Instance350"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance350"]["ClearTextOnFocus"] = false;
    objects["Instance350"]["TextScaled"] = true;
    objects["Instance350"]["TextWrap"] = true;

    objects["Instance351"]["PaddingTop"] = UDim.new(0.150000006, 0);
    objects["Instance351"]["PaddingBottom"] = UDim.new(0.150000006, 0);
    objects["Instance351"]["PaddingRight"] = UDim.new(0.100000001, 0);
    objects["Instance351"]["PaddingLeft"] = UDim.new(0.100000001, 0);
    objects["Instance351"]["Parent"] = objects["Instance350"];

    objects["Instance352"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance352"]["Transparency"] = 0.5;
    objects["Instance352"]["Parent"] = objects["Instance347"];
    objects["Instance352"]["BorderStrokePosition"] = Enum.BorderStrokePosition.Inner;

    objects["Instance353"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance353"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance353"]["Parent"] = objects["Instance347"];
    objects["Instance353"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance353"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance353"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance354"]["LayoutOrder"] = 1;
    objects["Instance354"]["Active"] = false;
    objects["Instance354"]["Selectable"] = false;
    objects["Instance354"]["TextTransparency"] = 1;
    objects["Instance354"]["BackgroundColor3"] = Color3.new(0, 0, 0);
    objects["Instance354"]["BackgroundTransparency"] = 0.800000011920929;
    objects["Instance354"]["Name"] = "G";
    objects["Instance354"]["Parent"] = objects["Instance338"];
    objects["Instance354"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance354"]["ZIndex"] = 207;
    objects["Instance354"]["BorderSizePixel"] = 0;
    objects["Instance354"]["Size"] = UDim2.new(0, 75, 1, 0);

    objects["Instance355"]["TextWrapped"] = true;
    objects["Instance355"]["TextWrap"] = true;
    objects["Instance355"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance355"]["TextTransparency"] = 0.5;
    objects["Instance355"]["Text"] = "G:";
    objects["Instance355"]["TextSize"] = 14;
    objects["Instance355"]["Parent"] = objects["Instance354"];
    objects["Instance355"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance355"]["TextScaled"] = true;
    objects["Instance355"]["BackgroundTransparency"] = 1;
    objects["Instance355"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance355"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance355"]["Size"] = UDim2.new(0, 20, 1, 0);
    objects["Instance355"]["BorderSizePixel"] = 0;
    objects["Instance355"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance356"]["Parent"] = objects["Instance355"];
    objects["Instance356"]["PaddingTop"] = UDim.new(0.200000003, 0);
    objects["Instance356"]["PaddingLeft"] = UDim.new(0.200000003, 0);
    objects["Instance356"]["PaddingBottom"] = UDim.new(0.200000003, 0);

    objects["Instance357"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance357"]["Active"] = false;
    objects["Instance357"]["Parent"] = objects["Instance354"];
    objects["Instance357"]["PlaceholderColor3"] = Color3.new(0.698039, 0.698039, 0.698039);
    objects["Instance357"]["BorderSizePixel"] = 0;
    objects["Instance357"]["Size"] = UDim2.new(1, -25, 1, 0);
    objects["Instance357"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance357"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance357"]["Text"] = "255";
    objects["Instance357"]["TextSize"] = 14;
    objects["Instance357"]["BackgroundColor3"] = Color3.new(0, 0, 0);
    objects["Instance357"]["TextWrapped"] = true;
    objects["Instance357"]["BackgroundTransparency"] = 1;
    objects["Instance357"]["Position"] = UDim2.new(0, 25, 0, 0);
    objects["Instance357"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance357"]["ClearTextOnFocus"] = false;
    objects["Instance357"]["TextScaled"] = true;
    objects["Instance357"]["TextWrap"] = true;

    objects["Instance358"]["PaddingTop"] = UDim.new(0.150000006, 0);
    objects["Instance358"]["PaddingBottom"] = UDim.new(0.150000006, 0);
    objects["Instance358"]["PaddingRight"] = UDim.new(0.100000001, 0);
    objects["Instance358"]["PaddingLeft"] = UDim.new(0.100000001, 0);
    objects["Instance358"]["Parent"] = objects["Instance357"];

    objects["Instance359"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance359"]["Transparency"] = 0.5;
    objects["Instance359"]["Parent"] = objects["Instance354"];
    objects["Instance359"]["BorderStrokePosition"] = Enum.BorderStrokePosition.Inner;

    objects["Instance360"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance360"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance360"]["Parent"] = objects["Instance354"];
    objects["Instance360"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance360"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance360"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance361"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance361"]["Active"] = false;
    objects["Instance361"]["Parent"] = objects["Instance337"];
    objects["Instance361"]["AnchorPoint"] = Vector2.new(1, 0);
    objects["Instance361"]["ZIndex"] = 206;
    objects["Instance361"]["BorderSizePixel"] = 0;
    objects["Instance361"]["Size"] = UDim2.new(0, 100, 1, 0);
    objects["Instance361"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance361"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance361"]["Text"] = "Accept";
    objects["Instance361"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance361"]["TextSize"] = 14;
    objects["Instance361"]["BackgroundTransparency"] = 0.8999999761581421;
    objects["Instance361"]["Position"] = UDim2.new(1, 0, 0, 0);
    objects["Instance361"]["TextWrapped"] = true;
    objects["Instance361"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance361"]["TextScaled"] = true;
    objects["Instance361"]["TextWrap"] = true;

    objects["Instance362"]["PaddingTop"] = UDim.new(0.150000006, 0);
    objects["Instance362"]["PaddingBottom"] = UDim.new(0.150000006, 0);
    objects["Instance362"]["PaddingRight"] = UDim.new(0.100000001, 0);
    objects["Instance362"]["PaddingLeft"] = UDim.new(0.100000001, 0);
    objects["Instance362"]["Parent"] = objects["Instance361"];

    objects["Instance363"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance363"]["Transparency"] = 0.25;
    objects["Instance363"]["Parent"] = objects["Instance361"];
    objects["Instance363"]["BorderStrokePosition"] = Enum.BorderStrokePosition.Inner;

    objects["Instance364"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance364"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance364"]["Parent"] = objects["Instance361"];
    objects["Instance364"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance364"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance364"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance365"]["BackgroundTransparency"] = 1;
    objects["Instance365"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance365"]["Name"] = "TopbarZone";
    objects["Instance365"]["Size"] = UDim2.new(1, 0, 0, 40);
    objects["Instance365"]["Parent"] = objects["Instance314"];
    objects["Instance365"]["ZIndex"] = 205;
    objects["Instance365"]["BorderSizePixel"] = 0;
    objects["Instance365"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance366"]["Parent"] = objects["Instance365"];
    objects["Instance366"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance366"]["AnchorPoint"] = Vector2.new(1, 0);
    objects["Instance366"]["BackgroundTransparency"] = 1;
    objects["Instance366"]["Name"] = "Right";
    objects["Instance366"]["Position"] = UDim2.new(1, 0, 0, 0);
    objects["Instance366"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance366"]["ZIndex"] = 206;
    objects["Instance366"]["BorderSizePixel"] = 0;
    objects["Instance366"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance367"]["VerticalAlignment"] = Enum.VerticalAlignment.Center;
    objects["Instance367"]["FillDirection"] = Enum.FillDirection.Horizontal;
    objects["Instance367"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right;
    objects["Instance367"]["Parent"] = objects["Instance366"];
    objects["Instance367"]["Padding"] = UDim.new(0, 5);
    objects["Instance367"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

    objects["Instance368"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance368"]["Active"] = false;
    objects["Instance368"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance368"]["Text"] = "";
    objects["Instance368"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance368"]["BackgroundTransparency"] = 1;
    objects["Instance368"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance368"]["TextSize"] = 14;
    objects["Instance368"]["Name"] = "Close";
    objects["Instance368"]["Parent"] = objects["Instance366"];
    objects["Instance368"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance368"]["ZIndex"] = 208;
    objects["Instance368"]["BorderSizePixel"] = 0;
    objects["Instance368"]["Size"] = UDim2.new(1, 0, 1, 0);

    objects["Instance369"]["Parent"] = objects["Instance368"];
    objects["Instance369"]["AspectRatio"] = 0.9750000238418579;

    objects["Instance370"]["ScaleType"] = Enum.ScaleType.Fit;
    objects["Instance370"]["ImageTransparency"] = 0.25;
    objects["Instance370"]["Parent"] = objects["Instance368"];
    objects["Instance370"]["Size"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance370"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance370"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance370"]["Image"] = "rbxassetid://10152135063";
    objects["Instance370"]["BackgroundTransparency"] = 1;
    objects["Instance370"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance370"]["ImageContent"] = Content.fromUri("rbxassetid://10152135063");
    objects["Instance370"]["ZIndex"] = 209;
    objects["Instance370"]["BorderSizePixel"] = 0;
    objects["Instance370"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance371"]["LayoutOrder"] = 1;
    objects["Instance371"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance371"]["Parent"] = objects["Instance365"];
    objects["Instance371"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance371"]["ZIndex"] = 207;
    objects["Instance371"]["BorderSizePixel"] = 0;
    objects["Instance371"]["Size"] = UDim2.new(1, 0, 1, -16);
    objects["Instance371"]["RichText"] = true;
    objects["Instance371"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance371"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance371"]["Text"] = "Color picker";
    objects["Instance371"]["TextWrap"] = true;
    objects["Instance371"]["TextSize"] = 14;
    objects["Instance371"]["TextWrapped"] = true;
    objects["Instance371"]["BackgroundTransparency"] = 1;
    objects["Instance371"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance371"]["Name"] = "Title";
    objects["Instance371"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance371"]["TextScaled"] = true;
    objects["Instance371"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance372"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance372"]["Name"] = "TopNeon";
    objects["Instance372"]["Size"] = UDim2.new(1, 0, 0, 1);
    objects["Instance372"]["Parent"] = objects["Instance313"];
    objects["Instance372"]["ZIndex"] = 203;
    objects["Instance372"]["BorderSizePixel"] = 0;
    objects["Instance372"]["BackgroundColor3"] = Color3.new(1, 0, 0.498039);

    objects["Instance373"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance373"]["Name"] = "OutsideStroke";
    objects["Instance373"]["Parent"] = objects["Instance313"];

    objects["Instance374"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance374"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance374"]["Parent"] = objects["Instance313"];
    objects["Instance374"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance374"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance374"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance375"]["Parent"] = objects["Instance312"];
    objects["Instance375"]["AspectRatio"] = 1.399999976158142;

    objects["Instance376"]["Name"] = "ColorPickerWindows";
    objects["Instance376"]["Parent"] = objects["Instance25"];

    objects["Instance377"]["Visible"] = false;
    objects["Instance377"]["FontFace"] = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance377"]["BackgroundColor3"] = Color3.new(0.0784314, 0.0784314, 0.0784314);
    objects["Instance377"]["Active"] = false;
    objects["Instance377"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance377"]["Text"] = "";
    objects["Instance377"]["TextColor3"] = Color3.new(0, 0, 0);
    objects["Instance377"]["TextSize"] = 14;
    objects["Instance377"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance377"]["Parent"] = objects["Instance25"];
    objects["Instance377"]["Name"] = "MobileButton";
    objects["Instance377"]["Position"] = UDim2.new(0.5, 0, 0, 50);
    objects["Instance377"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance377"]["ZIndex"] = 2047483646;
    objects["Instance377"]["BorderSizePixel"] = 0;
    objects["Instance377"]["Size"] = UDim2.new(0, 40, 0, 40);

    objects["Instance378"]["Parent"] = objects["Instance377"];
    objects["Instance378"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance378"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance378"]["BackgroundTransparency"] = 1;
    objects["Instance378"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance378"]["Size"] = UDim2.new(1, -2, 1, -2);
    objects["Instance378"]["ZIndex"] = 2047483647;
    objects["Instance378"]["BorderSizePixel"] = 0;
    objects["Instance378"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance379"]["Color"] = Color3.new(1, 0, 0.498039);
    objects["Instance379"]["Parent"] = objects["Instance378"];
    objects["Instance379"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

    objects["Instance380"]["Visible"] = false;
    objects["Instance380"]["ImageTransparency"] = 0.20000000298023224;
    objects["Instance380"]["Parent"] = objects["Instance378"];
    objects["Instance380"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance380"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance380"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance380"]["Image"] = "rbxassetid://8508980527";
    objects["Instance380"]["BackgroundTransparency"] = 1;
    objects["Instance380"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance380"]["ImageContent"] = Content.fromUri("rbxassetid://8508980527");
    objects["Instance380"]["ZIndex"] = 2047483649;
    objects["Instance380"]["BorderSizePixel"] = 0;
    objects["Instance380"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance381"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance381"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance381"]["Parent"] = objects["Instance378"];
    objects["Instance381"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance381"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance381"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance382"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance382"]["Parent"] = objects["Instance378"];
    objects["Instance382"]["TextStrokeTransparency"] = 0;
    objects["Instance382"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
    objects["Instance382"]["ZIndex"] = 2047483648;
    objects["Instance382"]["BorderSizePixel"] = 0;
    objects["Instance382"]["Size"] = UDim2.new(0.8999999761581421, 0, 0.8999999761581421, 0);
    objects["Instance382"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance382"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance382"]["Text"] = "N";
    objects["Instance382"]["TextWrap"] = true;
    objects["Instance382"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal, true);
    objects["Instance382"]["BackgroundTransparency"] = 1;
    objects["Instance382"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
    objects["Instance382"]["TextWrapped"] = true;
    objects["Instance382"]["TextSize"] = 14;
    objects["Instance382"]["TextScaled"] = true;
    objects["Instance382"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance383"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance383"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance383"]["Parent"] = objects["Instance377"];
    objects["Instance383"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance383"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance383"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance384"]["Thickness"] = 2;
    objects["Instance384"]["Parent"] = objects["Instance377"];
    objects["Instance384"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

    objects["Instance385"]["Visible"] = false;
    objects["Instance385"]["Parent"] = objects["Instance0"];
    objects["Instance385"]["AnchorPoint"] = Vector2.new(0, 1);
    objects["Instance385"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance385"]["Name"] = "Tooltip";
    objects["Instance385"]["Position"] = UDim2.new(0, 710, 0, 576);
    objects["Instance385"]["Size"] = UDim2.new(0, 180, 0, 30);
    objects["Instance385"]["ZIndex"] = 2147483646;
    objects["Instance385"]["BorderSizePixel"] = 0;
    objects["Instance385"]["BackgroundColor3"] = Color3.new(0.0784314, 0.0784314, 0.0784314);

    objects["Instance386"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance386"]["LineJoinMode"] = Enum.LineJoinMode.Miter;
    objects["Instance386"]["Name"] = "OutsideStroke";
    objects["Instance386"]["Parent"] = objects["Instance385"];

    objects["Instance387"]["FontSize"] = Enum.FontSize.Size18;
    objects["Instance387"]["TextYAlignment"] = Enum.TextYAlignment.Top;
    objects["Instance387"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance387"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance387"]["Text"] = "Just a regular checkbox!";
    objects["Instance387"]["TextSize"] = 16;
    objects["Instance387"]["Parent"] = objects["Instance385"];
    objects["Instance387"]["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance387"]["RichText"] = true;
    objects["Instance387"]["BackgroundTransparency"] = 1;
    objects["Instance387"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance387"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance387"]["ZIndex"] = 2147483647;
    objects["Instance387"]["BorderSizePixel"] = 0;
    objects["Instance387"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance388"]["Parent"] = objects["Instance385"];
    objects["Instance388"]["PaddingTop"] = UDim.new(0, 6);
    objects["Instance388"]["PaddingLeft"] = UDim.new(0, 7);

    objects["Instance389"]["FontFace"] = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance389"]["Parent"] = objects["Instance385"];
    objects["Instance389"]["ZIndex"] = 2147483647;
    objects["Instance389"]["BorderSizePixel"] = 0;
    objects["Instance389"]["Size"] = UDim2.new(1, 0, 0, 10000);
    objects["Instance389"]["RichText"] = true;
    objects["Instance389"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance389"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance389"]["Text"] = "Just a regular checkbox!";
    objects["Instance389"]["FontSize"] = Enum.FontSize.Size18;
    objects["Instance389"]["Name"] = "TextLabelInvisible";
    objects["Instance389"]["BackgroundTransparency"] = 1;
    objects["Instance389"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance389"]["TextSize"] = 16;
    objects["Instance389"]["TextYAlignment"] = Enum.TextYAlignment.Top;
    objects["Instance389"]["TextTransparency"] = 1;
    objects["Instance389"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance390"]["Name"] = "Notifications";
    objects["Instance390"]["Parent"] = objects["Instance0"];

    objects["Instance391"]["ClipsDescendants"] = true;
    objects["Instance391"]["Parent"] = objects["Instance390"];
    objects["Instance391"]["BackgroundTransparency"] = 1;
    objects["Instance391"]["Name"] = "NotificationsLeft";
    objects["Instance391"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance391"]["Size"] = UDim2.new(0, 250, 1, 0);
    objects["Instance391"]["ZIndex"] = 214748364;
    objects["Instance391"]["BorderSizePixel"] = 0;
    objects["Instance391"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance392"]["VerticalAlignment"] = Enum.VerticalAlignment.Bottom;
    objects["Instance392"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
    objects["Instance392"]["Parent"] = objects["Instance391"];

    objects["Instance393"]["BackgroundTransparency"] = 1;
    objects["Instance393"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance393"]["Name"] = "Holder";
    objects["Instance393"]["Size"] = UDim2.new(1, 0, 0, 47);
    objects["Instance393"]["Parent"] = objects["Instance391"];
    objects["Instance393"]["ZIndex"] = 2147483641;
    objects["Instance393"]["BorderSizePixel"] = 0;
    objects["Instance393"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance394"]["Parent"] = objects["Instance393"];
    objects["Instance394"]["PaddingTop"] = UDim.new(0, 1);
    objects["Instance394"]["PaddingRight"] = UDim.new(0, 1);
    objects["Instance394"]["PaddingBottom"] = UDim.new(0, 2);

    objects["Instance395"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance395"]["Name"] = "Background";
    objects["Instance395"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance395"]["Parent"] = objects["Instance393"];
    objects["Instance395"]["ZIndex"] = 2147483642;
    objects["Instance395"]["BorderSizePixel"] = 0;
    objects["Instance395"]["BackgroundColor3"] = Color3.new(0.0784314, 0.0784314, 0.0784314);

    objects["Instance396"]["Size"] = UDim2.new(1, -8, 1, -8);
    objects["Instance396"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance396"]["Name"] = "Holder";
    objects["Instance396"]["Position"] = UDim2.new(0, 0, 0, 3);
    objects["Instance396"]["Parent"] = objects["Instance395"];
    objects["Instance396"]["ZIndex"] = 2147483644;
    objects["Instance396"]["BorderSizePixel"] = 0;
    objects["Instance396"]["BackgroundColor3"] = Color3.new(0.0784314, 0.0784314, 0.0784314);

    objects["Instance397"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance397"]["Parent"] = objects["Instance396"];
    objects["Instance397"]["ZIndex"] = 2147483646;
    objects["Instance397"]["BorderSizePixel"] = 0;
    objects["Instance397"]["Size"] = UDim2.new(1, 0, 0, 16);
    objects["Instance397"]["RichText"] = true;
    objects["Instance397"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance397"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance397"]["Text"] = "A notification!";
    objects["Instance397"]["TextWrap"] = true;
    objects["Instance397"]["Name"] = "Title";
    objects["Instance397"]["BackgroundTransparency"] = 1;
    objects["Instance397"]["TextWrapped"] = true;
    objects["Instance397"]["TextSize"] = 14;
    objects["Instance397"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance397"]["TextScaled"] = true;
    objects["Instance397"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance398"]["Parent"] = objects["Instance397"];
    objects["Instance398"]["PaddingTop"] = UDim.new(0, 2);
    objects["Instance398"]["PaddingBottom"] = UDim.new(0, 1);

    objects["Instance399"]["Parent"] = objects["Instance396"];
    objects["Instance399"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance399"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance399"]["BackgroundTransparency"] = 0.949999988079071;
    objects["Instance399"]["Position"] = UDim2.new(0.5, 0, 0, 17);
    objects["Instance399"]["Size"] = UDim2.new(0.949999988079071, 0, 0, 1);
    objects["Instance399"]["ZIndex"] = 2147483646;
    objects["Instance399"]["BorderSizePixel"] = 0;
    objects["Instance399"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance400"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance400"]["Parent"] = objects["Instance396"];
    objects["Instance400"]["ZIndex"] = 2147483646;
    objects["Instance400"]["BorderSizePixel"] = 0;
    objects["Instance400"]["Size"] = UDim2.new(1, 0, 1, -18);
    objects["Instance400"]["RichText"] = true;
    objects["Instance400"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance400"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance400"]["Text"] = "Notification text should be here.";
    objects["Instance400"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance400"]["TextWrap"] = true;
    objects["Instance400"]["Name"] = "Text";
    objects["Instance400"]["TextWrapped"] = true;
    objects["Instance400"]["BackgroundTransparency"] = 1;
    objects["Instance400"]["Position"] = UDim2.new(0, 0, 0, 18);
    objects["Instance400"]["TextSize"] = 14;
    objects["Instance400"]["TextYAlignment"] = Enum.TextYAlignment.Top;
    objects["Instance400"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance400"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance401"]["PaddingTop"] = UDim.new(0, 1);
    objects["Instance401"]["PaddingBottom"] = UDim.new(0, 1);
    objects["Instance401"]["PaddingRight"] = UDim.new(0, 3);
    objects["Instance401"]["PaddingLeft"] = UDim.new(0, 3);
    objects["Instance401"]["Parent"] = objects["Instance400"];

    objects["Instance402"]["Parent"] = objects["Instance396"];
    objects["Instance402"]["AnchorPoint"] = Vector2.new(1, 0);
    objects["Instance402"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance402"]["Name"] = "Buttons";
    objects["Instance402"]["Position"] = UDim2.new(1, -1, 0, 0);
    objects["Instance402"]["Size"] = UDim2.new(1, 0, 0, 17);
    objects["Instance402"]["ZIndex"] = 2147483646;
    objects["Instance402"]["BorderSizePixel"] = 0;
    objects["Instance402"]["BackgroundColor3"] = Color3.new(0.0784314, 0.0784314, 0.0784314);

    objects["Instance403"]["Parent"] = objects["Instance402"];
    objects["Instance403"]["AspectRatio"] = 2;

    objects["Instance404"]["Active"] = false;
    objects["Instance404"]["Parent"] = objects["Instance402"];
    objects["Instance404"]["BackgroundTransparency"] = 1;
    objects["Instance404"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance404"]["Image"] = "rbxassetid://130396712201457";
    objects["Instance404"]["Name"] = "Yes";
    objects["Instance404"]["Size"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance404"]["ImageContent"] = Content.fromUri("rbxassetid://130396712201457");
    objects["Instance404"]["ZIndex"] = 2147483646;
    objects["Instance404"]["BorderSizePixel"] = 0;
    objects["Instance404"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance405"]["Active"] = false;
    objects["Instance405"]["Parent"] = objects["Instance402"];
    objects["Instance405"]["BackgroundTransparency"] = 1;
    objects["Instance405"]["Size"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance405"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance405"]["Image"] = "rbxassetid://10152135063";
    objects["Instance405"]["Name"] = "No";
    objects["Instance405"]["Position"] = UDim2.new(0.5, 0, 0, 0);
    objects["Instance405"]["ImageContent"] = Content.fromUri("rbxassetid://10152135063");
    objects["Instance405"]["ZIndex"] = 2147483646;
    objects["Instance405"]["BorderSizePixel"] = 0;
    objects["Instance405"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance406"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance406"]["Name"] = "Halfer";
    objects["Instance406"]["Size"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance406"]["Parent"] = objects["Instance396"];
    objects["Instance406"]["ZIndex"] = 2147483645;
    objects["Instance406"]["BorderSizePixel"] = 0;
    objects["Instance406"]["BackgroundColor3"] = Color3.new(0.0784314, 0.0784314, 0.0784314);

    objects["Instance407"]["TopLeftRadius"] = UDim.new(0, 3);
    objects["Instance407"]["CornerRadius"] = UDim.new(0, 3);
    objects["Instance407"]["Parent"] = objects["Instance396"];
    objects["Instance407"]["BottomRightRadius"] = UDim.new(0, 3);
    objects["Instance407"]["TopRightRadius"] = UDim.new(0, 3);
    objects["Instance407"]["BottomLeftRadius"] = UDim.new(0, 3);

    objects["Instance408"]["BackgroundTransparency"] = 1;
    objects["Instance408"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance408"]["Name"] = "Progress";
    objects["Instance408"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance408"]["Parent"] = objects["Instance395"];
    objects["Instance408"]["ZIndex"] = 2147483643;
    objects["Instance408"]["BorderSizePixel"] = 0;
    objects["Instance408"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance409"]["Name"] = "Fill";
    objects["Instance409"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance409"]["Parent"] = objects["Instance408"];
    objects["Instance409"]["Size"] = UDim2.new(0.75, 0, 1, 0);
    objects["Instance409"]["BorderSizePixel"] = 0;
    objects["Instance409"]["BackgroundColor3"] = Color3.new(1, 0, 0.498039);

    objects["Instance410"]["GroupColor3"] = Color3.new(1, 0, 0.498039);
    objects["Instance410"]["BackgroundTransparency"] = 1;
    objects["Instance410"]["GroupTransparency"] = 0.5;
    objects["Instance410"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance410"]["Parent"] = objects["Instance408"];
    objects["Instance410"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance410"]["BorderSizePixel"] = 0;
    objects["Instance410"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance411"]["Name"] = "Half1";
    objects["Instance411"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance411"]["Parent"] = objects["Instance410"];
    objects["Instance411"]["Size"] = UDim2.new(0.5, 0, 1, 0);
    objects["Instance411"]["BorderSizePixel"] = 0;
    objects["Instance411"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance412"]["Name"] = "Half2";
    objects["Instance412"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance412"]["Parent"] = objects["Instance410"];
    objects["Instance412"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance412"]["BorderSizePixel"] = 0;
    objects["Instance412"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance413"]["TopLeftRadius"] = UDim.new(0, 3);
    objects["Instance413"]["CornerRadius"] = UDim.new(0, 3);
    objects["Instance413"]["Parent"] = objects["Instance412"];
    objects["Instance413"]["BottomRightRadius"] = UDim.new(0, 3);
    objects["Instance413"]["TopRightRadius"] = UDim.new(0, 3);
    objects["Instance413"]["BottomLeftRadius"] = UDim.new(0, 3);

    objects["Instance414"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance414"]["Name"] = "OutsideStroke";
    objects["Instance414"]["Parent"] = objects["Instance395"];

    objects["Instance415"]["TopLeftRadius"] = UDim.new(0, 3);
    objects["Instance415"]["CornerRadius"] = UDim.new(0, 3);
    objects["Instance415"]["Parent"] = objects["Instance395"];
    objects["Instance415"]["BottomRightRadius"] = UDim.new(0, 3);
    objects["Instance415"]["TopRightRadius"] = UDim.new(0, 3);
    objects["Instance415"]["BottomLeftRadius"] = UDim.new(0, 3);

    objects["Instance416"]["ClipsDescendants"] = true;
    objects["Instance416"]["Parent"] = objects["Instance390"];
    objects["Instance416"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance416"]["AnchorPoint"] = Vector2.new(1, 0);
    objects["Instance416"]["BackgroundTransparency"] = 1;
    objects["Instance416"]["Name"] = "NotificationsRight";
    objects["Instance416"]["Position"] = UDim2.new(1, 0, 0, 50);
    objects["Instance416"]["Size"] = UDim2.new(0, 250, 1, -50);
    objects["Instance416"]["ZIndex"] = 214748364;
    objects["Instance416"]["BorderSizePixel"] = 0;
    objects["Instance416"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance417"]["Parent"] = objects["Instance416"];
    objects["Instance417"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
    objects["Instance417"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Right;

    objects["Instance418"]["BackgroundColor3"] = Color3.new(1, 1, 1);
    objects["Instance418"]["Active"] = false;
    objects["Instance418"]["Selectable"] = false;
    objects["Instance418"]["Text"] = "";
    objects["Instance418"]["BackgroundTransparency"] = 1;
    objects["Instance418"]["AutoButtonColor"] = false;
    objects["Instance418"]["AnchorPoint"] = Vector2.new(0, 0.5);
    objects["Instance418"]["Parent"] = objects["Instance0"];
    objects["Instance418"]["Name"] = "FloatingLabel";
    objects["Instance418"]["Position"] = UDim2.new(0.05000000074505806, 0, 0.5, 0);
    objects["Instance418"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance418"]["ZIndex"] = 147483646;
    objects["Instance418"]["BorderSizePixel"] = 0;
    objects["Instance418"]["Size"] = UDim2.new(0, 113, 0, 37);

    objects["Instance419"]["Name"] = "Contents";
    objects["Instance419"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance419"]["Parent"] = objects["Instance418"];
    objects["Instance419"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance419"]["BorderSizePixel"] = 0;
    objects["Instance419"]["BackgroundColor3"] = Color3.new(0.0784314, 0.0784314, 0.0784314);

    objects["Instance420"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance420"]["Name"] = "TopNeon";
    objects["Instance420"]["Size"] = UDim2.new(1, 0, 0, 1);
    objects["Instance420"]["Parent"] = objects["Instance419"];
    objects["Instance420"]["ZIndex"] = 147483647;
    objects["Instance420"]["BorderSizePixel"] = 0;
    objects["Instance420"]["BackgroundColor3"] = Color3.new(1, 0, 0.498039);

    objects["Instance421"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
    objects["Instance421"]["Name"] = "OutsideStroke";
    objects["Instance421"]["Parent"] = objects["Instance419"];

    objects["Instance422"]["Parent"] = objects["Instance419"];
    objects["Instance422"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance422"]["AnchorPoint"] = Vector2.new(0.5, 0);
    objects["Instance422"]["BackgroundTransparency"] = 1;
    objects["Instance422"]["Name"] = "Contents";
    objects["Instance422"]["Position"] = UDim2.new(0.5, 0, 0, 3);
    objects["Instance422"]["Size"] = UDim2.new(1, -8, 1, -3);
    objects["Instance422"]["ZIndex"] = 147483647;
    objects["Instance422"]["BorderSizePixel"] = 0;
    objects["Instance422"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance423"]["FontSize"] = Enum.FontSize.Size18;
    objects["Instance423"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance423"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance423"]["Text"] = "Keybinds";
    objects["Instance423"]["TextSize"] = 16;
    objects["Instance423"]["Name"] = "Title";
    objects["Instance423"]["Parent"] = objects["Instance422"];
    objects["Instance423"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal, true);
    objects["Instance423"]["BackgroundTransparency"] = 1;
    objects["Instance423"]["RichText"] = true;
    objects["Instance423"]["Size"] = UDim2.new(1, 0, 0, 16);
    objects["Instance423"]["ZIndex"] = 147483648;
    objects["Instance423"]["BorderSizePixel"] = 0;
    objects["Instance423"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance424"]["Visible"] = false;
    objects["Instance424"]["Parent"] = objects["Instance423"];
    objects["Instance424"]["Image"] = "rbxasset://textures/ui/GuiImagePlaceholder.png";
    objects["Instance424"]["BackgroundTransparency"] = 1;
    objects["Instance424"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance424"]["ImageContent"] = Content.fromUri("rbxasset://textures/ui/GuiImagePlaceholder.png");
    objects["Instance424"]["Size"] = UDim2.new(1, 0, 1, 0);
    objects["Instance424"]["BorderSizePixel"] = 0;
    objects["Instance424"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance425"]["Parent"] = objects["Instance424"];

    objects["Instance426"]["FontFace"] = Font.new("rbxasset://fonts/families/Arial.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal, false);
    objects["Instance426"]["Parent"] = objects["Instance422"];
    objects["Instance426"]["ZIndex"] = 147483648;
    objects["Instance426"]["BorderSizePixel"] = 0;
    objects["Instance426"]["Size"] = UDim2.new(1, 0, 1, -16);
    objects["Instance426"]["RichText"] = true;
    objects["Instance426"]["TextColor3"] = Color3.new(1, 1, 1);
    objects["Instance426"]["BorderColor3"] = Color3.new(0, 0, 0);
    objects["Instance426"]["Text"] = "Keybinds";
    objects["Instance426"]["TextXAlignment"] = Enum.TextXAlignment.Left;
    objects["Instance426"]["Name"] = "Text";
    objects["Instance426"]["BackgroundTransparency"] = 1;
    objects["Instance426"]["Position"] = UDim2.new(0, 0, 0, 16);
    objects["Instance426"]["FontSize"] = Enum.FontSize.Size14;
    objects["Instance426"]["TextYAlignment"] = Enum.TextYAlignment.Top;
    objects["Instance426"]["TextSize"] = 14;
    objects["Instance426"]["BackgroundColor3"] = Color3.new(1, 1, 1);

    objects["Instance427"]["TopLeftRadius"] = UDim.new(0, 4);
    objects["Instance427"]["CornerRadius"] = UDim.new(0, 4);
    objects["Instance427"]["Parent"] = objects["Instance419"];
    objects["Instance427"]["BottomRightRadius"] = UDim.new(0, 4);
    objects["Instance427"]["TopRightRadius"] = UDim.new(0, 4);
    objects["Instance427"]["BottomLeftRadius"] = UDim.new(0, 4);

    objects["Instance428"]["Name"] = "MobileButtons";
    objects["Instance428"]["Parent"] = objects["Instance0"];

    objects["Instance429"]["Name"] = "FloatingLabels";
    objects["Instance429"]["Parent"] = objects["Instance0"];
end;
local ___args = table.pack(...); local ___up = unpack;

-- Set modules
local o_require = require; local require; local cache = { };
local modules do
    modules = { };
    require = function(object)
        if modules[object] then
            local ret = cache[object] or modules[object](___up(___args));
            cache[object] = ret;
            return ret;
        end
        return o_require(object);
    end;

    getfenv().require = require;

    modules[objects["Instance19"]] = function(...)
        local script = objects["Instance19"];
local env = getfenv()
local function g(n)
    return env[n]
end

local global = (g("getgenv") or function() return _G end)()
local key = "NFOtherLib"

if global[key] then
    return global[key]
end

local max, min = math.max, math.min
local c3n = Color3.new
local c3h = Color3.fromHSV
local utf8co = utf8.codes
local utf8ch = utf8.char
local abs = math.abs
local clamp = math.clamp

local pack, concat = table.pack, table.concat
local function memoize(fn, skipFirst)
    --[[local cache = setmetatable({ }, { __mode = "k" })

    return function(...)
        local args = pack(...)
        if skipFirst then
            args[1] = ""
        end
        
        local key = args.n ~= 0 and concat(args, "\0") or ""

        local result = cache[key]
        if result then
            return unpack(result, 1, result.n)
        end

        result = pack(fn(...))
        cache[key] = result

        return unpack(result, 1, result.n)
    end]]
    return fn
end

local special = memoize(function(i)
    return i == "" or i:upper() == i:lower()
end)

local isUpper = memoize(function(v)
    return not special(v) and v:upper() == v
end)

local isLower = memoize(function(v)
    return not special(v) and v:lower() == v
end)

local isNumber = memoize(function(v)
    return v >= '0' and v <= '9'
end)

local defaultRotationPattern = { "G", "B", "R" }
local richReplace = {
    ["'"] = "&apos;",
    ['"'] = "&quot;",
    ["<"] = "&lt;",
    [">"] = "&gt;",
    ["&"] = "&amp;"
}

local lib = {
    Smart = function(self, str: string)
        if #str <= 1 then return str end

        local chars = self:GetCharacters(str)
        local result: string = chars[1]:upper()
        for i = 2, #chars do
            local v = chars[i]
            local prev = chars[max(i - 1, 1)]

            result ..= ((isUpper(v) and not isUpper(prev) or isUpper(v) and isUpper(prev) and isUpper(chars[max(i - 2, 1)]) and isLower(chars[min(i + 1, #str)])) and " " or "") .. v
        end

        local final = ""
        chars = self:GetCharacters(result)

        for i = 1, #chars do
            local char = chars[i]
            local prev = chars[i - 1] or ""

            if special(char) and not isNumber(char) or prev ~= "" and special(prev) and not isNumber(prev) or isNumber(char) and isLower(prev) or isUpper(char) and isUpper(prev) and isLower(chars[i + 1] or "") then
                final ..= " "
            end

            final ..= char
        end

        while true do
            local new, changes = final:gsub("  ", " ")
            if changes > 0 then
                final = new
            else
                break
            end
        end

        return final
    end,
    GetCharacters = memoize(function(self, str)
        local res = { }
        for _, v in utf8co(str) do
            res[#res + 1] = utf8ch(v)
        end

        return res
    end, true),
    RotateColor = function(self, color, pattern)
        pattern = pattern or defaultRotationPattern

        local channels = { R = color.R, G = color.G, B = color.B }
        local result = { }
        for i, channelName in pattern do
            result[channelName] = channels[channelName]
        end

        return c3n(result.R, result.G, result.B)
    end,
    RichPaint = function(self, text, c3)
        return "<font color=\"#" .. (c3n(clamp(c3.R, 0, 1), clamp(c3.G, 0, 1), clamp(c3.B, 0, 1))):ToHex() .. "\">" .. self:RichEscape(text) .. "</font>"
    end,
    RichGradient = function(self, text, c1, c2, offset)
        offset = offset or 0

        local result = ""
        local chars = self:GetCharacters(text)
        local ch = #chars - 1

        for i, v in chars do
            result ..= self:RichPaint(v, c1:Lerp(c2, abs((((i - 1) / ch) + offset) % 2 - 1)))
        end

        return result
    end,
    RGBGradient = function(self, str, offset, speed, saturation, value, mirror)
        return self:RichGradient(str, c3h((abs(offset / (3 - (speed or 2))) + (mirror and 0.2 or 0 )) % 1, saturation or 1, value or 1), c3h((abs(offset / (3 - (speed or 2))) + (mirror and 0 or 0.2 )) % 1, saturation or 1, value or 1))
    end,
    RichEscape = memoize(function(self, str)
        return str:gsub("[&<>'\"%z]", richReplace)
    end, true),
    Memoize = function(self, ...)
        return memoize(...)
    end
}

global[key] = lib
return lib
    end;

    modules[objects["Instance22"]] = function(...)
        local script = objects["Instance22"];
local ecs = game:GetService("EncodingService")
local tostr, fromstr = buffer.tostring, buffer.fromstring

return {
    Encode = function(self, str)
        return tostr(ecs:Base64Encode(fromstr(str)))
    end,
    Decode = function(self, str)
        return tostr(ecs:Base64Decode(fromstr(str)))
    end
}
    end;

    modules[objects["Instance1"]] = function(...)
        local script = objects["Instance1"];
local UI_DEBUG = require(script.Data.DEBUG)

local tfind = table.find
local game = game
local workspace = workspace
local typeof = typeof
local newproxy = newproxy
local tostring = tostring
local tonumber = tonumber
local mrandom = math.random
local _pcall = pcall
local tremove = table.remove
local spawn = task.spawn
local delay = task.delay
local wait = task.wait
local defer = task.defer
local clamp = math.clamp
local abs = math.abs
local round = math.round
local floor = math.floor
local inf, nan = 1 / 0, 0 / 0
local max = math.max
local min = math.min
local tinsert = table.insert
local concat = table.concat
local tsort = table.sort
local tclear = table.clear
local tfreeze = table.freeze
local warn, error, print = warn, error, print
local type = type
local max32 = tonumber("2147483647")

local pcall = function(fn, ...)
    if UI_DEBUG.NO_PCALL_WRAP then
        return true, fn(...)
    else
        return pcall(fn, ...)
    end
end

local tclone = function(a)
    local b = { }
    for i, v in a do
        b[i] = v
    end

    return b
end

local Enum = { }
for i, v in getfenv().Enum:GetEnums() do
    Enum[tostring(v)] = v
end

Enum.GetEnums = function() return Enum end

local U2s = UDim2.fromScale
local U2n = UDim2.new
local U2o = UDim2.fromOffset
local Un = UDim.new
local unpack = unpack
local pack = table.pack
local Inew = Instance.new
local setmetatable = setmetatable
local getmetatable = getmetatable
local select = select
local C3h = Color3.fromHex
local C3n = Color3.new
local C3R = Color3.fromRGB
local V2n = Vector2.new
local TIn = TweenInfo.new
local tick = tick

local rs = game:GetService("RunService")
local function render(times)
    local start = tick()
    for i = 1, max(tonumber(times) or 0, 1) do
        rs.RenderStepped:Wait()
    end

    return tick() - start
end

local config = require(script.Data)

local global = (getfenv().getgenv or function() return _G end)()
if global[... or config.Name] then
    script.Parent:Destroy()
    render()

    return global[... or config.Name]
end

local otherLib = require(script.Libraries.Other)
local cursorLib = require(script.Libraries.EditableCursor)
local translators = require(script.Data.Translators)

--

local wf, rf, df, mf, lf, If, IF = getfenv().writefile, getfenv().readfile, getfenv().delfile or getfenv().deletefile, getfenv().makefolder, getfenv().listfiles, getfenv().isfolder, getfenv().isfile
local gca = getfenv().getcustomasset
local toclip = getfenv().toclipboard or getfenv().setclipboard

local configsEnabled = typeof(wf) == "function" and typeof(rf) == "function" and typeof(df) == "function" and typeof(mf) == "function" and typeof(lf) == "function" and typeof(If) == "function" and typeof(IF) == "function"

local http = game:GetService("HttpService")
local function je(c)
    return http:JSONEncode(c)
end

local function jd(c)
    return http:JSONDecode(c)
end

local function id()
    return tostring(mrandom()):sub(3, 13)
end

local cornerState = {
    [true] = Un(0, 4),
    [false] = Un(0, 0)
}

local compressor, base64 = require(script.Libraries.Compressor), require(script.Libraries.Base64)
local encoder = {
    Encode = function(self, str) return base64:Encode(compressor:Compress(str:reverse(), 22):reverse()):gsub("=", "ZzZ"):gsub("%+", "QqQ"):gsub("/", "XxX"):reverse() end,
    Decode = function(self, str) return compressor:Decompress(base64:Decode(str:reverse():gsub("ZzZ", "="):gsub("QqQ", "+"):gsub("XxX", "/")):reverse()):reverse() end
}

local function clean(str)
    return str:gsub("[\n\r\f\t\0 ]", "")
end

local antiRich do
    local richReplace = {
        ["'"] = "&apos;",
        ['"'] = "&quot;",
        ["<"] = "&lt;",
        [">"] = "&gt;",
        ["&"] = "&amp;"
    }

    function antiRich(str)
        return str:gsub("[&<>'\"%z]", richReplace)
    end
end

local wf = configsEnabled and function(name, contents, dontEncode)
    wf(name, typeof(contents) == "string" and (not dontEncode and encoder:Encode(contents) or contents) or encoder:Encode(je(contents)))
end

local rf = configsEnabled and function(name, decode)
    local success, content = pcall(rf, name)
    if not success or not content or content == "" then
        return nil
    end

    if not decode then
        return content
    end

    local success, decoded = pcall(encoder.Decode, encoder, content)
    if not success then
        return nil
    end

    local s, d = pcall(jd, decoded)
    if s then
        return d
    end

    return decoded
end

local mf = configsEnabled and function(name)
    if not If(name) then
        mf(name)
        return true
    end

    return false
end

local nf = configsEnabled and function(name, default, dontEncode)
    if not IF(name) then
        wf(name, default, dontEncode)
        return true
    end

    return false
end

local coreFolder = config.Name
coreFolder ..= "/"

local cacheRoute = coreFolder .. "Cache/"
local configsRoute = coreFolder .. "Configs/"

local json = "shrimp"
json = "." .. json

local themesRoute = coreFolder .. "Themes"
themesRoute ..= "/"

local library, downloadImage
local backgrounds = require(script.Data.Backgrounds)

local function count(tbl)
    local i = 0
    for _ in tbl do
        i += 1
    end

    return i
end

local function tEqual(a, b)
    if typeof(a) ~= "table" or type(b) ~= "table" then return a == b end
    if count(a) ~= count(b) then return false end
    for i, v in a do if b[i] ~= v then return false end end
    for i, v in b do if a[i] ~= v then return false end end

    return true
end

local event = require(script.Libraries.Event)
local guid = http:GenerateGUID(false):gsub("-", "")
local gsubInput, playSound

local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer or plrs.PlayerAdded:Wait()

local safeReparent do
    local reparentQueue = { }
    local function flushQueue(object, queue)
        if #queue == 0 then
            reparentQueue[object] = nil
            return
        end

        object.Parent = tremove(queue, 1)

        if #queue == 0 then
            reparentQueue[object] = nil
        end
    end

    safeReparent = function(a, b)
        local myQueue = reparentQueue[a]
        if not myQueue then
            myQueue = setmetatable({ }, { __mode = "kv" })
            reparentQueue[a] = myQueue
        end

        if #myQueue == 0 or myQueue[#myQueue] ~= b then
            myQueue[#myQueue + 1] = b
            flushQueue(a, myQueue)
        end
    end

    event.Clock:Connect(function(delta, skip)
        if skip then return end

        for object, queue in reparentQueue do
            flushQueue(object, queue)
        end
    end)
end

local ping do
    spawn(function()
        repeat wait() until game:IsLoaded()

        local rrs = game:GetService("RobloxReplicatedStorage")

        local disconnected = false
        local prevPing = plr:GetNetworkPing()
        local pingChangeTime = prevPing * 10
        
        ping = prevPing

        local ev = rrs and rrs:WaitForChild("GetServerVersion", prevPing + 1)
        local pingTE = tick()

        if not ev then
            while true do
                if not disconnected then
                    local cping = plr:GetNetworkPing()
                    if cping ~= prevPing then
                        local ct = tick()

                        prevPing = cping
                        pingChangeTime = (ct - pingTE) * 10
                        pingTE = ct

                        if cping < 0 then
                            disconnected = true
                        end
                    end
                end

                ping = disconnected and -1 or max(tick() - pingTE - pingChangeTime, prevPing)
                if disconnected then break end
                
                wait()
            end
        else
            spawn(function()
                while wait() do
                    local np = plr:GetNetworkPing()
                    
                    disconnected = disconnected or np < 0
                    ping = disconnected and -1 or max(tick() - pingTE - pingChangeTime, np)

                    if disconnected then break end
                end
            end)

            while true do
                local start = tick()
                ev:InvokeServer()

                local ct = tick()

                pingChangeTime = (ct - pingTE) * 2
                pingTE = ct

                if disconnected then break end
            end
        end
    end)
end

local function readTimes(path)
    local times = rf and rf(path, false)
    if times then
        if times == "" then
            times = 1
        else
            local success, decoded = pcall(encoder.Decode, encoder, times)
            if not success then
                times = 0
            else
                times = tonumber(decoded) or 0
            end
        end

        if times then
            times += 1
        end
    end

    times = tonumber(times) or not rf and 1.1 or 1

    if configsEnabled then
        spawn(wf, path, tostring(max(round(times), 1)))
    end

    return times
end

local ranTimes : number = readTimes(coreFolder .. "FirstRun")

spawn(function()
    if mf then
        mf(coreFolder:sub(1, -2))
        mf(cacheRoute:sub(1, -2))
        mf(configsRoute:sub(1, -2))
        mf(themesRoute:sub(1, -2))
    end
end)

local premadeThemes = require(script.Data.DefaultThemes)
local uiBackBlur = require(script.Libraries.UIBackgroundBlur)
local uiBlur = require(script.Libraries.UIBlur)

local translate
local function windowSetup(object) -- in theory, that function is just a plugin for that UI lib
    local window = object.Proxy
    if window.Flag == guid then return end

    window.Options.KeybindMode = event.new()
    window.Options.KeybindModeActive = false

    local objs = { }
    window.Options.KeybindObjects = objs

    local keybindsLabel = window:FloatingLabel("Keybinds" .. id(), { Title = "Keybinds", Text = "", Position = U2n(0, 20, 0.5, 0), AnchorPoint = V2n(0, 0.5), Visible = false })
    local function drawKBL(val)
        window.Options.KeybindModeActive = val

        for i, v in window.KeybindObjects do
            v:Refresh()
        end

        local allFalses = true
        local str = ""

        for i, v in objs do
            if v.Options.Value and v.Options.Reference then
                allFalses = false

                local color = v.Options.Reference.Options.Value and window.Options.Theme.Main or window.Options.Theme.Text
                local translated : string = translate(v.Options.Reference, "Text")
                if #translated == 0 then
                    translated = v.Options.Reference.Class
                end
                
                str ..= ` <font color="#{color:ToHex()}" transparency="{v.Options.Reference.Options.Disabled and 0.35 or 0}">{"[" .. gsubInput(Enum.KeyCode:FromValue(v.Options.Value).Name) .. "] " .. antiRich(translated)}</font> \n`
            end
        end

        keybindsLabel.Text = str:sub(1, -2)
        if allFalses then
            keybindsLabel.Visible = false
            return
        end

        keybindsLabel.Visible = true
    end

    drawKBL(false)
    window._Connections[#window._Connections + 1] = window.Options.KeybindMode:Connect(drawKBL)

    local settingsMainTab = window:AddTab("LibrarySettings" .. window.Flag .. "1", { Text = "Main Settings", Icon = "Cog", Order = max32 })
    local settingsConfigTab = window:AddTab("LibrarySettings" .. window.Flag .. "2", { Text = "Config Settings", Icon = "Cog", Order = max32 - 1 })
    local settingsThemeTab = window:AddTab("LibrarySettings" .. window.Flag .. "3", { Text = "Theme Settings", Icon = "Cog", Order = max32 - 2 })
    local settingsOtherTab = window:AddTab("LibrarySettings" .. window.Flag .. "4", { Text = "Other Settings", Icon = "Cog", Order = max32 - 3 })

    local current = "Main"
    local reparent

    local function tabOnTabSetup(tab)
        tab:AddButton({ Text = "Go Back", Icon = "circle-arrow-left", Callback = function()
            current = "Main"
            reparent()
        end })

        tab:AddSeparator({ Invisible = true })
    end

    tabOnTabSetup(settingsConfigTab)
    tabOnTabSetup(settingsThemeTab)
    tabOnTabSetup(settingsOtherTab)

    local db = false
    settingsMainTab:AddButton({ Icon = "Cross", Text = "Close UI", Callback = function()
        window:TryClose()
    end })

    window.Options.ToggleKeyObject = settingsMainTab:AddButton({ Icon = "Exit", Text = "Toggle UI", Callback = function()
        if window.Closed then return end
        window:Toggle()
    end })

    settingsMainTab:AddInput("ToggleKey", { Text = "Toggle UI key", Value = window.Options.Keybind, Callback = function()
        if window.Closed then return end
        window:Toggle()
    end, KeySet = function(key)
        window.Options.Keybind = key or false
    end })

    settingsMainTab:AddSeparator()

    local textList = {
        "Executor: <b>" .. window.Executor .. "</b>",
        "Executor version: <b>" .. window.ExecutorVersion .. "</b>",
        "Device: <b>" .. window.Device .. "</b>",
        "Emulator: <b>" .. (window.Emulator and "Yes" or "No") .. "</b>",
        "Library version: <b>" .. window.Version .. "</b>"
    }

    local einfo = settingsMainTab:AddLabel("EINFO", { Text = concat(textList, "\n") })

    local theOnlySeparator = settingsMainTab:AddSeparator({ Visible = false })

    local langs = { }
    local pl = settingsMainTab:AddDropdown("Language", { Text = "Language", Values = langs, Convert = false, Callback = function(val)
        window.Language = window.PossibleLanguages[val]
    end, Value = 1 })

    local cp1
    local executionTimes : number = nil

    local configString
    spawn(function()
        local fl = window.FlagHash .. "/"
        local hidden = { }
        
        local themesFailGb
        if not configsEnabled then
            settingsConfigTab:AddLabel({ Text = "Saving configs and themes are <b>unavailable in your environment</b>!" })
            settingsConfigTab:AddSeparator({ Invisible = true })
            
            themesFailGb = settingsThemeTab:AddLeftGroupbox("TMFail", { Text = "Theme Manager" })
            themesFailGb:AddLabel({ Text = "Saving configs and themes are <b>unavailable in your environment</b>!" })
            themesFailGb:AddSeparator({ Invisible = true })
        end

        local lol = settingsConfigTab:AddLabel({ Text = "Loading configs and themes functions, wait...", Visible = configsEnabled })
        local lol2 = settingsThemeTab:AddLabel({ Text = "Loading configs and themes functions, wait...", Visible = configsEnabled })
        local lol3 = settingsConfigTab:AddLabel({ Text = "Looks like your executor experienced an error loading config and themes functions\nPlease retry!", Visible = false })
        local lol4 = settingsThemeTab:AddLabel({ Text = "Looks like your executor experienced an error loading config and themes functions\nPlease retry!", Visible = false })
        
        delay(10, function()
            if lol.Visible then
                lol.Visible = false
                lol3.Visible = true
            end
            
            if lol2.Visible then
                lol2.Visible = false
                lol4.Visible = true
            end
        end)

        local loadTheme, loadConfig, getExistingConfigs, getExistingThemes
        getExistingConfigs = function()
            local configNames = { }
            for _, file in lf(configsRoute .. fl:sub(1, -2)) or { } do
                tinsert(configNames, file:sub(#configsRoute + #fl + 1, -#json - 1))
            end

            return configNames
        end

        local function validateName(name: string)
            return #name >= 1 and #name <= 32 and not name:find("\\", 1, true) and not name:find("/", 1, true)
        end

        local configRoute = configsRoute .. fl:sub(1, -2) .. "-AutoLoad" .. json
        local autosaveRoute = configsRoute .. fl:sub(1, -2) .. "-AutoSave" .. json
        local autoLoadConfig, autoSaveConfig, saveConfig
        local autoSavingEnabled = false
        local configTextBox, configDropdown, themeTextBox, themeDropdown
        local debugAutoSave = false

        if configsEnabled then
            configTextBox = settingsConfigTab:AddTextBox("ConfigName", {
                PlaceholderText = "Enter Config name",
                NoConfigs = true,
                Text = "Config Name",
                Value = "Config1",
                Visible = false,
                Instant = true,
                Callback = function(text)
                    if window.Closed or not autoLoadConfig then return end

                    if autoLoadConfig.Value then
                        wf(configRoute, { text })
                    else
                        wf(configRoute, false)
                    end
                end
            })
            hidden[#hidden + 1] = configTextBox

            configDropdown = settingsConfigTab:AddDropdown("ConfigsList", {
                Text = "Saved Configs",
                AllowUnselect = true,
                NoConfigs = true,
                Callback = function(text)
                    if window.Closed then return end
                    configTextBox.Value = text or ""
                end,
                Visible = false
            })
            hidden[#hidden + 1] = configDropdown

            function saveConfig(notifs)
                if window.Closed then return end
                
                local old = autoSavingEnabled
                autoSavingEnabled = nil

                local name = configTextBox.Value
                if not validateName(name) then
                    if notifs then
                        return window:Notification({ Title = "Error", Text = "Invalid config name. Use 1–32 characters, no \\ or /" })
                    else
                        configTextBox.Value = "Config1"
                        name = "Config1"
                    end
                end

                local route = configsRoute .. fl .. name .. json
                if notifs and IF(route) then if not window:Notification({ Side = "Left", Title = "Config Exists", Text = "Config '" .. name .. "' already exists!\nDo you want to overwrite it?", HasButtons = true, Duration = 10 }) then return end end

                wf(route, window:GetConfigString(), true)
                configDropdown.Values = getExistingConfigs()
                
                if autoSavingEnabled == nil then
                    autoSavingEnabled = old
                end

                if notifs then
                    window:Notification({ Side = "Left", Title = "Success", Text = "Config '" .. name .. "' has been saved!" })
                end
            end

            hidden[#hidden + 1] = settingsConfigTab:AddButton({
                Text = "Save Config",
                NoConfigs = true,
                Icon = "Save",
                Callback = function()
                    saveConfig(true)
                end,
                Visible = false
            })

            loadConfig = function(name)
                if window.Closed then return end
                if not validateName(name) then return window:Notification({ Title = "Error", Text = "Invalid config name. Use 1–32 characters, no \\ or /" }) end

                autoSavingEnabled = false

                local route = configsRoute .. fl .. name .. json
                if not IF(route) then
                    autoSavingEnabled = true
                    return window:Notification({ Title = "Error", Text = "Config '" .. name .. "' does not exist" })
                end

                local data = rf(route, false)
                if data then
                    local _, s = window:SetConfigString(data)
                    if not s then
                        -- window:SetConfig(data)
                        autoSavingEnabled = true
                        return
                    end

                    window:Notification({ Title = "Success", Text = "Config '" .. name .. "' has been successfully loaded!" })
                else
                    window:Notification({ Title = "Error", Text = "Invalid config file" })
                end

                autoSavingEnabled = true
            end

            hidden[#hidden + 1] = settingsConfigTab:AddButton({
                Text = "Load Config",
                NoConfigs = true,
                Icon = "Config",
                Callback = function()
                    if window.Closed then return end
                    loadConfig(configTextBox.Value)
                end,
                Visible = false
            })

            hidden[#hidden + 1] = settingsConfigTab:AddButton({
                Text = "Delete Config",
                NoConfigs = true,
                Icon = "Trash",
                Callback = function()
                    if window.Closed then return end
                    local name = configTextBox.Value
                    if not validateName(name) then return window:Notification({ Title = "Error", Text = "Invalid config name. Use 1–32 characters, no \\ or /" }) end

                    local route = configsRoute .. fl .. name .. json
                    if not IF(route) then return window:Notification({ Title = "Error", Text = "Config '" .. name .. "' does not exist" }) end

                    if window:Notification({ Side = "Left", Title = "Delete Config", Text = "Are you sure you want to delete config '" .. name .. "'?", HasButtons = true, Duration = 10 }) then
                        df(route)
                        configDropdown.Values = getExistingConfigs()

                        window:Notification({ Side = "Left", Title = "Success", Text = "Config '" .. name .. "' has been successfully deleted!" })
                    end
                end,
                Visible = false
            })

            autoLoadConfig = settingsConfigTab:AddToggle("AutoLoadConfig", {
                Text = "Auto Load Config",
                Value = true,
                NoConfigs = true,
                Callback = function(value)
                    if window.Closed then return end
                    if value then
                        wf(configRoute, { configTextBox.Value })
                    else
                        wf(configRoute, false)
                    end
                end,
                Visible = false
            })

            autoSaveConfig = settingsConfigTab:AddToggle("AutoSaveConfig", {
                Text = "Auto Save Config",
                Value = false,
                Callback = function(value)
                    if window.Closed then return end
                    wf(autosaveRoute, value)
                end,
                NoConfigs = true,
                Visible = false
            })

            hidden[#hidden + 1] = autoLoadConfig
            hidden[#hidden + 1] = autoSaveConfig
            hidden[#hidden + 1] = settingsConfigTab:AddSeparator({ Invisible = true, Visible = false })
        end
        
        local first = true
        configString = settingsConfigTab:AddTextBox("ConfigString", {
            NoConfigs = true,
            Instant = true,
            Text = "Config Share string",
            Callback = function(text)
                if first then
                    first = false
                    return
                end
                
                if window.Closed then return end

                if text ~= window:GetConfigString() then
                    autoSavingEnabled = false
                    local succeed, succeed2 = window:SetConfigString(text)
                    autoSavingEnabled = true
                    if not succeed and clean(text) ~= "" and text ~= "Code expired" then
                        window:Notification({ Title = "Error", Text = "Invalid config share string!" })
                    elseif succeed2 then
                        window:Notification({ Title = "Success", Text = "Config 'SharedString' has been successfully loaded!" })
                    end
                end
            end
        })

        window._Connections[#window._Connections + 1] = configString.Instance.View.Bar.Focused:Connect(function()
            configString.Value = window:GetConfigString()
            configString.Changed:Fire()
        end)

        local changed = false
        spawn(function()
            while wait(0.25 + render()) and not window.Closed do
                if changed then
                    configString.Value = window:GetConfigString()
                    configString.Changed:Fire()
                    changed = false

                    if saveConfig and autoSavingEnabled and not db and autoSaveConfig.Value and not window.Closed then
                        defer(saveConfig, debugAutoSave)
                    end
                end
            end
        end)

        local function trackChanges(obj)
            if obj == configString then return end

            local options = obj.Options
            window._Connections[#window._Connections + 1] = obj.Changed:Connect(function()
                if not changed and not options.NoConfigs then
                    changed = true
                end
            end)
            
            changed = true
        end

        for i, v in window.AllObjects do
            _pcall(trackChanges, v)
        end

        window._Connections[#window._Connections + 1] = window.ObjectAdded:Connect(function(v)
            _pcall(trackChanges, v)
        end)

        if toclip then
            settingsConfigTab:AddButton({
                Text = "Copy Code",
                Tooltip = "If code is not generated, you can still click that button, so code generates automatically!",
                Callback = function()
                    if window.Closed then return end

                    configString.Value = window:GetConfigString()
                    configString.Changed:Fire()
                    toclip(configString.Value)
                    window:Notification({ Title = "Copied", Text = "Code copied to clipboard!" })
                end
            })
        end

        getExistingThemes = function()
            local themeNames = { }
            for _, file in lf(themesRoute:sub(1, -2)) or { } do
                tinsert(themeNames, file:sub(#themesRoute + 1, -#json - 1))
            end

            return themeNames
        end

        local autoLoadTheme
        local themeRoute = themesRoute:sub(1, -3) .. "-AutoLoad" .. json

        if configsEnabled then
            local themeManager = settingsThemeTab:AddLeftGroupbox("TM", { Text = "Theme Manager", Visible = false })
            hidden[#hidden + 1] = themeManager
            
            themeTextBox = themeManager:AddTextBox("ThemeName", {
                PlaceholderText = "Enter Theme name",
                NoConfigs = true,
                Text = "Theme Name",
                Instant = true,
                Callback = function(text)
                    if window.Closed then return end

                    if autoLoadTheme.Value then
                        wf(themeRoute, { text })
                    else
                        wf(themeRoute, false)
                    end
                end
            })

            themeDropdown = themeManager:AddDropdown("ThemesList", {
                Text = "Saved Themes",
                AllowUnselect = true,
                NoConfigs = true,
                Callback = function(text)
                    if window.Closed then return end

                    local text = text or ""
                    themeTextBox.Value = text

                    if text ~= "" then
                        loadTheme(text)
                    end
                end
            })

            themeManager:AddButton({
                Text = "Save Theme",
                NoConfigs = true,
                Icon = "Save",
                Callback = function()
                    if window.Closed then return end
                    
                    local name = themeTextBox.Value
                    if not validateName(name) then return window:Notification({ Title = "Error", Text = "Invalid theme name. Use 1–32 characters, no \\ or /" }) end
                    
                    local route = themesRoute .. name .. json
                    if IF(route) then if not window:Notification({ Side = "Left", Title = "Theme Exists", Text = "Theme '" .. name .. "' already exists!\nDo you want to overwrite it?", HasButtons = true, Duration = 10 }) then return end end

                    wf(route, window:GetThemeString(), true)
                    themeDropdown.Values = getExistingThemes()

                    window:Notification({ Side = "Left", Title = "Success", Text = "Theme '" .. name .. "' has been saved!" })
                end
            })

            loadTheme = function(name)
                if window.Closed then return end
                if not validateName(name) then return window:Notification({ Title = "Error", Text = "Invalid theme name. Use 1–32 characters, no \\ or /" }) end

                local route = themesRoute .. name .. json
                if not IF(route) then return window:Notification({ Title = "Error", Text = "Theme '" .. name .. "' does not exist" }) end

                local data = rf(route, false)
                if data then
                    if not window:SetThemeString(data) then
                        window:SetTheme(data)
                    end

                    cp1.Value = window.Theme.Main
                    window:Notification({ Title = "Success", Text = "Theme '" .. name .. "' has been successfully loaded!" })
                else
                    window:Notification({ Title = "Error", Text = "Invalid theme file" })
                end
            end

            themeManager:AddButton({
                Text = "Load Theme",
                Icon = "Star",
                Callback = function()
                    if window.Closed then return end
                    loadTheme(themeTextBox.Value)
                end
            })

            themeManager:AddButton({
                Text = "Delete Theme",
                Icon = "Trash",
                Callback = function()
                    if window.Closed then return end

                    local name = themeTextBox.Value
                    if not validateName(name) then return window:Notification({ Title = "Error", Text = "Invalid theme name. Use 1–32 characters, no \\ or /" }) end

                    local route = themesRoute .. name .. json
                    if not IF(route) then return window:Notification({ Title = "Error", Text = "Theme '" .. name .. "' does not exist" }) end

                    if window:Notification({ Side = "Left", Title = "Delete Theme", Text = "Are you sure you want to delete theme '" .. name .. "'?", HasButtons = true, Duration = 10 }) then
                        df(route)
                        themeDropdown.Values = getExistingThemes()

                        window:Notification({ Side = "Left", Title = "Success", Text = "Theme '" .. name .. "' has been successfully deleted!" })
                    end
                end
            })

            autoLoadTheme = themeManager:AddToggle("AutoLoadTheme", {
                Text = "Auto Load Theme",
                Value = false,
                NoConfigs = true,
                Callback = function(value)
                    if window.Closed then return end

                    if value then
                        wf(themeRoute, { themeTextBox.Value })
                    else
                        wf(themeRoute, false)
                    end
                end,
            })
            
            themeManager:AddSeparator({ Invisible = true })

            themeManager:AddButton({
                Text = "Restore Default Themes",
                Icon = "l://circle-fading-plus",
                Callback = function(self)
                    if window:InWindowNotification({ Title = "Restore Themes", Text = "Themes with matching names will be overwritten\nContinue?", HasButtons = true }) then
                        self.Disabled = true
                        
                        local c, t = 0, 0
                        for i, v in premadeThemes do
                            c += 1
                            
                            spawn(function()
                                wf(themesRoute .. i .. json, v, true)
                                t += 1
                            end)
                        end
                        
                        while c == 0 or t < c or window.Closed do wait() end
                        if not window.Closed then
                            themeDropdown.Values = getExistingThemes()
                            self.Disabled = false
                            
                            window:Notification({ Title = "Themes Restored", Text = "Successfully restored themes!" })
                        end
                    end
                end
            })
        end
        
        local themeStringGb = settingsThemeTab:AddRightGroupbox("TS", { Text = "Theme String" })
        local themeString = themeStringGb:AddTextBox("ThemeString", {
            NoConfigs = true,
            Instant = true,
            Text = "Theme Share string",
            Callback = function(text)
                if window.Closed then return end

                if text ~= window:GetThemeString() then
                    if not window:SetThemeString(text) and clean(text) ~= "" then
                        window:Notification({ Title = "Error", Text = "Invalid share string!" })
                    end
                end
            end
        })

        window._Connections[#window._Connections + 1] = themeString.Instance.View.Bar.Focused:Connect(function()
            themeString.Value = window:GetThemeString()
        end)

        themeStringGb:AddButton({
            Text = "Copy Code",
            Callback = function()
                themeString.Value = window:GetThemeString()
                toclip(themeString.Value)

                window:Notification({ Title = "Copied", Text = "Code copied to clipboard!" })
            end,
            Disabled = not toclip,
            DisabledTooltip = "Your executor does not support that function"
        })

        if configsEnabled then
            executionTimes = readTimes(configsRoute .. fl:sub(1, -2) .. "-Runs")

            local cn = configTextBox.Value
            nf(configRoute, cn ~= "" and { cn } or false)
            nf(autosaveRoute, true)
            nf(themeRoute, false)
            mf(configsRoute .. fl:sub(1, -2))

            configDropdown.Values = getExistingConfigs()
            themeDropdown.Values = getExistingThemes()

            local cont = rf(themeRoute, true)
            if typeof(cont) == "table" then
                autoLoadTheme.Value = true
                themeTextBox.Value = cont[1]
                defer(loadTheme, cont[1])
            end

            local cont = rf(configRoute, true)
            autoSaveConfig.Value = rf(autosaveRoute, true)

            if typeof(cont) == "table" then
                autoLoadConfig.Value = true
                configTextBox.Value = cont[1]
                delay(1 + render(), function()
                    if window.Options._ksa then
                        while window.Options._ksa do
                            wait()
                        end
                        
                        wait(1 + render())
                    end

                    if window.Closed then return end
                    loadConfig(cont[1])
                end)
            else
                delay(1 + render(), function()
                    if window.Options._ksa then
                        while window.Options._ksa do
                            wait()
                        end

                        wait(1 + render())
                    end
                    
                    if window.Closed then return end
                    autoSavingEnabled = true
                end)
            end
        else
            executionTimes = 1.1
        end

        window._Connections[#window._Connections + 1] = window.ThemeChanged:Connect(function()
            themeString.Value = window:GetThemeString()
        end)

        themeString.Value = window:GetThemeString()

        if configsEnabled then
            if ranTimes <= 1 then
                for i, v in premadeThemes do
                    spawn(function()
                        wf(themesRoute .. i .. json, v, true)
                        themeDropdown.Values = getExistingThemes()
                    end)
                end
            end

            lol.Visible = false
            lol2.Visible = false
            lol3.Visible = false
            lol4.Visible = false
            
            for i, v in hidden do
                v.Visible = true
            end
        else
            themesFailGb:AddDropdown("ThemesList2", {
                Text = "Premade Themes",
                AllowUnselect = true,
                NoConfigs = true,
                Values = (function() local ret = { } for i in premadeThemes do ret[#ret + 1] = i end tsort(ret) return ret end)(),
                Callback = function(text)
                    if window.Closed then return end
                    window:SetThemeString(premadeThemes[text])
                end
            })
        end
    end)

    local themeObjects = { }
    
    local themeEditorGb = settingsThemeTab:AddRightGroupbox("TE", { Text = "Theme Editor" })
    local theme = themeEditorGb:AddLabel({ Text = "Theme" })
    themeObjects.Main = theme:AddColorPicker({ NoConfigs = true })
    themeObjects.Text = theme:AddColorPicker({ NoConfigs = true })
    themeObjects.Stroke = theme:AddColorPicker({ NoConfigs = true })
    themeObjects.Back = theme:AddColorPicker({ NoConfigs = true })

    for i, v in themeObjects do
        v.Value = window.Theme[i]
        v.Tooltip = i .. " Color"
        v.Callback = function(color)
            if window.Closed then return end

            window.Theme[i] = color
            window:Refresh()
        end
    end

    local toggle, toggle2
    local targetColor = window.Options.Theme.Main

    local function reverseRGB(color)
        return C3n(1 - color.R, 1 - color.G, 1 - color.B)
    end

    local function rotateRGB(color, pattern)
        if not pattern then
            pattern = { "R", "G", "B" }

            while pattern[1] == "R" and pattern[2] == "G" do
                for i = 1, 3 do
                    local i1, i2 = mrandom(1, 3), mrandom(1, 3)
                    pattern[i], pattern[i1] = pattern[i1], pattern[i]
                end
            end
        end

        local new = { }
        for i = 1, 3 do
            new[i] = color[pattern[i]]
        end

        return C3n(unpack(new)), pattern
    end

    local warned = false
    local db2 = false

    local function n()
        if not warned then
            if db then
                return true
            end

            db2 = true
            local res = window:InWindowNotification({ Title = "Theme Generator", Text = "This gonna reset your current theme!\nAre you sure" .. (mrandom(1, 10) == 1 and " you wanna accept being uncreative?\n\n(an easter egg btw)" or "?"), HasButtons = true })
            db2 = false

            if res then
                warned = true
            else
                return true
            end
        end

        return false
    end

    local btn = themeEditorGb:AddButton("ThemeGenerator", { Text = "Theme Generator", Icon = "Brush", Tooltip = "Generates a theme\n<b>NOTE:</b> Randomly generated themes are not perfect and can look bad!", Callback = function()
        if n() then return end

        targetColor = cp1.Value
        local mainColor = not toggle2.Value and targetColor

        if not mainColor then
            mainColor = C3n(mrandom(), mrandom(), mrandom())
        else
            mainColor = targetColor:Lerp(C3n(mrandom(), mrandom(), mrandom()), mrandom() / 10)
        end

        mainColor = C3n(clamp(mainColor.R + ((mrandom() - 0.5) / 7.5), 0, 1), clamp(mainColor.G + ((mrandom() - 0.5) / 7.5), 0, 1), clamp(mainColor.B + ((mrandom() - 0.5) / 7.5), 0, 1))

        local isLight = toggle.Value

        local n = mrandom()
        local strokeColor = mainColor:Lerp(C3n(n, n, n), 1 - clamp(mrandom() / n, 0, 1))
        local textColor = mainColor:Lerp(isLight and C3n() or C3n(1, 1, 1), (mrandom() + 1.5) / 2.5)

        local backTone = mainColor:Lerp(isLight and C3n(1, 1, 1) or C3n(), mrandom())
        local backColor = backTone:Lerp(isLight and C3n(1, 1, 1) or C3n(), (mrandom() + 1) / 2)

        if abs((backColor.R + backColor.G + backColor.B) - (textColor.R + textColor.G + textColor.B)) <= 0.2 then
            textColor = textColor:Lerp(isLight and C3n() or C3n(1, 1, 1), (mrandom() + 1) / 2)
        end

        local closest = abs((strokeColor.R + strokeColor.G + strokeColor.B) - (textColor.R + textColor.G + textColor.B)) <= 0.4 and "Text" or
            abs((strokeColor.R + strokeColor.G + strokeColor.B) - (backColor.R + backColor.G + backColor.B)) <= 0.2 and "Back" or
            abs((strokeColor.R + strokeColor.G + strokeColor.B) - (mainColor.R + mainColor.G + mainColor.B)) <= 0.3 and "Main" or
            false

        if closest then
            strokeColor = strokeColor:Lerp(closest == "Text" and textColor or closest == "Back" and backColor or mainColor:Lerp(not isLight and C3n() or C3n(1, 1, 1), (mrandom() + 1.5) / 2.5), (mrandom() + 2) / 3)
        end

        window.Options.Theme.Main = mainColor
        window.Options.Theme.Text = textColor
        window.Options.Theme.Stroke = strokeColor
        window.Options.Theme.Back = backColor

        window:Refresh()
    end })

    toggle = themeEditorGb:AddCheckBox("LightMode", { Text = "Light Mode", Value = false, NoConfigs = true })
    toggle2 = themeEditorGb:AddCheckBox("UseRandomColor", { Text = "Use Random Color", Value = false, NoConfigs = true, Callback = function(value)
        cp1.Disabled = value
    end })

    cp1 = btn:AddColorPicker({ NoConfigs = true, Value = targetColor, Tooltip = "Target color" })

    themeEditorGb:AddButton("RotateTheme", { Text = "Change Primary Color", Icon = "Repeat", Callback = function()
        if n() then return end

        local pattern
        for i, v in window.Options.Theme do
            local col, p = rotateRGB(v, pattern)
            if not pattern then
                pattern = p
            end

            window.Options.Theme[i] = col
        end

        window:Refresh()
    end })

    settingsOtherTab:AddHeader({ Text = "Info Label" })

    local infoLabelObjs = { }
    local sil = settingsOtherTab:AddToggle("ShowInfoLabel", { Text = "Show Info Label", Value = window.Options.InfoLabel.Options.Visible, Callback = function(val)
        window.Options.InfoLabel.Visible = val
        window.Options.InfoLabel:Refresh()

        for _, v in infoLabelObjs do
            v.Disabled = not val
        end
    end })

    settingsOtherTab:AddSeparator()

    for _, i in { "ShowExecutor", "ShowFPS", "ShowPing", "ShowTime", "ShowPlayers", "", "ShowGaps", "ExtraInfoLabelTextEnabled" } do
        if i == "" then
            settingsOtherTab:AddSeparator()
        else
            infoLabelObjs[i] = settingsOtherTab:AddCheckBox("InfoLabel" .. i, { Text = otherLib:Smart(i) .. " in info label", Value = window.Options.InfoLabel.Options[i], Callback = function(val)
                if i ~= "ExtraInfoLabelTextEnabled" then
                    window.Options.InfoLabel[i] = val
                else
                    window.Options[i] = val
                end
            end, Disabled = true })
        end
    end
    
    local ilgb = settingsThemeTab:AddLeftGroupbox("IL", { Text = "Info Label" })
    local ile = ilgb:AddTextBox({ PlaceholderText = "Manual Info Label extra text", MultiLine = true, Instant = true, NoConfigs = true, Value = window.Options.InfoLabelExtra or "", Text = "Info label extra text", Callback = function(val)
        window.Options.InfoLabelExtra = val
    end })

    local ilear = ilgb:AddToggle({ Text = "Enable Rich Text for extra text", NoConfigs = true, Value = window.Options.InfoLabelExtraAntiRich, Callback = function(val)
        window.Options.InfoLabelExtraAntiRich = val
    end })

    local uidecs = settingsThemeTab:AddRightGroupbox("UID", { Text = "UI Decorations" })

    local lmt, rest, mt
    local ss = uidecs:AddSlider({ Text = "Shadow Size", NoConfigs = true, Value = window.Options.ShadowSize, Callback = function(val)
        window.ShadowSize = val
    end, Min = 0, Max = 100, Step = 1, Format = "+" })
    local so = uidecs:AddSlider({ Text = "Shadow Opacity", NoConfigs = true, Value = 1 - window.Options.ShadowTransparency, Callback = function(val)
        window.ShadowTransparency = 1 - val
    end, Min = 0, Max = 1, Step = 0, Format = ".%" })
    local bo = uidecs:AddSlider({ Text = "Background Opacity", NoConfigs = true, Value = 1 - window.Options.BackgroundTransparency, Callback = function(val)
        window.BackgroundTransparency = 1 - val
    end, Min = 0, Max = 1, Step = 0, Format = ".%" })

    uidecs:AddSeparator({ Invisible = true })

    local cr = uidecs:AddSlider({ Text = "Window Round Corner radius", NoConfigs = true, Value = window.Options.CornerRadius, Callback = function(val)
        window.CornerRadius = val * 100
    end, Min = 0, Max = 1, Step = 0, Format = ".%" })
    local re = uidecs:AddToggle({ Text = "Round Everything", NoConfigs = true, Value = window.Options.RoundEverything, Callback = function(val)
        window.RoundEverything = val
    end })
    rest = uidecs:AddToggle({ Text = "Remove Strokes", NoConfigs = true, Value = window.Options.NoStrokes, Callback = function(val)
        window.NoStrokes = val
        mt.Disabled = val
        lmt.Disabled = not rest.Value and not mt.Value
    end })
    
    local togglesGb = settingsThemeTab:AddLeftGroupbox("TGB", { Text = "Toggles" })

    mt = togglesGb:AddToggle({ Text = "Modern Toggles", NoConfigs = true, Value = window.Options.ModernToggles, Callback = function(val)
        window.ModernToggles = val
        lmt.Disabled = not rest.Value and not mt.Value
    end })
    lmt = togglesGb:AddToggle({ Text = "Large Modern Toggles", Tooltip = "In GroupBoxes (like this one toggle here), size won't change!", NoConfigs = true, Value = window.Options.LargeModernToggles, Callback = function(val)
        window.LargeModernToggles = val
    end })

    lmt.Disabled = not rest.Value and not mt.Value
    
    local blursGb = settingsThemeTab:AddLeftGroupbox("BGB", { Text = "Blurs" })
    
    local bs, fbs
    local bbg = blursGb:AddToggle("BlurBackground", { Text = "Blur Behind UI", Tooltip = "<b>NOT ALWAYS WORKING</b>\nUsually high quality required for this feature to work", NoConfigs = true, Value = window.Options.BlurBackground, Callback = function(val)
        window.BlurBackground = val

        bs.Disabled = not val
        fbs.Disabled = not val
    end })

    bs = blursGb:AddSlider({ Text = "Blur Intensity", NoConfigs = true, Value = uiBackBlur.BlurSize, Callback = function(val)
        uiBackBlur.BlurSize = val
    end, Min = 0, Max = 1, Step = 0, Format = ".%" })

    fbs = blursGb:AddToggle("FullBlurSize", { Text = "Full UI-Sized Blur", NoConfigs = true, Value = window.Options.BlurBackground, Callback = function(val)
        window.FullBlurSize = val
    end })

    bs.Disabled = not bbg.Value
    fbs.Disabled = not bbg.Value
    
    blursGb:AddSeparator()
    
    local bp
    local uib = blursGb:AddToggle("UIBlur", { Text = "UI Blurring Enabled", NoConfigs = true, Value = window.Options.EnableUIBlur, Callback = function(val)
        window.EnableUIBlur = val
        bp.Disabled = not val
    end })
    
    bp = blursGb:AddToggle("BlurProfile", { Text = "Blur Profile", Tooltip = "NOTE: Profile is visible only in some scripts, so often that feature does nothing!", NoConfigs = true, Value = window.Options.EnableUIBlur, Callback = function(val)
        window.BlurProfile = val
    end })

    bp.Disabled = not uib.Value

    local backgroundImgGb = settingsThemeTab:AddRightGroupbox("BGIMG", { Text = "Background Image" })

    local bie = backgroundImgGb:AddToggle({ Text = "Enabled", NoConfigs = true, Value = window.Options.ImageEnabled, Callback = function(val)
        window.ImageEnabled = val
    end })
    local bic = bie:AddColorPicker({ Value = window.Options.ImageColor, Tooltip = "Image Color", Callback = function(color)
        window.ImageColor = color
    end, NoConfigs = true })

    local io = backgroundImgGb:AddSlider({ Text = "Opacity", NoConfigs = true, Value = 1 - window.Options.ImageTransparency, Callback = function(val)
        window.ImageTransparency = 1 - val
    end, Min = 0, Max = 1, Step = 0, Format = ".%" })
    local bi; bi = backgroundImgGb:AddTextBox({ PlaceholderText = gca and "Image <b>URL, rbxassetid://...</b> or <b>image ID</b>" or "<b>rbxassetid://...</b> or <b>image ID</b>", NoConfigs = true, Value = window.Options.Image, Text = "Image", Callback = function(val)
        window.Image = val
    end })

    local backgroundsConverted = { }
    for i in backgrounds do
        tinsert(backgroundsConverted, otherLib:Smart(i))
    end

    tsort(backgroundsConverted)

    backgroundImgGb:AddDropdown({ Text = "Select an Image", NoConfigs = true, Values = backgroundsConverted, AllowUnselect = true, Callback = function(val, _, self)
        bi:Set(((val or ""):gsub(" ", "")))
    end })

    local outlineGb = settingsThemeTab:AddLeftGroupbox("NGB", { Text = "Outlines/Neons" })
    local nt = outlineGb:AddSlider({ Text = "Neon Thickness", Value = window.Options.NeonThickness, Callback = function(val)
        window.NeonThickness = val
    end, Min = 0, Max = 5, Step = 1, Format = "+", NoConfigs = true })

    local neonTypes = {
        "Stroke",
        "Top",
        "None"
    }

    local nt2 = outlineGb:AddDropdown({ Text = "Neon Type", NoConfigs = true, Convert = true, Values = neonTypes, Callback = function(val)
        window.Options.NeonType = val
        window:Refresh()
    end, Value = tfind(neonTypes, window.Options.NeonType) or 1 })

    local ots = outlineGb:AddToggle("OutsideStroke", { Text = "Outside Outline enabled", Value = window.Options.OutsideStroke, Callback = function(val)
        window.OutsideStroke = val
    end })

    settingsOtherTab:AddHeader({ Text = "Other" })
    local um = settingsOtherTab:AddToggle("UnlockMouse", { Text = "Unlock Mouse", Value = window.Options.UnlockMouse, Callback = function(val)
        window.Options.UnlockMouse = val
    end })

    local sides = {
        "Left",
        "Right"
    }
    
    local notificationsGb = settingsThemeTab:AddLeftGroupbox("NsGB", { Text = "Notifications" })
    local ns = notificationsGb:AddDropdown("NotificationSide", { Text = "Notifications Default side", NoConfigs = true, Values = sides, Callback = function(val)
        if window.Closed then return end
        window.Options.NotificationSide = val
        window:Notification({ Title = "This is a notification!", Text = "<b>" .. val .. "</b> side!", Duration = 2.5 + (mrandom() * 2.5) })
    end, Value = tfind(sides, window.Options.NotificationSide) or 1 })

    local nos = notificationsGb:AddCheckBox("NotificationOG", { Text = "Use Legacy Notification window size", NoConfigs = true, Value = window.Options.NotificationOgScaling, Callback = function(val)
        window.NotificationOgScaling = val
        if window.Closed then return end

        local randomText = ""
        for i = 1, mrandom(1, mrandom(2, mrandom(3, 4))) do
            randomText ..= "Line <b>" .. i .. "</b>\n"
        end

        window:Notification({ Title = "This is a notification!", Text = randomText:sub(1, -2) })
    end })
    
    local otherGb = settingsThemeTab:AddRightGroupbox("OGB", { Text = "Other" })
    local as = otherGb:AddSlider("AnimationSpeed", { Text = "Animation Speeds", NoConfigs = true, Value = window.Options.AnimationSpeed, Callback = function(val)
        window.AnimationSpeed = val
    end, Min = 0.7, Max = 10, Step = 0.1, Format = ".%" })

    local mv = otherGb:AddSlider("MasterVolume", { Text = "UI Master Volume", NoConfigs = true, Value = window.Options.Volume, Callback = function(val)
        window.Volume = val
        playSound("Test", window)
    end, Min = 0, Max = 200, Step = 1, Format = "%" })

    local mbGb = settingsThemeTab:AddLeftGroupbox("MB", { Text = "Mobile Button" })
    local mb = mbGb:AddToggle("MobileButton", { Text = "Show Mobile Button", NoConfigs = true, Tooltip = "Shows mobile button when UI is minimized", Value = window.Options.MobileButtonVisible, Callback = function(val)
        window.MobileButtonVisible = val
    end, Visible = window.IsDesktop })

    local amb = mbGb:AddToggle("AlwaysMobileButton", { Text = "Always Show Mobile Button", NoConfigs = true, Value = window.Options.MobileButtonAlwaysVisible, Callback = function(val, self)
        window.MobileButtonAlwaysVisible = val
        mb.Disabled = self.Value
    end, Visible = window.IsDesktop })

    local mbn = mbGb:AddToggle("MobileButtonNeon", { Text = "Show Mobile Button neon", NoConfigs = true, Value = window.Options.MobileButtonNeon, Callback = function(val)
        window.MobileButtonNeon = val
    end })

    settingsOtherTab:AddButton({ Icon = "UI", Text = "Open Console", Callback = function()
        game:GetService("StarterGui"):SetCore("DevConsoleVisible", true)
    end })

    --

    local pr = window.Options.Image
    local function upd()
        if window.Closed or not window.Options.InfoLabel then return end

        ss.Value = window.Options.ShadowSize
        so.Value = 1 - window.Options.ShadowTransparency
        bo.Value = 1 - window.Options.BackgroundTransparency
        io.Value = 1 - window.Options.ImageTransparency
        nt.Value = window.Options.NeonThickness
        nt2.Value = tfind(neonTypes, window.Options.NeonType) or 1
        um.Value = window.Options.UnlockMouse
        ns.Value = tfind(sides, window.Options.NotificationSide) or 1
        as.Value = window.Options.AnimationSpeed
        pl.Visible = #window.PossibleLanguages > 1
        theOnlySeparator.Visible = pl.Visible
        bie.Value = window.Options.ImageEnabled
        bic.Value = window.Options.ImageColor
        mb.Options.Value = window.Options.MobileButtonVisible
        amb.Value = window.Options.MobileButtonAlwaysVisible
        mb.Disabled = amb.Options.Value
        mv.Value = window.Options.Volume
        nos.Value = window.Options.NotificationOgScaling
        ile.Value = window.Options.InfoLabelExtra
        ots.Value = window.Options.OutsideStroke
        cr.Value = window.Options.CornerRadius / 100
        bbg.Value = window.Options.BlurBackground
        sil.Value = window.Options.InfoLabel.Options.Visible
        fbs.Value = window.Options.FullBlurSize
        bs.Value = uiBackBlur.BlurSize
        re.Value = window.Options.RoundEverything
        rest.Value = window.Options.NoStrokes
        mt.Value = window.Options.ModernToggles
        mt.Disabled = window.Options.NoStrokes
        mt.Disabled = rest.Options.Value
        lmt.Disabled = not rest.Value and not mt.Value
        lmt.Value = window.Options.LargeModernToggles
        mbn.Value = window.Options.MobileButtonNeon
        ilear.Value = window.Options.InfoLabelExtraAntiRich
        uib.Value = window.Options.EnableUIBlur
        bp.Value = window.Options.BlurProfile
        bp.Disabled = not uib.Value
        bs.Disabled = not bbg.Value
        fbs.Disabled = not bbg.Value

        for i, v in infoLabelObjs do
            if i == "ExtraInfoLabelTextEnabled" then
                v.Value = window.Options[i]
            else
                v.Value = window.Options.InfoLabel.Options[i]
            end
        end

        for i, v in themeObjects do
            v.Value = window.Theme[i]
        end

        if window.Options.Image ~= pr then
            pr = window.Options.Image
            bi.Value = window.Options.Image
        end

        tclear(langs)
            
        for i, v in window.PossibleLanguages do
            local v = window.Languages[v]
            if not v then
                tremove(window.PossibleLanguages, i)
                break
            end
                
            tinsert(langs, v[3] .. " " .. v[1] .. " (" .. v[2] .. ")")
        end

        pl:Refresh()
        pl.Value = tfind(window.PossibleLanguages, window.Language) or 1
    end

    window._Connections[#window._Connections + 1] = window.LanguageAdded:Connect(upd)
    window._Connections[#window._Connections + 1] = window.ThemeChanged:Connect(function()
        window.KeybindMode:Fire(window.KeybindModeActive)
        upd()
    end)

    window._Connections[#window._Connections + 1] = configString.Changed:Connect(upd)

    local function addTabToTab(name, icon)
        settingsMainTab:AddButton({ Text = "Go to " .. name .. " Settings page", Tooltip = name, Callback = function()
            current = name
            reparent()
        end, Icon = icon })
    end

    settingsMainTab:AddSeparator({ Invisible = true })
    settingsMainTab:AddButton({ Text = "Toggle Keybind editing mode", Callback = function()
        window.Options.KeybindMode:Fire(not window.KeybindModeActive)
    end })

    settingsMainTab:AddSeparator({ Invisible = true })
    addTabToTab("Theme", "Brush")
    addTabToTab("Config", "Cog")
    addTabToTab("Other", "Config")

    local c1, c2, c3, c4, c5, c6, c7, c8
    function reparent()
        settingsMainTab.Holder.Visible = current == "Main"
        settingsConfigTab.Holder.Visible = current == "Config"
        settingsThemeTab.Holder.Visible = current == "Theme"
        settingsOtherTab.Holder.Visible = current == "Other"

        if window.Closed then
            if c1 then c1:Disconnect() end
            if c2 then c2:Disconnect() end
            if c3 then c1:Disconnect() end
            if c4 then c2:Disconnect() end
            if c5 then c1:Disconnect() end
            if c6 then c2:Disconnect() end
            if c7 then c1:Disconnect() end
            if c8 then c2:Disconnect() end
            return
        end
    end

    c1 = settingsMainTab.Holder.Changed:Connect(function()
        settingsMainTab.Holder.Size = U2n(1, 0, 1, -1)
        settingsMainTab.Holder.Position = U2o(0, 1)
        settingsMainTab.Holder.ZIndex = 42
        safeReparent(settingsMainTab.Holder, window.Window.RealWindow.Contents.SettingsBlur.Downsampler.SettingsOverlay.SettingsHub)
        reparent()
    end)

    c2 = settingsMainTab.TabButton.Changed:Connect(function()
        safeReparent(settingsMainTab.TabButton, nil)
        reparent()
    end)

    c3 = settingsConfigTab.Holder.Changed:Connect(function()
        settingsConfigTab.Holder.Size = U2n(1, 0, 1, -1)
        settingsConfigTab.Holder.Position = U2o(0, 1)
        settingsConfigTab.Holder.ZIndex = 42
        safeReparent(settingsConfigTab.Holder, window.Window.RealWindow.Contents.SettingsBlur.Downsampler.SettingsOverlay.SettingsHub)
        reparent()
    end)

    c4 = settingsConfigTab.TabButton.Changed:Connect(function()
        safeReparent(settingsConfigTab.TabButton, nil)
        reparent()
    end)

    c5 = settingsThemeTab.Holder.Changed:Connect(function()
        settingsThemeTab.Holder.Size = U2n(1, 0, 1, -1)
        settingsThemeTab.Holder.Position = U2o(0, 1)
        settingsThemeTab.Holder.ZIndex = 42
        safeReparent(settingsThemeTab.Holder, window.Window.RealWindow.Contents.SettingsBlur.Downsampler.SettingsOverlay.SettingsHub)
        reparent()
    end)

    c6 = settingsThemeTab.TabButton.Changed:Connect(function()
        safeReparent(settingsThemeTab.TabButton, nil)
        reparent()
    end)

    c7 = settingsOtherTab.Holder.Changed:Connect(function()
        settingsOtherTab.Holder.Size = U2n(1, 0, 1, -1)
        settingsOtherTab.Holder.Position = U2o(0, 1)
        settingsOtherTab.Holder.ZIndex = 42
        safeReparent(settingsOtherTab.Holder, window.Window.RealWindow.Contents.SettingsBlur.Downsampler.SettingsOverlay.SettingsHub)
        reparent()
    end)

    c8 = settingsOtherTab.TabButton.Changed:Connect(function()
        safeReparent(settingsOtherTab.TabButton, nil)
        reparent()
    end)

    window._Connections[#window._Connections + 1] = c1
    window._Connections[#window._Connections + 1] = c2
    window._Connections[#window._Connections + 1] = c3
    window._Connections[#window._Connections + 1] = c4
    window._Connections[#window._Connections + 1] = c5
    window._Connections[#window._Connections + 1] = c6
    window._Connections[#window._Connections + 1] = c7
    window._Connections[#window._Connections + 1] = c8

    reparent()
    repeat render() until executionTimes

    window.Options.FirstExecution = executionTimes <= 1
    window.Options.ExecutionTimes = round(executionTimes)

    textList[#textList + 1] = "Library executions: <b>" .. ranTimes .. "</b>"
    einfo.Text = concat(textList, "\n")

    window:Refresh()
end

local function fixNum(n)
    local str = tostring(n)
    local dot = str:find(".", 1, true)

    if dot then
        local before = str:sub(1, dot - 1)
        local after = str:sub(dot + 1)

        if #after > 6 then
            after = after:sub(1, 5):gsub("0+$", "")
        end

        if after ~= "" then
            return before .. "." .. after
        else
            return before
        end
    else
        return str
    end
end

local functions = {
    -- Basic value display
    ["."] = function(self)
        return fixNum(self.Value)
    end,

    -- Percent with % symbol (raw)
    ["%"] = function(self)
        return round(self.Value) .. "%"
    end,

    -- Rounded percent (0–100 scale, rounded to nearest integer)
    [".%"] = function(self)
        return (round(self.Value * 100)) .. "%"
    end,

    -- Rounded percent with 1 decimal place
    [".1%"] = function(self)
        return ("%.1f%%"):format(self.Value * 100)
    end,

    -- Rounded percent with 2 decimal places
    [".2%"] = function(self)
        return ("%.2f%%"):format(self.Value * 100)
    end,

    -- Fraction display: Value / Max
    ["/"] = function(self)
        return fixNum(self.Value) .. " / " .. fixNum(self.Max)
    end,

    -- Fraction as decimal (Value / Max)
    ["//"] = function(self)
        return ("%.3f"):format(self.Value / self.Max)
    end,

    -- Fraction as percentage of Max (same as .% but relative to Max)
    ["/%"] = function(self)
        return (round(((self.Value - self.Min) / (self.Max - self.Min)) * 100)) .. "%"
    end,

    -- Absolute value (useful for negative numbers)
    ["a"] = function(self)
        return tostring(abs(self.Value))
    end,

    -- Signed display: +5, -3
    ["+"] = function(self)
        return (self.Value > 0 and "+" or "") .. tostring(self.Value)
    end,

    -- Currency format (e.g., $1,234.56)
    ["$"] = function(self)
        local val = self.Value
        local absVal = abs(val)
        local integer = round(absVal)
        return (val < 0 and "-" or "") .. "$" .. ("%d"):format(integer):gsub("(%d)(%d%d%d)(%d%d%d)$", "%1,%2,%3"):gsub("(%d)(%d%d%d)$", "%1,%2") .. "." .. ("%02d"):format(floor((absVal - integer) * 100 + 0.5))
    end,

    -- Scientific notation (for very large/small numbers)
    ["e"] = function(self)
        return ("%.2e"):format(self.Value)
    end,

    -- Hexadecimal representation
    ["x"] = function(self)
        local n = round(self.Value)
        return ("0x%X"):format(n)
    end,

    -- Comma-separated thousands (e.g., 1,234,567)
    [","] = function(self)
        local val = round(self.Value)
        return (val < 0 and "-" or "") .. ("%d"):format(abs(val)):gsub("(%d)(%d%d%d)(%d%d%d)$", "%1,%2,%3"):gsub("(%d)(%d%d%d)$", "%1,%2")
    end
}

local gui = script.Parent
local defaultWindow = gui.Holder.Window
local defaultDisplay = defaultWindow.RealWindow.Contents.Display
local placeholders = script.Placeholders
local sounds = script.Sounds

local emojis = {
    utf8.char(128156),
    utf8.char(128293),
    utf8.char(127826),
    utf8.char(127872),
    utf8.char(128520),
    utf8.char(128081),
    utf8.char(9889),
    utf8.char(128178)
}

local name = config.Name .. " | "
for i = 1, 10 do
    name = name .. emojis[mrandom(1, #emojis)]
end

gui.Name = name

local tween        = game:GetService("TweenService")
local uis        = game:GetService("UserInputService")
local http        = game:GetService("HttpService")
local textS        = game:GetService("TextService")
local mps        = game:GetService("MarketplaceService")
local cachedThingy = { }

local function getTextSize(text, size, font, bounds)
    local font = Font.fromEnum(font)
    local index = text .. size .. tostring(font) .. tostring(bounds)
    local value = cachedThingy[index]

    if value then
        return value
    end

    local textParams = Inew("GetTextBoundsParams")
    textParams.Text = text
    textParams.Size = size
    textParams.Font = font
    textParams.RichText = true
    textParams.Width = tonumber(bounds) or bounds.X

    local result = textS:GetTextBoundsAsync(textParams)
    cachedThingy[index] = result
    textParams:Destroy()

    return result
end

local mouse = plr:GetMouse()
local userIcon = "rbxthumb://type=AvatarHeadShot&id=" .. plr.UserId .. "&w=420&h=420"

local icons            = require(script.Data.Icons)
local langs         = require(script.Data.Languages)

defaultWindow.RealWindow.Contents.TopbarZone.TitleZone.UIListLayout.FillDirection = Enum.FillDirection.Horizontal
defaultWindow.RealWindow.Contents.TopbarZone.TitleZone.UIListLayout.Wraps = true
defaultWindow.RealWindow.InsideStroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner
defaultWindow.RealWindow.Contents.NotificationsOverlay.Offsetter.Notification.UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Inner
defaultDisplay.Pages.Page.NormalZone.Label.ColorPickers.Picker.Display.UIStroke.BorderStrokePosition = Enum.BorderStrokePosition.Center
gui.Enabled = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local function addPlaceholder(obj, newName)
    obj.Name = newName or obj.Name
    safeReparent(obj, placeholders)
end

addPlaceholder(defaultDisplay.Pages.Page.NormalZone.Label.ColorPickers.Picker, "ColorPicker")
addPlaceholder(defaultDisplay.Pages.Page.NormalZone.Label.ColorPickers.KeybindPicker)
addPlaceholder(defaultDisplay.Pages.Page.NormalZone.Label.ColorPickers)

addPlaceholder(defaultDisplay.PageButtons.List.PageButton, "TabButton")
addPlaceholder(defaultDisplay.PageButtons.List.PageHeader, "TabHeader")
addPlaceholder(defaultDisplay.PageButtons.List.PageSeparator, "TabSeparator")
addPlaceholder(defaultWindow.RealWindow.Contents.Display.Pages.Page.NormalZone.Dropdown.View.List.List.Row, "DropdownRow")

addPlaceholder(gui.Holder.MobileButton)
addPlaceholder(sounds)

for _, v in defaultDisplay.Pages.Page.NormalZone:GetChildren() do
    if v:IsA("GuiObject") then
        addPlaceholder(v)
    end
end

for _, v in defaultDisplay.Pages.Page.GroupboxZone.LeftGroupboxZone.Groupbox.Holder.Contents:GetChildren() do
    if v:IsA("GuiObject") then
        v:Destroy()
    end
end

addPlaceholder(defaultDisplay.Pages.Page.GroupboxZone.LeftGroupboxZone.Groupbox)
addPlaceholder(defaultDisplay.Pages.Page, "Tab")
addPlaceholder(defaultDisplay.Pages.CustomPage, "CustomTab")

addPlaceholder(defaultWindow.RealWindow.Contents.NotificationsOverlay.Offsetter.Notification.ButtonsZone.Buttons.Button, "IWNButton")
if defaultWindow.RealWindow.Contents.NotificationsOverlay.Offsetter.Notification.ButtonsZone.Buttons:FindFirstChild("Button") then
    defaultWindow.RealWindow.Contents.NotificationsOverlay.Offsetter.Notification.ButtonsZone.Buttons.Button:Destroy()
end

addPlaceholder(defaultWindow.RealWindow.Contents.NotificationsOverlay.Offsetter.Notification, "IWNotification")

addPlaceholder(defaultWindow)

addPlaceholder(gui.Holder.ColorPickerWindow)
addPlaceholder(gui.Tooltip)
addPlaceholder(gui.Notifications.NotificationsLeft.Holder, "Notification")

addPlaceholder(gui.FloatingLabel)

safeReparent(script, nil)
_pcall(function()
    gui.OnTopOfCoreBlur = true
end)

local isMobile = uis.TouchEnabled and not uis.KeyboardEnabled
local emulator, realPlatform = false, nil
local s, platform = _pcall(uis.GetPlatform, uis)
if s then
    realPlatform = platform
    local isMobilePlatform = tfind({ Enum.Platform.IOS, Enum.Platform.Android, Enum.Platform.Ouya }, platform)
    if isMobilePlatform and not isMobile or isMobile and not isMobilePlatform then
        emulator = true
    end
else
    realPlatform = not isMobile and Enum.Platform.Windows or Enum.Platform.Android
end

if platform ~= Enum.Platform.Windows and platform ~= Enum.Platform.IOS and platform ~= Enum.Platform.Android then
    platform = not isMobile and Enum.Platform.Windows or Enum.Platform.Android
end

local device = emulator and (platform == Enum.Platform.Windows and "Mobile" or "PC") or (platform == Enum.Platform.Windows and "PC" or "Mobile")
local executor, version = (getfenv().identifyexecutor or function()
    return (rs:IsStudio() and "Studio" or "") .. "Client", getfenv().version()
end)()

if not executor then
    executor = (rs:IsStudio() and "Studio" or "") .. "Client"
end

if not version then
    version = getfenv().version()
end

if device == "Mobile" then
    for i, v in gui.Notifications:GetChildren() do
        v.Size = U2n(v.Size.X.Scale, v.Size.X.Offset - 75, v.Size.Y.Scale, v.Size.Y.Offset)
    end
end

local tooltipObject, coreWindow

local circle = Inew("Frame")
circle.BackgroundTransparency = 0.95
circle.AnchorPoint = V2n(0.5, 0.5)
circle.Size = U2o(0, 10000)
circle.BorderSizePixel = 0
circle.ZIndex = 3
circle.BackgroundColor3 = C3R(255, 255, 255)

Inew("UICorner", circle).CornerRadius = Un(1, 0)
Inew("UIAspectRatioConstraint", circle)

addPlaceholder(circle, "Circle")

safeReparent(placeholders, gui)
safeReparent(gui, (getfenv().gethui or function() return game:GetService("CoreGui") or game:GetService("Players").LocalPlayer.PlayerGui end)())

local tbMeasurer = Inew("ScreenGui", gui.Parent)
tbMeasurer.ScreenInsets = Enum.ScreenInsets.TopbarSafeInsets
tbMeasurer.ResetOnSpawn = false

local function getPlaceholder(name) : Instance?
    local found = placeholders:FindFirstChild(name)
    if found then
        return found:Clone() 
    end
end

local function tweenOnce(obj: Instance, ti: TweenInfo, props: { any })
    local ti = ti or TIn(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

    if ti.Time > 0.005 then
        local tween = tween:Create(obj, ti, props)

        obj = nil
        ti = nil
        props = nil

        tween:Play()
        defer(tween.Destroy, tween)
    else
        for i, v in props do
            obj[i] = v
        end
    end
end

local function paintRichText(text, color)
    return "<font color=\"#" .. C3n(clamp(color.R, 0, 1), clamp(color.G, 0, 1), clamp(color.B, 0, 1)):ToHex() .. "\">" .. text .. "</font>"
end

local references = { }
local ridx = max32

local getWindow do
    local objectCache = setmetatable({ }, { __mode = "kv" })
    getWindow = function(obj)
        local v = objectCache[obj]
        if v ~= nil then
            return v
        end

        local origObj = obj
        obj = obj.Proxy or obj

        while true do
            if not obj then
                return
            end

            if obj.Class == "Window" then
                objectCache[origObj] = obj.Proxy
                return obj.Proxy
            end

            obj = obj.Parent
        end
    end
end

local newObject do
    local currentProperty = ""

    local function prop(self, value)
        local inited = references[self] or self
        if inited.Options[currentProperty] == nil then
            error("Expected ':' not '.' calling Set function", 0)
        end

        local proxy = inited.Proxy
        if not proxy then
            inited[currentProperty] = value
            inited:Refresh()
        else
            proxy[currentProperty] = value
        end
    end

    local function getprop(self, value)
        local inited = references[self] or self
        if not inited.Options[currentProperty] then
            error("Expected ':' not '.' calling Get function", 0)
        end

        return inited.Options[currentProperty]
    end

    local printM do
        local function tryTostring(v, t)
            local str = tostring(v)
            if --[[t == "table" and str:sub(1, 7) == "table: "]] false then
                local strList = { }
                local can = false

                for i, va in v do
                    if tonumber(i) then
                        if can and typeof(va) == "table" then
                            local s, e = _pcall(http.JSONEncode, http, v)
                            if not s then
                                can = false
                            else
                                return e
                            end
                        end

                        strList[#strList + 1] = i .. " = " .. tostring(va)
                    end
                end

                return concat(strList, " ; ")
            end

            return str
        end

        function printM(self)
            local inited = references[self]
            if not inited then return warn("== NO METHODS/READONLY PROPERTIES FOUND FOR", self, "==") end

            local methods, props = "    :Get???() -> any -- Gets property/option 'x'\n    :Set???(...) -- Sets property/option 'x'\nExample: object:SetValue(999)\n    :PrintAll()\n", ""
            for i, v in inited do
                if i == "Self" or i == "self" or i:sub(1, 1) == "_" or i == "Proxy" then continue end

                local type = typeof(v)
                if type == "function" then
                    methods ..= "    :" .. i .. "(...) -> any?\n"
                elseif i ~= "Options" then
                    local stringVer = tryTostring(v, type)
                    if #stringVer >= 130 then
                        stringVer = stringVer:sub(1, 128) .. "..."
                    end

                    props ..= "    ." .. i .. " : " .. stringVer .. " : " .. type .. " (read only)\n"
                else
                    props ..= "    ." .. i .. " : table (read only)\n"
                end
            end

            print(self, "\n== METHODS & READONLY PROPERTIES OF", inited.Class or "Object", "==\n\nMethods:\n" .. methods, "\nR.O. Properties:\n" .. props, "\n")
        end
    end

    local function idx(self, indx)
        local inited = references[self]
        local index = (indx:sub(1, 1):upper() .. indx:sub(2)):gsub("Caption", "Tooltip"):gsub("HoverText", "Tooltip")
        local id = index:sub(1, 3)

        if index == "PrintAll" then
            return printM
        elseif (id ~= "Set" and id ~= "Get") or #indx == 3 or inited[index] ~= nil then
            local val = inited[indx]
            if val ~= nil then
                return val
            else
                local val = inited.Options[indx]
                if val == nil then
                    if inited.Objects then
                        val = inited.Objects[indx]
                        if val == nil then
                            error(("No properties, methods or options called '%s'"):format(indx), 0)
                        end
                    end
                end

                return val
            end
        elseif id == "Set" then
            indx = indx:sub(4)
            if inited.Options[indx] ~= nil then
                currentProperty = indx
                return prop
            else
                error(("No properties, methods or options called '%s'"):format(indx), 0)
            end
        elseif id == "Get" then
            indx = indx:sub(4)
            if inited.Options[indx] ~= nil then
                currentProperty = indx
                return getprop
            else
                error(("No properties, methods or options called '%s'"):format(indx), 0)
            end
        end
    end

    local deferedRefreshes = { }
    local function objectRefresh(inited, s)
        pcall(inited.Refresh, inited)
        deferedRefreshes[s] = nil
    end

    local function newidx(self, key, val)
        local key = (key:sub(1, 1):upper() .. key:sub(2)):gsub("Caption", "Tooltip"):gsub("HoverText", "Tooltip")

        local inited = references[self] or self
        local newValue = key == "Enabled" and not val or key ~= "Enabled" and (val ~= nil and val or false)

        if inited.Options[key] ~= newValue then
            inited.Options[key] = newValue

            local s = tostring(inited)
            if not deferedRefreshes[s] then
                deferedRefreshes[s] = true
                defer(objectRefresh, inited, s)
            end
        end
    end

    local function getOptions(window, self, ...)
        local counters = window and window.Counters or { }

        local options, flag = select(1, ...)
        if typeof(options) == "string" then
            options, flag = flag, options
        end

        local options = setmetatable(typeof(options) == "table" and options or { }, { __index = self.DefaultOptions })
        local ID = typeof(flag) == "string" and flag or options.ID or options.id or options.Flag or options.flag or options.Id or options.Idx or options.Index or options.idx or options.index
        if not ID then
            local str = options.Text ~= "" and options.Text or options.Title ~= "" and options.Title or ""
            if #str == 0 then
                str = "Object"
            end

            str = clean(str)

            counters[str] = (counters[str] or -1) + 1
            ID = str .. (counters[str] ~= 0 and counters[str] or "")
        end

        ID = clean(tostring(ID), false)

        local flag: string = ID
        options.Flag = flag

        ID = ID:lower():gsub("[\0-\47\58-\64\92-\94\96\123-\255]", "") .. "_id"
        counters[ID] = (counters[ID] or -1) + 1
        ID ..= counters[ID]

        local hash = compressor:Hash(ID)
        local h = hash:sub(1, clamp(#flag, 2, 3) - 1)
        counters[h] = (counters[h] or -1) + 1
        h ..= (counters[h] ~= 0 and counters[h] or "")

        options.FlagHashShort = h
        options.FlagHash = hash:sub(1, 16)
        options.FlagHashLong = hash
        options.FlagHashFull = hash

        if options.Default ~= nil then
            options.Value, options.Default = options.Default, nil
        end

        return options
    end

    local tostrLookups = { }
    local function tostrmt(self)
        local self = references[self] and self or self.Proxy
        local str = tostrLookups[self]
        local ref = references[self]

        if not str or not ref then
            return "???: 0x????????????????"
        end

        return (str:gsub("userdata", ref.Class or "Object"))
    end

    newObject = function(instructions, parent, ...)
        local window = parent and getWindow(parent)
        local options = getOptions(window, instructions, ...)
        local init = instructions.Init
        local success, inited = pcall(init, instructions, options)
        if not success then
            error("Error while creating an object '" .. (instructions.Class or "Unknown") .. "'\n\nPassed options: " .. je(options or "BAD") .. "\n\nError: " .. inited, 0)
        end
        
        -- local inited = init(instructions, options)
        
        for i, v in instructions do
            if i ~= "Init" and i ~= "DefaultOptions" then
                inited[i] = inited[i] or v
            end
        end

        local object = newproxy(true)
        tostrLookups[object] = tostring(object)

        local meta : { any } = getmetatable(object)
        meta.__metatable = getmetatable(game)
        meta.__index = idx
        meta.__newindex = newidx
        meta.__tostring = tostrmt
        meta.__metatable = config.Name .. " Object Metatable"

        tfreeze(meta)
        references[object] = inited
        inited.Proxy = object
        inited.Parent = parent

        if window then
            tinsert(window.AllObjects, object)
            window.ObjectAdded:Fire(object)
        end

        return object:Refresh() or object
    end
end

local function addFunctions(toAdd, list)
    for i, v in list do
        if typeof(i) == "string" and i ~= "DefaultOptions" and i ~= "Init" and toAdd[i] == nil then
            toAdd[i] = i == "Translations" and tclone(v) or v
        end
    end

    toAdd.Self = toAdd
    return toAdd
end

local function handleAnimationSpeed(value)
    if value < 0.1 or value >= 10 then
        return inf -- instant animation
    end

    return value
end

local function OR(...)
    local cons = { }
    local done = false

    local function cn()
        for i, v in cons do
            if v.Connected then
                v:Disconnect()
            end
        end

        done = true
    end

    for i = 1, select("#", ...) do
        cons[#cons + 1] = select(i, ...):Connect(cn)
    end

    repeat render() until done
end

local function castCircle(button, window, holder)
    local circle = getPlaceholder("Circle")
    safeReparent(circle, holder or button)

    local mp = V2n(mouse.X, mouse.Y)
    local pos = V2n(mp.X - button.AbsolutePosition.X, mp.Y - button.AbsolutePosition.Y)
    local relative = U2s(pos.X / button.AbsoluteSize.X, pos.Y / button.AbsoluteSize.Y)

    circle.Position = relative
    circle.BackgroundColor3 = window.Theme.Text

    local time = 0.35 / handleAnimationSpeed(window.AnimationSpeed)
    tweenOnce(circle, TIn(time), { Size = U2n(2.5, 0, 0, 10000), BackgroundTransparency = 0.9 })
    OR(button.MouseButton1Up, button.MouseLeave, button.Destroying)
    tweenOnce(circle, TIn(time * 2.5), { BackgroundTransparency = 1 })
    wait(time * 2.5)

    circle:Destroy()
end

local function quickCount(str1, str2)
    if str2 == "" then return 0 end

    local count = 0
    local start = 1
    local len = #str2

    while true do
        local pos = str1:find(str2, start, true)
        if not pos then break end

        count += 1
        start = pos + len
    end

    return count
end

local getIcon, setIcon do
    local encodingServ = game:GetService("EncodingService")
    local blockExstensions = {
        "com", "ru", "web", "online", "org", "net", "biz", "info", "pro", "mobi", "us", "ca", "co", "cc", "tv", "fr", "to", "jp", "it", "de", "se", "no", "es", "pt"
    }

    local imageCache = { }
    local tryDownloadImage = gca and function(url)
        local ext = "png"
        local start, stop = url:reverse():find("%.")
        local att = url:sub(-stop + 1)

        local br = att:find("?", 0, true) or att:find("&", 0, true) or att:find("=", 0, true) or att:find("/", 0, true) or att:find("\\", 0, true)
        if br then
            att = att:sub(1, br - 1)
        end

        ext = tfind(blockExstensions, att) and "png" or att
        local fileHash = cacheRoute .. (encodingServ:ComputeStringHash(url, Enum.HashAlgorithm.Md5):gsub(".", function(str) return ("%02x"):format(str:byte()) end)) .. "." .. ext

        if imageCache[fileHash] then
            return imageCache[fileHash]
        end

        if IF(fileHash) then
            local asset = gca(fileHash)
            imageCache[fileHash] = asset

            return asset
        end

        local success, result = _pcall(function()
            local content = game:HttpGet(url, true)
            if #content < 128 then
                error("Image size too small!", 0)
                return ""
            end

            wf(fileHash, content, true)

            local asset = gca(fileHash)
            imageCache[fileHash] = asset

            return asset
        end)

        if not success then
            warn("Download", "\"" .. url .. "\"", "failed:", result)
        end

        return success and result or ""
    end or function(url)
        warn("Unable to download", "\"" .. url .. "\"!")
        return ""
    end

    downloadImage = function(...)
        local s, e = _pcall(tryDownloadImage, ...)
        return s and e or ""
    end

    local lucideIcons = require(script.Data.LucideIcons)
    local allIcons = lucideIcons[1]
    local iconPositions = lucideIcons[2][48]

    local function valueSafeCheck(value, list)
        if type(value) ~= "string" then
            return ""
        end

        local ret = value
        if list then
            local upper = value:sub(1, 1):upper() .. value:sub(2)
            if list[upper] then
                ret = list[upper]
            end
        end

        local lucide
        if tonumber(ret) then
            ret = "rbxassetid://" .. ret
        elseif value:sub(1, 4):lower() == "l://" then
            local found = tfind(allIcons, value:sub(5):lower())
            if found then
                lucide = found
            else
                return ""
            end
        elseif tfind(allIcons, value) then
            lucide = tfind(allIcons, value)
        elseif ret:sub(1, 4) == "http" and not ret:find("roblox.", 0, true) then
            return ret, true
        end

        if lucide then
            return false, false, iconPositions[lucide]
        end

        if ret:sub(1, 13) == "rbxassetid://" and not tonumber(ret:sub(14)) then
            ret = ""
        end

        return ret
    end

    local spriteSheets = {
        [1] = "rbxassetid://115353617237502",
        [2] = "rbxassetid://110997322179595"
    }

    local function _getIcon(value, list, dontUseLucide)
        local val, download, isLucide = valueSafeCheck(value, list)
        if isLucide then
            if dontUseLucide then
                return ""
            end

            local imageIndex, rectSize, rectOffset = unpack(isLucide)
            return spriteSheets[imageIndex], rectSize, rectOffset
        end

        if download then
            val = downloadImage(val)
        end

        return val
    end

    playSound = function(sound, holder)
        holder = getWindow(holder or coreWindow)
        sound = tostring(sound)

        if holder.Window.Sounds:FindFirstChild(sound) then
            sound = holder.Window.Sounds[sound]
        end

        if typeof(sound) == "Instance" then
            if sound:IsA("Sound") then
                sound = sound.SoundId
            else
                sound = ""
            end
        end

        sound = _getIcon(sound)
        if #sound <= 11 then return end

        local snd = Inew("Sound", holder.Window.SoundCache)
        snd.SoundGroup = holder.Window.SoundCache
        snd.SoundId = sound
        snd.Volume = 0.5
        snd:Play()

        snd.Ended:Wait()
        snd:Destroy()
    end

    local cache = { }
    getIcon = function(value, list, object, dontUseLucide)
        value = value or ""
        local str = tostring(value) .. tostring(list)

        if tonumber(value) then
            cache[str] = { "rbxassetid://" .. value }
        end

        if cache[str] then
            return unpack(cache[str])
        end

        spawn(function()
            cache[str] = { "" }
            cache[str] = { _getIcon(value, list, dontUseLucide) }

            if object then
                object:Refresh()
            end
        end)

        local c = cache[str]
        if c then
            return unpack(c)
        end

        return ""
    end

    setIcon = function(value, list, object, instance, dontUseLucide)
        local image, imageRectSize, imageRectOffset = getIcon(value, list, object, dontUseLucide)
        image = image or ""

        instance.Image = image
        instance.ImageRectOffset = imageRectOffset and V2n(unpack(imageRectOffset)) or V2n()
        instance.ImageRectSize = imageRectSize and V2n(unpack(imageRectSize)) or V2n()

        return clean(image)
    end
end

translate = function(self, category, grabFromWindow)
    local window = getWindow(self.Proxy or self)
    local language = window and window.Options.Language or "EN"
    local options = grabFromWindow and window.Options or self.Options

    local translationsPage = options.Translations and (options.Translations[language] or options.Translations.EN)
    if not translationsPage then
        return options[category] or ""
    end

    return typeof(translationsPage) == "string" and translationsPage ~= "" and category:sub(1, 1):upper() .. category:sub(2) == "Text" and translationsPage or typeof(translationsPage) == "table" and translationsPage[category] or options[category] or ""
end

local function hoverLogic(object, instance)
    local window = getWindow(object)
    local cons = window._Connections
    local mouseIn = false

    cons[#cons + 1] = instance.MouseEnter:Connect(function()
        if not object.Options.Disabled then
            spawn(playSound, "Hover", window)
        end

        mouseIn = true

        render()

        local tt = object.Options.Disabled and translate(object, "DisabledTooltip")
        if not tt or #tt == 0 then tt = translate(object, "Tooltip") or "" end

        tooltipObject.Options.Window = window
        tooltipObject.Options.Dark = object.Options.Disabled
        tooltipObject.Text = tt
    end)

    cons[#cons + 1] = instance.MouseLeave:Connect(function()
        mouseIn = false

        tooltipObject.Options.Window = coreWindow
        tooltipObject.Options.Dark = false
        tooltipObject.Text = ""
    end)
end

local _refreshEverything; _refreshEverything = function(enumerable)
    _pcall(enumerable.Refresh, enumerable)

    local cl = enumerable.Class
    if cl == "ColorPicker" or cl == "Keybind" then
        for i, v in enumerable.ColorPickers do
            _pcall(_refreshEverything, v)
        end
    end

    for i, v in enumerable.Objects do
        _pcall(_refreshEverything, v)
    end
end

local function refreshEverything(window)
    pcall(_refreshEverything, window)
end

local function addPossibleTranslations(object)
    object = object.Proxy or object
    local window = getWindow(object)
    
    if not window then return end

    if object.Translations then
        for lang in object.Translations do
            if langs[lang] and not tfind(window.PossibleLanguages, lang) then
                tinsert(window.PossibleLanguages, lang)
                window.LanguageAdded:Fire(window.PossibleLanguages, lang)
            end
        end
    end
    
    object:Refresh()
end

local allIcons = { }
for icon in icons do
    tinsert(allIcons, icon)
end

tfreeze(allIcons)

local allBackgrounds = { }
for icon in backgrounds do
    tinsert(allBackgrounds, icon)
end

tfreeze(allBackgrounds)

local inputting = false
local blockedKeys = {
    Enum.KeyCode.Unknown,
    Enum.KeyCode.Power,
    Enum.KeyCode.Left,
    Enum.KeyCode.Right,
    Enum.KeyCode.Up,
    Enum.KeyCode.Down,
    Enum.KeyCode.F11,
    Enum.KeyCode.F9,
    Enum.KeyCode.CapsLock,
    Enum.KeyCode.ScrollLock,
    Enum.KeyCode.NumLock
}

local gsubs = {
    Left = "L", Right = "R", Minus = "-",
    Slash = "/", BackSlash = "\\", Period = ".",
    Zero = "0", One = "1", Two = "2",
    Three = "3", Four = "4", Five = "5",
    Six = "6", Seven = "7", Eight = "8",
    Nine = "9", Equals = "=", LeftBracket = "[",
    RightBracket = "]", LBracket = "[", RBracket = "]",
    Quote = "'", Backquote = "`", Comma = ",",
    Semicolon = ";", Plus = "+", Asterisk = "*",
    Multiply = "*", Divide = "/", Keypad = "Kp",
    Return = "Enter", Escape = "Esc",
    Insert = "Ins", Delete = "Del",
    PageUp = "PgUp", PageDown = "PgDown"
}

gsubInput = function(inp)
    for i, v in gsubs do
        inp = inp:gsub(i, v)
    end

    return inp
end

uis.InputBegan:Connect(function(inp, chat)
    if not inputting or tfind(blockedKeys, inp.KeyCode) then
        return
    end

    if chat or inputting.Disabled then
        local i = inputting
        inputting = false
        i:Refresh(true)

        return
    end

    local i = inputting
    inputting = false
    i:Call(inp.KeyCode.Value)
end)

local function addDefault(object, table)
    if object.Options.Value ~= nil and object.Set then
        table[object] = object.Options.Value
    end
end

local function addCons(object, cons)
    local window = getWindow(object)
    local connections = window._Connections

    for i, v in cons do
        tinsert(connections, v)
    end

    _pcall(addDefault, object, window.Defaults)
end

local units = {
    { 30 * 24 * 60 * 60, "mo" },
    { 24 * 60 * 60, "d" },
    { 60 * 60, "h" },
    { 60, "m" },
    { 1, "s" }
}

local function formatTime(sec)
    sec = floor(sec)

    if sec >= 1e9 then
        return "NEVER"
    elseif sec >= 1e8 then
        return "1y+"
    end

    local parts = { }
    for _, u in units  do
        local val = floor(sec / u[1])
        if val > 0 then
            tinsert(parts, tostring(val) .. u[2])
            sec %= u[1]
        end
    end

    while #parts > 3 do
        tremove(parts, #parts)
    end

    return #parts > 0 and concat(parts, " ") or "EXPIRED"
end

local function themeSync(object, cons)
    local window = getWindow(object)
    local cons = cons or window._Connections
    
    cons[#cons + 1] = window.ThemeChanged:Connect(function()
        object:Refresh()
    end)

    object:Refresh()
end

local function orderUpdate(a, b)
    if a.LayoutOrder ~= b and b then
        a.LayoutOrder = b
    end
end

local function softCallback(cb, ...)
    local result = pack(pcall(cb, ...))
    if result[1] then
        return unpack(result, 2, result.n)
    end
    
    warn("Error occured during a Callback call:\n" .. tostring(result[2]))
end

local acp
local colorPickerBase = {
    Class = "ColorPicker",
    DefaultOptions = {
        Value = C3n(1, 1, 1),
        Callback = function(color) end,
        Disabled = false,
        Visible = true,
        Tooltip = "",
        DisabledTooltip = "",
        Order = 0,

        _connected = false
    },
    AddColorPicker = function(self, ...)
        return acp(self.Parent, ...)
    end,
    ColorPicker = function(self, ...)
        return self:AddColorPicker(...)
    end,
    NewColorPicker = function(self, ...)
        return self:AddColorPicker(...)
    end,
    Set = function(self, value)
        local old = self.Options.Value
        self.Options.Value = value
        self:Refresh()

        if old ~= self.Options.Value then
            self.Changed:Fire(self.Options.Value, self)
            spawn(softCallback, self.Options.Callback, self.Options.Value, self)
        end
    end,
    Init = function(self, options)
        local instance = getPlaceholder("ColorPicker")
        local object = addFunctions({
            Options = options,
            Instance = instance,
            Changed = event.new(),
            Class = self.Class
        }, self)

        defer(hoverLogic, object, instance)

        local picking = false
        local cons = { }
        defer(addCons, object, cons)

        cons[#cons + 1] = instance.MouseButton1Click:Connect(function()
            if picking or object.Options.Disabled then return end
            picking = true
            spawn(playSound, "Click", object)

            local tt =  object.Options.Tooltip
            local color = getWindow(object.Proxy):ColorPicker({ Value = object.Options.Value, Text = #tt > 0 and tt or object.Proxy.Parent and object.Proxy.Parent.Text or "Color Picker" })
            if color then
                object:Call(color)
            end

            picking = false
        end)

        defer(themeSync, object)
        return object
    end,
    Call = function(self, color)
        self:Refresh()

        if self.Options.Disabled then return end

        self.Options.Value = color
        self:Refresh()
        spawn(softCallback, self.Options.Callback, color, self)
    end,
    Refresh = function(self)
        local window = getWindow(self)
        local sinst = self.Instance
        local inst = sinst.Display
        local options = self.Options
        local woptions = window.Options

        inst.BackgroundColor3 = options.Value
        inst.UIStroke.Color = window.Theme.Stroke
        inst.Darker.Visible = options.Disabled
        inst.Parent.Visible = options.Visible
        inst.UICorner.CornerRadius = cornerState[woptions.RoundEverything]
        inst.UIStroke.Enabled = not woptions.NoStrokes
        orderUpdate(inst, options.Order)

        local parent = self.Parent
        if not parent then return end

        local instance = parent.Instance
        local pickers = instance:FindFirstChild("ColorPickers") or getPlaceholder("ColorPickers")

        safeReparent(pickers, instance)
        safeReparent(sinst, pickers)
    end
}

acp = function(...)
    local colorPicker = newObject(colorPickerBase, ...)
    tinsert((...).ColorPickers, colorPicker)

    return colorPicker
end

local keybindBase = {
    Class = "Keybind",
    DefaultOptions = {
        Reference = false,
        Visible = false,
        Value = false,

        KeySet = function() end
    },
    Set = function(self, value)
        local old = self.Options.Value
        self.Options.Value = value
        self:Refresh()

        if old ~= self.Options.Value then
            self.Changed:Fire(self.Options.Value ~= false and Enum.KeyCode:FromValue(self.Options.Value) or nil, self.Proxy)
            spawn(self.Options.KeySet, self.Options.Value ~= false and Enum.KeyCode:FromValue(self.Options.Value) or nil, self.Proxy)
        end

        local window = getWindow(self)
        window.KeybindMode:Fire(window.KeybindModeActive)
    end,
    Callback = function(self, state)
        local options = self.Options
        if not options.Reference then return end

        local r = options.Reference
        if not state and r.Class ~= "Button" then return end
        r:Click(state)
    end,
    Init = function(self, options)
        local instance = getPlaceholder("KeybindPicker")
        local object = addFunctions({
            Options = options,
            Instance = instance,
            Changed = event.new(),
            Class = self.Class
        }, self)

        local cons = { }
        defer(addCons, object, cons)

        cons[#cons + 1] = instance.MouseButton1Click:Connect(function()
            object.Proxy:Click()
        end)

        defer(object.Setup, object)

        return object
    end,
    Setup = function(self)
        self = self.Proxy

        local window = getWindow(self)
        local started = false
        window._Connections[#window._Connections + 1] = uis.InputBegan:Connect(function(input, chat)
            if chat or input.KeyCode.Value ~= self.Options.Value or started then return end

            started = true
            self:Callback(true)
        end)

        window._Connections[#window._Connections + 1] = uis.InputEnded:Connect(function(input, chat)
            if input.KeyCode.Value ~= self.Options.Value or not started then return end

            started = false
            self:Callback(false)
        end)

        window._Connections[#window._Connections + 1] = self.Options.Reference.Changed:Connect(function()
            window.KeybindMode:Fire(window.KeybindModeActive) -- cast a refresh
        end)

        tinsert(window.KeybindObjects, self)
    end,
    Call = function(self, value)
        self.Options.Value = value
        self.Proxy:Refresh()

        self.Changed:Fire(self.Options.Value ~= false and Enum.KeyCode:FromValue(self.Options.Value) or nil, self.Proxy)

        local window = getWindow(self)
        window.KeybindMode:Fire(window.KeybindModeActive)
    end,
    Click = function(self)
        if self.Options.Disabled then return end

        local i = inputting
        inputting = self
        spawn(playSound, "Click", self)

        if i then
            if i == inputting then
                inputting = false
                self:Call(false)
            else
                i:Refresh(true)
            end
        end

        self:Refresh(true)
    end,
    Refresh = function(self, set)
        local window = getWindow(self)
        local sinst = self.Instance
        local inst = sinst.Display
        local options = self.Options
        local woptions = window.Options

        local theme = window.Theme
        local themeS = theme.Stroke

        inst.TextColor3 = theme.Main
        inst.UIStroke.Color = themeS
        inst.Parent.Visible = window.IsDesktop and window.KeybindModeActive
        inst.UICorner.CornerRadius = cornerState[woptions.RoundEverything]
        inst.UIStroke.Enabled = not woptions.NoStrokes
        inst.BackgroundColor3 = themeS
        orderUpdate(inst, -max32)

        local v = options.Value
        if typeof(v) == "EnumItem" then
            v = v.Value
        elseif tonumber(v) then
            v = tonumber(v)
        elseif Enum.KeyCode:FromName(tostring(v)) then
            v = Enum.KeyCode:FromName(tostring(v)).Value
        else
            v = false
        end

        options.Value = v
        if inputting == self then
            inst.Text = "..."
        else
            inst.Text = (not options.Value or not Enum.KeyCode:FromValue(options.Value)) and "None" or gsubInput(Enum.KeyCode:FromValue(options.Value).Name)
        end

        if set then
            window.KeybindMode:Fire(window.KeybindModeActive)
        end

        local ref = options.Reference
        if not ref then return end

        local gb = ref.Parent.Class == "Groupbox"
        local pad = Un(0, gb and 2 or 3)

        inst.UIPadding.PaddingBottom = pad
        inst.UIPadding.PaddingTop = pad
        inst.UIPadding.PaddingLeft = pad
        inst.UIPadding.PaddingRight = pad
        inst.Parent.UIAspectRatioConstraint.AspectRatio = gb and 2 or 1.65

        local instance = ref.Instance
        local pickers = instance:FindFirstChild("ColorPickers") or getPlaceholder("ColorPickers")

        safeReparent(pickers, instance)
        safeReparent(sinst, pickers)
    end
}

local keybindSetup; keybindSetup = function(object, depth)
    depth = depth or 10
    if depth ~= 0 then
        return defer(keybindSetup, object, depth - 1)
    end

    local object = object.Proxy
    local obj = newObject(keybindBase, object, { Reference = object })
    object.ColorPickers[0] = obj

    return obj
end

local basicObjects = {
    Button = {
        Class = "Button",
        DefaultOptions = {
            Text = "Button",
            Callback = function() end,
            Visible = true,
            RecolorIcon = true,
            Disabled = false,
            Holdable = false,
            Value = false,
            Tooltip = "",
            DisabledTooltip = "",
            Icon = "Cursor",
            Order = false,
            Translations = tfreeze({ })
        },
        AddColorPicker = acp,
        ColorPicker = acp,
        NewColorPicker = acp,
        Init = function(self, options)
            local instance = getPlaceholder("Button")
            local object = addFunctions({
                ColorPickers = { },
                Options = options,
                Instance = instance,
                Changed = event.new(),
                Class = self.Class
            }, self)

            defer(hoverLogic, object, instance)
            defer(keybindSetup, object)

            local cons = { }
            defer(addCons, object, cons)

            cons[#cons + 1] = instance.MouseButton1Click:Connect(function()
                if object.Options.Holdable then return end
                object:Click()
            end)

            local holding = false
            cons[#cons + 1] = instance.MouseButton1Down:Connect(function()
                if holding then return end
                object.Options.Value = true
                object.Changed:Fire(true)

                if not object.Options.Holdable then return end

                holding = true
                object:Click(true)
            end)

            cons[#cons + 1] = instance.MouseButton1Up:Connect(function()
                if not holding then return end
                object.Options.Value = false
                object.Changed:Fire(false)

                holding = false
                object:Click(false)
            end)

            cons[#cons + 1] = instance.MouseButton1Down:Connect(function()
                if object.Proxy.Disabled then return end
                castCircle(instance, getWindow(object))
            end)

            return object
        end,
        Call = function(self, isDown, dontFire)
            if not dontFire then
                self.Changed:Fire(isDown == nil and self.Proxy or isDown, isDown ~= nil and self.Proxy, self.Proxy)
            end

            softCallback(self.Options.Callback, isDown == nil and self.Proxy or isDown, isDown ~= nil and self.Proxy, self.Proxy) -- cuz
        end,
        Click = function(self, isDown, dontFire)
            self.Options.Value = not self.Options.Disabled and isDown
            self.Proxy:Refresh()

            if self.Options.Disabled then return end
            if isDown == false and not self.Options.Holdable then
                self.Changed:Fire(false, self.Proxy)
                return
            end

            if not self.Options.Disabled then
                spawn(playSound, "Click", self)
            end

            self:Call(self.Options.Holdable and (isDown == nil and true or isDown ~= nil and not not isDown) or not self.Options.Holdable and nil, dontFire)
        end,
        Refresh = function(self)
            local par = self.Parent
            local pclass = par.Class

            local y = pclass == "Groupbox" and 25 or 40
            local y2 = pclass == "Groupbox" and 14 or 16
            local x = pclass == "Groupbox" and 7 or 15

            local window = getWindow(self)
            local inst = self.Instance
            local view = inst.View
            local opts = self.Options

            local themeT = window.Theme.Text
            inst.Separator.BackgroundColor3 = themeT
            view.Label.TextColor3 = themeT
            view.Icon.ImageColor3 = opts.RecolorIcon and themeT or C3n(1, 1, 1)

            inst.Size = U2n(1, 0, 0, y)
            view.Size = U2n(100, 0, 0, y2)
            view.Position = U2n(0, x, 0.5, 0)
            inst.Visible = opts.Visible

            orderUpdate(inst, opts.Order)
            safeReparent(inst, pclass == "Groupbox" and par.Holder.Holder.Contents or par.Holder.NormalZone)

            view.Label.Text = translate(self, "Text")
            view.Label.TextTransparency = opts.Disabled and 0.35 or 0
            view.Icon.ImageTransparency = opts.Disabled and 0.35 or 0

            setIcon(opts.Icon, icons, self, view.Icon)
        end
    },
    Dropdown = {
        Class = "Dropdown",
        DefaultOptions = {
            Text = "Dropdown",
            NoConfigs = false,
            Callback = function(valueOrValues) end,
            Visible = true,
            Disabled = false,
            Tooltip = "",
            DisabledTooltip = "",
            Multi = false,
            Opened = false,
            Value = false, -- automatically converts into a table/number when needed
            AllowUnselect = false, -- Only for non-multi
            Convert = true,
            AutoHide = true, -- Only for non-multi
            Values = { 1, 2, 3 }, -- List of possible values (numbers, strings, etc.)
            Variants = { }, -- Deprecated, use Values
            Order = false,
            Translations = { }
        },
        Set = function(self, value)
            local old = self.Options.Value
            self.Options.Value = value
            self:Refresh()

            if old ~= self.Options.Value then
                local value = self.Options.Value
                local converted = self:Convert(value)

                if self.Options.Convert then
                    value, converted = converted, value
                end

                self.Changed:Fire(value, converted, self)
                spawn(softCallback, self.Options.Callback, value, converted, self)
            end
        end,
        Init = function(self, options)
            local instance = getPlaceholder("Dropdown")
            local object = addFunctions({
                Options = options,
                Instance = instance,
                DynamicConnections = { },
                Changed = event.new(),
                Class = self.Class
            }, self)

            defer(hoverLogic, object, instance)

            local cons = { }
            defer(addCons, object, cons)

            cons[#cons + 1] = instance.MouseButton1Click:Connect(function()
                object:Click()
            end)

            cons[#cons + 1] = instance.MouseButton1Down:Connect(function()
                if object.Proxy.Disabled then return end
                castCircle(instance, getWindow(object))
            end)

            return object
        end,

        Click = function(self)
            if self.Options.Disabled then
                self.Options.Opened = false
                return self.Proxy:Refresh()
            end

            spawn(playSound, "Click", self)
            self.Options.Opened = not self.Options.Opened
            self.Proxy:Refresh()
        end,

        Call = function(self, value, converted)
            if self.Options.Disabled then return end
            self.Changed:Fire(value, converted, self.Proxy)
            softCallback(self.Options.Callback, value, converted, self.Proxy)
        end,

        Convert = function(self, value, toDisplay)
            local opts = self.Options
            if toDisplay then
                if opts.Multi then
                    local texts = { }
                    for _, idx in value do
                        tinsert(texts, tostring(opts.Values[idx]))
                    end

                    return #texts > 0 and (#texts < #opts.Values and concat(texts, ", ") or "*Everything*") or "None"
                else
                    return tostring(opts.Values[value] or "None")
                end
            else
                if opts.Multi then
                    local val = { }
                    for i, v in self.Options.Values do
                        val[v] = not not tfind(value, i)
                    end

                    return val
                else
                    if value and value >= 1 and value <= #opts.Values then
                        return opts.Values[tonumber(value)] or tonumber(value) or value
                    elseif opts.AllowUnselect then
                        return false
                    else
                        return nil
                    end
                end
            end
        end,

        Refresh = function(self)
            local parnt = self.Parent
            local ispgb = parnt.Class == "Groupbox"
            local y = ispgb and 44 or 50
            local y2 = ispgb and 14 or 16
            local y3 = ispgb and 10 or 14

            local options = self.Options
            local window = getWindow(self)
            local inst = self.Instance
            local view = inst.View
            local label = view.Label
            local viewList = view.List

            local labelL = label.Label
            local viewLNC = viewList.NoContents
            local viewLS = viewList.Selected
            local viewLL = viewList.List
            local licon = label.Icon

            local viewLSVal = viewLS.Value
            local vuis = viewList.UIStroke

            local theme = window.Theme
            local themeT = theme.Text
            local themeS = theme.Stroke
            local themeM = theme.Main

            orderUpdate(inst, options.Order)
            inst.Separator.BackgroundColor3 = themeT
            labelL.TextColor3 = themeT
            licon.ImageColor3 = themeT
            licon.Opened.ImageColor3 = themeT
            viewList.BackgroundColor3 = themeS
            viewLNC.TextColor3 = themeM
            viewLNC.TextStrokeColor3 = themeS
            viewLSVal.TextColor3 = themeM
            viewLSVal.TextStrokeColor3 = themeS
            vuis.Color = themeS

            if options.Value ~= false and typeof(options.Value) ~= "number" and typeof(options.Value) ~= "table" then
                options.Value = tfind(options.Values, options.Value) or false
            end

            if options.Multi then
                if type(options.Value) ~= "table" then
                    options.Value = options.Value and { options.Value } or { }
                end
            else
                if type(options.Value) == "table" then
                    options.Value = options.Value[1] or false
                end
            end

            if options.Value ~= false and typeof(options.Value) ~= "number" and typeof(options.Value) ~= "table" then
                options.Value = tfind(options.Values, options.Value) or false
            end

            if typeof(options.Value) == "table" then
                local isBool = false
                for i, v in options.Value do
                    isBool = typeof(v) == "boolean"
                    break
                end

                if isBool then
                    local newValue = { }
                    for i, v in options.Value do
                        if v then
                            tinsert(newValue, i)
                        end
                    end

                    options.Value = newValue
                end

                for i, v in options.Value do
                    if v ~= false and typeof(v) ~= "number" then
                        options.Value[i] = tfind(options.Values, v) or nil
                    end
                end
            end

            if options.Variants and #options.Variants > 0 then
                options.Values = options.Variants
                options.Variants = { }
            end

            inst.Visible = options.Visible
            safeReparent(inst, ispgb and parnt.Holder.Holder.Contents or parnt.Holder.NormalZone)
            labelL.Text = translate(self, "Text")
            labelL.TextTransparency = options.Disabled and 0.35 or 0
            licon.ImageTransparency = options.Disabled and 0.35 or 0
            viewLSVal.TextTransparency = options.Disabled and 0.35 or 0

            local displayText = self:Convert(options.Value, true)
            viewLSVal.Text = displayText or "None"

            viewLL.Visible = false
            viewLS.Visible = false
            viewLNC.Visible = false
            view.Position = ispgb and U2o(7, 4) or U2o(15, 8)
            view.Size = ispgb and U2n(1, -14, 0, 14) or U2n(1, -30, 0, 16)
            licon.ImageTransparency = options.Opened and 1 or 0
            licon.Opened.Visible = options.Opened
            viewList.UICorner.CornerRadius = cornerState[window.Options.RoundEverything]
            vuis.Enabled = not window.Options.NoStrokes

            local dc = self.DynamicConnections
            for _, conn in dc do
                if conn.Connected then
                    conn:Disconnect()
                end
            end
            tclear(dc)

            if options.Opened then
                if #options.Values == 0 then
                    viewLNC.Visible = true
                    inst.Size = U2n(1, 0, 0, y)
                    viewList.Size = U2n(1, 0, 0, y2)

                    for _, child in viewLL:GetChildren() do
                        if child:IsA("GuiObject") then
                            child:Destroy()
                        end
                    end
                else
                    viewLL.Visible = true
                    inst.Size = U2n(1, 0, 0, (y - y3) + (#options.Values * 14))
                    viewList.Size = U2n(1, 0, 0, #options.Values * 14)

                    for i, val in options.Values do
                        local row = viewLL:FindFirstChild(tostring(i))
                        if not row then
                            row = getPlaceholder("DropdownRow")
                            row.Name = tostring(i)
                        end

                        safeReparent(row, viewLL)
                        row.Text = tostring(val)
                        row.Size = U2s(1, 1 / #options.Values)
                        row.TextColor3 = ((options.Multi and tfind(options.Value, i)) or (not options.Multi and options.Value == i)) and themeM or themeT
                        row.TextStrokeColor3 = themeS

                        dc[#dc + 1] = row.MouseButton1Click:Connect(function()
                            if options.Multi then
                                local found = tfind(options.Value, i)
                                if found then
                                    tremove(options.Value, found)
                                else
                                    tinsert(options.Value, i)
                                end

                                tsort(options.Value)
                            else
                                local old = options.Value
                                if options.AllowUnselect and options.Value == i then
                                    options.Value = false
                                else
                                    options.Value = i
                                end

                                options.Opened = not options.AutoHide and old ~= options.Value or options.AutoHide
                            end

                            local value = options.Value
                            local converted = self:Convert(value)

                            if options.Convert then
                                value, converted = converted, value
                            end

                            spawn(playSound, "Click", self)
                            self:Refresh()
                            self:Call(value, converted)
                        end)

                        dc[#dc + 1] = row.MouseButton1Down:Connect(function()
                            castCircle(row, getWindow(self))
                        end)

                        dc[#dc + 1] = row.MouseEnter:Connect(function()
                            spawn(playSound, "Hover", self)
                        end)
                    end

                    for _, child in viewLL:GetChildren() do
                        if child:IsA("GuiObject") and tonumber(child.Name) and tonumber(child.Name) > #options.Values then
                            child:Destroy()
                        end
                    end
                end
            else
                viewLS.Visible = true
                inst.Size = U2n(1, 0, 0, y)
                viewList.Size = U2n(1, 0, 0, y2)

                for _, child in viewLL:GetChildren() do
                    if child:IsA("GuiObject") then
                        child:Destroy()
                    end
                end
            end
        end
    },

    Slider = {
        Class = "Slider",
        DefaultOptions = {
            Text = "Slider",
            NoConfigs = false,
            Callback = function(value) end,
            Format = "/",
            Visible = true,
            Disabled = false,
            Styled = false,
            Compact = false,
            AllowSetValue = false,
            BypassSetValue = false,
            ShowCompactValue = true,
            _SettingValue = false,
            Minimum = nil,
            Maximum = nil,
            Min = 0,
            Max = 100,
            Step = 1,
            Value = 50,
            _Value = -1,
            Tooltip = "",
            DisabledTooltip = "",
            Order = false,
            Translations = tfreeze({ })
        },
        FixNum = function(self, ...)
            return fixNum(...)
        end,
        Set = function(self, value)
            local old = self.Options.Value
            self.Options.Value = value
            self.Options._Value = (value - self.Options.Min) / (self.Options.Max - self.Options.Min)

            self:Refresh()

            if old ~= self.Options.Value then
                self.Changed:Fire(self.Options.Value, self)
                spawn(softCallback, self.Options.Callback, self.Options.Value, self)
            end
        end,
        BeginSetValue = function(self)
            self = self.Proxy or self
            self.Options._SettingValue = true
            self.Instance.View.Bar.InputProgress.Visible = true
            self.Instance.View.Bar.InputProgress.Text = self.Value
            self.Instance.View.Bar.Progress.Visible = false
            self.Instance.View.Bar.InputProgress:CaptureFocus()
            self:Refresh()
        end,
        Init = function(self, options)
            local instance = getPlaceholder("Slider")
            local object = addFunctions({
                Options = options,
                Instance = instance,
                Changed = event.new(),
                Class = self.Class
            }, self)

            defer(hoverLogic, object, instance)

            local sliding = false
            local bar = instance.View.Bar

            local cons = { }
            defer(addCons, object, cons)

            local mouseDown = false
            local clicks = 0

            cons[#cons + 1] = instance.MouseButton1Down:Connect(function()
                mouseDown = true
                clicks += 1

                if clicks == 2 and options.AllowSetValue then
                    object:BeginSetValue()
                end

                wait(0.75)
                clicks -= 1
            end)

            cons[#cons + 1] = instance.MouseButton2Down:Connect(function()
                if options.AllowSetValue then
                    object:BeginSetValue()
                end
            end)

            cons[#cons + 1] = instance.MouseButton1Up:Connect(function()
                mouseDown = false
            end)

            cons[#cons + 1] = instance.View.Bar.InputProgress.FocusLost:Connect(function()
                options._SettingValue = false
                instance.View.Bar.InputProgress.Visible = false
                instance.View.Bar.Progress.Visible = true

                local number
                for i, v in instance.View.Bar.InputProgress.Text:gsub("[\n\r\f\s\t\0]", " "):split(" ") do
                    number = tonumber(v)
                    if number then break end
                end

                if number then
                    if options.BypassSetValue then
                        object:Set(number)
                    else
                        spawn(object.Call, object, (number - object.Options.Min) / (object.Options.Max - object.Options.Min), true)
                    end
                end

                object.Proxy:Refresh()
            end)

            local con; con = instance.InputBegan:Connect(function(input)
                local touch = input.UserInputType == Enum.UserInputType.Touch
                if input.UserInputType ~= Enum.UserInputType.MouseButton1 and not touch or clicks > 1 or not mouseDown then return end

                if object.Options.Disabled then sliding = false return end
                sliding = true

                local c; c = mouse.Button1Up:Connect(function()
                    sliding = false
                    c:Disconnect()
                end)

                local startX = mouse.X
                local startY = mouse.Y

                while device == "Mobile" do
                    mouse.Move:Wait()
                    local d = render()

                    if abs(mouse.Y - startY) > 25 then
                        sliding = false
                        c:Disconnect()
                        return
                    end

                    if abs(mouse.X - startX) > 25 then
                        break
                    end
                end

                while sliding and not object.Options.Disabled and con.Connected do
                    spawn(object.Call, object, clamp((mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1), true)
                    render()
                end

                if c.Connected then
                    c:Disconnect()
                end

                sliding = false
            end)

            cons[#cons + 1] = con
            cons[#cons + 1] = instance.InputEnded:Connect(function(input) 
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    sliding = false
                end
            end)

            object.Options._Value = clamp(object.Options.Value / (object.Options.Max - object.Options.Min), 0, 1)
            return object
        end,
        Call = function(self, value, valueCompare)    
            value = clamp(tonumber(value) or 0.5, 0, 1)

            if value ~= value then
                value = 0
            end

            local realValue = value * (self.Options.Max - self.Options.Min) + self.Options.Min
            realValue = round(realValue * 1e8) / 1e8

            if self.Options.Step > 0 then
                realValue = floor((realValue + self.Options.Step / 2) / self.Options.Step) * self.Options.Step
            end

            realValue = clamp(realValue, self.Options.Min, self.Options.Max)
            if valueCompare and realValue == self.Options.Value then return self:Refresh() end

            self.Options._Value = value
            self.Options.Value = realValue

            self:Refresh()
            spawn(playSound, "Hover", self)
            self.Changed:Fire(realValue, self.Proxy)
            softCallback(self.Options.Callback, realValue, self.Proxy)
        end,
        Refresh = function(self)
            local texttt = translate(self, "Text")
            local forceCompact = clean(texttt) == ""
            local options = self.Options
            local compact = options.Compact or forceCompact
            local parnt = self.Parent
            local ispgb = parnt.Class == "Groupbox"

            local y = ispgb and (compact and 30 or 40) or (compact and 30 or 50)
            local y2 = ispgb and 14 or 16
            local x = ispgb and -14 or -30

            if options.Minimum ~= nil then
                options.Min, options.Minimum = options.Minimum, nil
            end
            if options.Maximum ~= nil then
                options.Max, options.Maximum = options.Maximum, nil
            end

            local window = getWindow(self)
            local woptions = window.Options

            local inst = self.Instance
            local view = inst.View
            local theme = window.Theme
            local themeT = theme.Text
            local themeS = theme.Stroke

            local viewBar = view.Bar
            local viewLabel = view.Label

            local viewBarProgress = viewBar.Progress
            local viewBarFill = viewBar.Fill

            inst.Separator.BackgroundColor3 = themeT
            viewLabel.TextColor3 = themeT
            viewBar.BackgroundColor3 = themeS
            viewBarFill.BackgroundColor3 = theme.Main
            viewBarProgress.TextColor3 = themeT
            viewBarProgress.TextStrokeColor3 = themeS
            viewBar.Position = U2s(0.5, compact and 0.5 or 1.65)
            viewBar.UIStroke.Color = themeS
            orderUpdate(inst, options.Order)

            inst.Visible = options.Visible
            safeReparent(inst, ispgb and parnt.Holder.Holder.Contents or parnt.Holder.NormalZone)

            options.Maximum = options.Max
            options.Minimum = options.Min

            if typeof(options.Format) ~= "function" then
                options.Format = functions[options.Format or ""] or functions["/"]
            end

            local formattedText = options.Format and (typeof(options.Format) == "string" and options["Format"] --[[suspend studio warning]] or tostring(options.Format(self.Proxy or options))) or fixNum((self.Proxy or options).Value) .. " / " .. fixNum((self.Proxy or options).Max)

            viewLabel.Visible = not compact
            viewBarProgress.TextXAlignment = compact and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center
            viewBarProgress.Visible = not options._SettingValue
            viewBar.InputProgress.Visible = options._SettingValue
            viewBar.InputProgress.TextXAlignment = viewBarProgress.TextXAlignment

            if not compact then
                viewBarProgress.Text = formattedText
                viewLabel.Text = texttt
            else
                viewBarProgress.Text = forceCompact and (options.ShowCompactValue and formattedText or "") or texttt .. (options.ShowCompactValue and " (" .. formattedText .. ")" or "")
            end

            viewLabel.TextTransparency = options.Disabled and 0.35 or 0
            viewBarFill.BackgroundTransparency = options.Disabled and 0.35 or 0

            local style = options.Styled
            local styled = not not style
            viewBarProgress.TextTransparency = options.Disabled and not styled and 0.35 or 0

            local styleObject = viewBar:FindFirstChild("Style")
            styleObject.Visible = styled
            styleObject.Shadow.Visible = style == true or style == "Shadow"
            styleObject.Shine.Visible = style == true or style == "Shine"

            inst.Size = U2n(1, 0, 0, y)
            view.Size = U2n(1, x, 0, y2)
            view.Position = ispgb and U2n(0, 7, compact and 0.5 or 0.275, 0) or U2n(0, 15, compact and 0.5 or 0.3, 0)
            viewBar.UICorner.CornerRadius = cornerState[woptions.RoundEverything]
            viewBarFill.UICorner.CornerRadius = cornerState[woptions.RoundEverything]
            viewBar.UIStroke.Enabled = not woptions.NoStrokes

            local x = options.Value == -inf and 0 or options.Value == inf and 1 or clamp((options.Value - options.Min) / (options.Max - options.Min), 0, 1)
            if x ~= x then
                x = 0
            end

            tweenOnce(viewBarFill, TIn(max(0.25 / handleAnimationSpeed(getWindow(self).AnimationSpeed), 0.05), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = U2s(x, 0) })
        end
    },
    TextBox = {
        Class = "TextBox",
        DefaultOptions = {
            Text = "Text Box",
            NoConfigs = false,
            Callback = function(text) end,
            Visible = true,
            MultiLine = false,
            RequiresEnter = false, -- WARNING: if MultiLine is enabled, this will be ignored
            Instant = false, -- when true, it will always call the Callback when text changes
            ValueUsesPlaceholder = false, -- when true, if text == "", it will use placeholder text instead
            Tooltip = "",
            DisabledTooltip = "",
            PlaceholderText = "Type here...", -- supports Rich Text
            Value = "",
            Disabled = false,
            Order = false,
            Translations = tfreeze({ })
        },
        Set = function(self, value)
            local old = self.Options.Value
            self.Options.Value = value
            self:Refresh()

            if old ~= self.Options.Value then
                self.Changed:Fire(self.Options.Value, self)
                spawn(softCallback, self.Options.Callback, self.Options.Value, self)
            end
        end,
        Init = function(self, options)
            local instance = getPlaceholder("TextBox")
            local object = addFunctions({
                Options = options,
                Instance = instance,
                Changed = event.new(),
                Class = self.Class
            }, self)

            defer(hoverLogic, object, instance)

            local cons = { }
            defer(addCons, object, cons)

            cons[#cons + 1] = instance.MouseButton1Click:Connect(function()
                object:Click()
            end)

            cons[#cons + 1] = instance.MouseButton1Down:Connect(function()
                if object.Proxy.Disabled then return end
                castCircle(instance, getWindow(object))
            end)

            cons[#cons + 1] = instance.MouseEnter:Connect(function()
                if object.Proxy.Disabled then return end
                spawn(playSound, "Hover", object)
            end)

            cons[#cons + 1] = instance.View.Bar.FocusLost:Connect(function(enter)
                if (object.Options.MultiLine or object.Options.RequiresEnter and enter or not object.Options.RequiresEnter) and not object.Options.Instant then
                    object:Call(instance.View.Bar.Text)
                end

                object:Refresh(true)
                render()
                object:Refresh(true)
            end)

            local cd = true
            cons[#cons + 1] = instance.View.BarInvisible.Changed:Connect(function()
                if not cd or not getWindow(object).Visible then return end
                cd = false
                object:Refresh(true)
                render()
                object:Refresh(true)
                cd = true
                render()
                object:Refresh(true)
            end)

            local oldN = 1
            cons[#cons + 1] = instance.View.Bar:GetPropertyChangedSignal("Text"):Connect(function()
                local new = instance.View.Bar.Text

                local newN = quickCount(new, "\n")
                local diff = newN - oldN

                oldN = newN

                if object.Proxy.Parent.Class ~= "Groupbox" then
                    object.Proxy.Parent.Holder.CanvasPosition += V2n(0, diff * 12)
                end

                instance.View.BarInvisible.RichText = #new == 0
                instance.View.BarInvisible.Text = (#new == 0 and object.Options.PlaceholderText or new):sub(0, 199999)
                object:Refresh(true)

                if not object.Options.Instant then return end
                object:Call(new)
            end)

            return object
        end,
        Call = function(self, text)
            text = tostring(text)
            self.Options.Value = text

            if text == "" and self.Options.ValueUsesPlaceholder then
                text = tostring(self.Options.PlaceholderText)
            end

            self.Proxy:Refresh(true)
            self.Changed:Fire(text, self.Proxy)
            softCallback(self.Options.Callback, text, self.Proxy)
        end,
        Click = function(self)
            spawn(playSound, "Click", self)
            self.Proxy:Refresh()
            self.Instance.View.Bar:CaptureFocus()
        end,
        Refresh = function(self, dontSetText)
            local parnt = self.Parent
            local ispgb = parnt.Class == "Groupbox"
            local y = ispgb and 40 or 50
            local y2 = ispgb and 14 or 16
            local x = ispgb and -14 or -30

            local options = self.Options

            local window = getWindow(self)
            local inst = self.Instance
            local view = inst.View
            local woptions = window.Options

            local theme = window.Theme
            local themeT = theme.Text
            local themeS = theme.Stroke
            
            local viewLabel = view.Label
            local viewBar = view.Bar
            local vbph = viewBar.Placeholder
            local vuis = viewBar.UIStroke
            
            inst.Separator.BackgroundColor3 = themeT
            viewLabel.TextColor3 = themeT
            viewBar.BackgroundColor3 = themeS
            viewBar.PlaceholderColor3 = themeT
            viewBar.TextColor3 = themeT
            vbph.TextColor3 = themeT
            vuis.Color = themeS
            orderUpdate(inst, options.Order)

            inst.Visible = options.Visible
            safeReparent(inst, ispgb and parnt.Holder.Holder.Contents or parnt.Holder.NormalZone)
            viewBar.PlaceholderText = ""
            viewLabel.Text = translate(self, "Text")
            viewBar.MultiLine = options.MultiLine
            viewBar.TextEditable = not options.Disabled
            viewBar.TextTransparency = options.Disabled and (viewBar.Text == "" and 0.85 or 0.65) or viewBar.Text == "" and 0.45 or 0
            viewLabel.TextTransparency = options.Disabled and 0.35 or 0
            vbph.Text = translate(self, "PlaceholderText"):sub(1, 199999)
            vbph.Visible = viewBar.Text == ""
            vbph.RichText = true
            viewBar.RichText = false
            vbph.TextTransparency = viewBar.TextTransparency
            viewBar.Size = U2n(1, 0, 0, view.BarInvisible.TextBounds.Y + 2)
            inst.Size = U2n(1, 0, 0, (y - 14) + viewBar.Size.Y.Offset)
            view.Size = U2n(1, x, 0, y2)
            view.Position = ispgb and U2n(0, 7, 0, 1) or U2n(0, 15, 0, 8)
            view.AnchorPoint = V2n(0, 0)
            viewBar.UICorner.CornerRadius = cornerState[woptions.RoundEverything]
            vuis.Enabled = not woptions.NoStrokes

            if not dontSetText then
                viewBar.Text = options.Value
            end
        end
    },
    Label = {
        Class = "Label",
        DefaultOptions = {
            Text = "Label",
            Visible = true,
            Order = false,
            Translations = tfreeze({ })
        },
        AddColorPicker = acp,
        ColorPicker = acp,
        NewColorPicker = acp,
        Init = function(self, options)
            local instance = getPlaceholder("Label")
            local object = addFunctions({
                Options = options,
                ColorPickers = { },
                Instance = instance,
                Class = self.Class
            }, self)

            local cons = { }
            defer(addCons, object, cons)

            local cd = true
            cons[#cons + 1] = instance.Label.Changed:Connect(function()
                if not cd or not getWindow(object).Visible then return end

                cd = false
                instance.Label.Size = U2n(1, -30, 0, getTextSize(instance.Label.Text, instance.Label.TextSize, instance.Label.Font, V2n(instance.Label.AbsoluteSize.X, 99999)).Y)
                instance.Size = U2n(1, 0, 0, instance.Label.TextBounds.Y + (24 - (object.Proxy.Parent.Class == "Groupbox" and 9 or 0)))
                render()
                instance.Label.Size = U2n(1, -30, 0, getTextSize(instance.Label.Text, instance.Label.TextSize, instance.Label.Font, V2n(instance.Label.AbsoluteSize.X, 99999)).Y)
                instance.Size = U2n(1, 0, 0, instance.Label.TextBounds.Y + (24 - (object.Proxy.Parent.Class == "Groupbox" and 9 or 0)))
                cd = true
                render()
                instance.Label.Size = U2n(1, -30, 0, getTextSize(instance.Label.Text, instance.Label.TextSize, instance.Label.Font, V2n(instance.Label.AbsoluteSize.X, 99999)).Y)
                instance.Size = U2n(1, 0, 0, instance.Label.TextBounds.Y + (24 - (object.Proxy.Parent.Class == "Groupbox" and 9 or 0)))
            end)

            return object
        end,
        Refresh = function(self)
            local parnt = self.Parent
            local ispgb = parnt.Class == "Groupbox"
            local y = ispgb and 14 or 16

            local window = getWindow(self)
            local inst = self.Instance

            local themeT = window.Theme.Text
            
            inst.Separator.BackgroundColor3 = themeT
            inst.Label.TextColor3 = themeT
            inst.Label.TextSize = y

            orderUpdate(inst, self.Options.Order)
            inst.Visible = self.Options.Visible
            safeReparent(inst, ispgb and parnt.Holder.Holder.Contents or parnt.Holder.NormalZone)
            inst.Label.Text = translate(self, "Text"):sub(0, 199999)
            inst.Label.Position = ispgb and U2o(9, 5) or U2o(15, 12)
        end
    },
    Header = {
        Class = "Header",
        DefaultOptions = {
            Text = "Header",
            Visible = true,
            Order = false,
            Translations = tfreeze({ }),
            ShowStart = true
        },
        Init = function(self, options)
            local instance = getPlaceholder("Header")
            local object = addFunctions({
                Options = options,
                Instance = instance,
                Class = self.Class
            }, self)

            local cons = { }
            defer(addCons, object, cons)

            local cd = true
            cons[#cons + 1] = instance.View.Label.Changed:Connect(function()
                if not cd or not getWindow(object).Visible then return end

                cd = false
                instance.View.Label.Size = U2n(0, getTextSize(instance.View.Label.Text, instance.View.Label.TextSize, instance.View.Label.Font, V2n(99999, 99999)).X, 1, 0)
                render()
                instance.View.Label.Size = U2n(0, getTextSize(instance.View.Label.Text, instance.View.Label.TextSize, instance.View.Label.Font, V2n(99999, 99999)).X, 1, 0)
                cd = true
                render()
                instance.View.Label.Size = U2n(0, getTextSize(instance.View.Label.Text, instance.View.Label.TextSize, instance.View.Label.Font, V2n(99999, 99999)).X, 1, 0)
            end)

            return object
        end,
        Refresh = function(self)
            local window = getWindow(self)
            local inst = self.Instance
            local options = self.Options
            local parnt = self.Parent
            local ispgb = parnt.Class == "Groupbox"

            inst.Separator.BackgroundColor3 = window.Theme.Text
            inst.View.Left.BackgroundColor3 = window.Theme.Text
            inst.View.Right.BackgroundColor3 = window.Theme.Text
            inst.View.Label.TextColor3 = window.Theme.Text
            inst.View.Left.Visible = options.ShowStart

            orderUpdate(inst, options.Order)
            inst.Visible = options.Visible
            safeReparent(inst, ispgb and parnt.Holder.Holder.Contents or parnt.Holder.NormalZone)
            inst.View.Label.Text = translate(self, "Text"):sub(0, 199999)
            inst.View.Label.Position = ispgb and U2o(9, 5) or U2o(15, 12)
        end
    },
    Separator = {
        Class = "Separator",
        DefaultOptions = {
            Visible = true,
            Invisible = false,
            Order = false,
        },
        Init = function(self, options)
            local instance = getPlaceholder("Separator")
            return addFunctions({
                Options = options,
                Instance = instance,
                Class = self.Class
            }, self)
        end,
        Refresh = function(self)
            local inst = self.Instance
            local options = self.Options
            local parnt = self.Parent
            
            local themeT = getWindow(self).Theme.Text
            
            inst.Separator.BackgroundColor3 = themeT
            inst.SeparatorMiddle.BackgroundColor3 = themeT

            inst.Visible = options.Visible
            orderUpdate(inst, options.Order)
            safeReparent(inst, parnt.Class == "Groupbox" and parnt.Holder.Holder.Contents or parnt.Holder.NormalZone)
            inst.SeparatorMiddle.Visible = not options.Invisible
            inst.Size = U2n(1, 0, 0, 10)
        end
    },
    Toggle = {
        Class = "Toggle",
        DefaultOptions = {
            Text = "Toggle",
            NoConfigs = false,
            Callback = function(bool) end,
            Visible = true,
            Value = false,
            Disabled = false,
            CheckBox = false,
            Tooltip = "",
            DisabledTooltip = "",
            Order = false,
            Translations = tfreeze({ })
        },
        Set = function(self, value)
            local old = self.Options.Value
            self.Options.Value = value
            self:Refresh()

            if old ~= self.Options.Value then
                self.Changed:Fire(self.Options.Value, self)
                spawn(softCallback, self.Options.Callback, self.Options.Value, self)
            end
        end,
        AddColorPicker = acp,
        ColorPicker = acp,
        NewColorPicker = acp,
        Init = function(self, options)
            local instance = getPlaceholder("Toggle")
            local object = addFunctions({
                Options = options,
                ColorPickers = { },
                Instance = instance,
                Changed = event.new(),
                Class = self.Class
            }, self)

            defer(hoverLogic, object, instance)
            defer(keybindSetup, object)

            local cons = { }
            defer(addCons, object, cons)

            cons[#cons + 1] = instance.MouseButton1Click:Connect(function()
                object:Click()
            end)

            cons[#cons + 1] = instance.MouseButton1Down:Connect(function()
                if object.Proxy.Disabled then return end
                castCircle(instance, getWindow(object))
            end)

            return object
        end,
        Call = function(self, value)
            self.Changed:Fire(value, self.Proxy)
            softCallback(self.Options.Callback, value, self.Proxy)
        end,
        Toggle = function(self, value, noCallback)
            if value == nil then
                value = not self.Options.Value
            end

            self.Options.Value = not not value
            self.Proxy:Refresh()

            if not noCallback then
                self:Call(self.Options.Value)
            end
        end,
        Click = function(self)
            if self.Options.Disabled then return end
            spawn(playSound, "Click", self)
            self:Toggle()
        end,
        Refresh = function(self)
            local parnt = self.Parent
            local ispgb = parnt.Class == "Groupbox"

            local y = ispgb and 25 or 40
            local y2 = ispgb and 14 or 16
            local x = ispgb and 7 or 15

            local inst = self.Instance
            local view = inst.View
            local options = self.Options

            inst.Visible = options.Visible
            orderUpdate(inst, options.Order)
            safeReparent(inst, ispgb and parnt.Holder.Holder.Contents or parnt.Holder.NormalZone)

            local label = view.Label
            local vicon = view.Icon
            local iconFrame = vicon.Frame
            local frState = iconFrame.State
            local uic = iconFrame.UICorner
            local uis = iconFrame.UIStroke

            label.Text = translate(self, "Text")
            label.TextTransparency = options.Disabled and 0.35 or 0
            vicon[options.CheckBox and "BackgroundTransparency" or "ImageTransparency"] = 1
            inst.Size = U2n(1, 0, 0, y)
            view.Size = U2n(100, 0, 0, y2)
            view.Position = U2n(0, x, 0.5, 0)
            vicon.Size = ispgb and U2s(1, 1) or U2s(1.2, 1.2)

            local window = getWindow(self)
            local woptions = window.Options
            
            local theme = window.Theme
            local themeS = theme.Stroke
            local themeT = theme.Text
            local themeM = theme.Main
            
            inst.Separator.BackgroundColor3 = themeT
            label.TextColor3 = themeT
            vicon.ImageColor3 = themeM
            vicon.BackgroundColor3 = themeM
            vicon.UIStroke.Color = themeS
            frState.BackgroundColor3 = themeT:Lerp(themeM, 0.67 --[[omg another 67]]):Lerp(themeS, options.Disabled and 0.5 or 0)
            vicon.UICorner.CornerRadius = cornerState[woptions.RoundEverything]

            local strokes = not woptions.NoStrokes
            local isModern = not strokes or woptions.ModernToggles and not options.CheckBox
            vicon.UIStroke.Enabled = not isModern and strokes
            iconFrame.Visible = isModern
            vicon.UIAspectRatioConstraint.AspectRatio = not isModern and 0.975 or (ispgb or woptions.LargeModernToggles) and 1.7 or 1.3
            uic.CornerRadius = Un(woptions.RoundEverything and 1 or 0, 0)
            frState.UICorner.CornerRadius = uic.CornerRadius
            uis.Enabled = strokes
            uis.Color = themeS
            
            local as = 0.3 / handleAnimationSpeed(window.AnimationSpeed)
            tweenOnce(iconFrame, TIn(as), { BackgroundColor3 = (options.Value and themeM or themeS):Lerp(themeS, options.Disabled and 0.5 or 0) })
            tweenOnce(frState, TIn(as), { Position = U2s(options.Value and 1 or 0), AnchorPoint = V2n(options.Value and 1 or 0, 0) })

            if not isModern then
                tweenOnce(vicon, TIn(as), { [options.CheckBox and "BackgroundTransparency" or "ImageTransparency"] = 1, [options.CheckBox and "ImageTransparency" or "BackgroundTransparency"] = not options.Disabled and (options.Value and 0 or 1) or options.Value and 0.75 or 1 })
            else
                tweenOnce(vicon, TIn(0.01), { ImageTransparency = 1, BackgroundTransparency = 1 })
            end
        end
    },
    Input = {
        Class = "Input",
        DefaultOptions = {
            Text = "Input",
            NoConfigs = false,
            KeySet = function(value : Enum.KeyCode) end,
            Callback = function() end,
            Visible = true,
            Value = false,
            Disabled = false,
            Order = false,

            Tooltip = "",
            DisabledTooltip = "",

            Translations = tfreeze({ })
        },
        Set = function(self, value)
            local old = self.Options.Value
            self.Options.Value = value
            self:Refresh()

            if old ~= self.Options.Value then
                self.Changed:Fire(self.Options.Value ~= false and Enum.KeyCode:FromValue(self.Options.Value) or nil, self.Proxy)
                spawn(self.Options.KeySet, self.Options.Value ~= false and Enum.KeyCode:FromValue(self.Options.Value) or nil, self.Proxy)
            end
        end,
        AddColorPicker = acp,
        ColorPicker = acp,
        NewColorPicker = acp,
        Init = function(self, options)
            local instance = getPlaceholder("Input")
            local object = addFunctions({
                Options = options,
                ColorPickers = { },
                Instance = instance,
                Changed = event.new(),
                Class = self.Class
            }, self)

            defer(hoverLogic, object, instance)

            local cons = { }
            defer(addCons, object, cons)

            cons[#cons + 1] = instance.MouseButton1Click:Connect(function()
                object.Proxy:Click()
            end)

            cons[#cons + 1] = instance.MouseButton1Down:Connect(function()
                if object.Proxy.Disabled then return end
                castCircle(instance, getWindow(object))
            end)

            defer(object.Setup, object)

            return object
        end,
        Setup = function(self)
            self = self.Proxy

            local window = getWindow(self)
            window._Connections[#window._Connections + 1] = uis.InputBegan:Connect(function(input, chat)
                if chat or input.KeyCode.Value ~= self.Options.Value then return end
                self:Callback()
            end)
        end,
        KeyClick = function(self)
            if self.Options.Disabled then return end
            spawn(softCallback, self.Options.Callback, self)
        end,
        Call = function(self, value)
            self.Options.Value = value
            self.Proxy:Refresh()

            self.Changed:Fire(self.Options.Value ~= false and Enum.KeyCode:FromValue(self.Options.Value) or nil, self.Proxy)
            self.Options.KeySet(self.Options.Value ~= false and Enum.KeyCode:FromValue(self.Options.Value) or nil, self.Proxy)
        end,
        Click = function(self)
            if self.Options.Disabled then return end

            spawn(playSound, "Click", self)
            local i = inputting
            inputting = self

            if i then
                if i == inputting then
                    inputting = false
                    self:Call(false)
                else
                    i:Refresh()
                end
            end

            self:Refresh()
        end,
        Refresh = function(self)
            local parnt = self.Parent
            local ispgb = parnt.Class == "Groupbox"
            local options = self.Options

            local y = ispgb and 25 or 40
            local y2 = ispgb and 14 or 16
            local x = ispgb and 7 or 15

            local window = getWindow(self)
            local woptions = window.Options
            
            local inst = self.Instance
            local view = inst.View
            local viewLabel = view.Label
            local viewDisplay = view.Display
            local vuis = viewDisplay.UIStroke

            orderUpdate(inst, options.Order)
            inst.Visible = options.Visible and window.IsDesktop
            safeReparent(inst, ispgb and parnt.Holder.Holder.Contents or parnt.Holder.NormalZone)
            viewLabel.Text = translate(self, "Text")
            viewLabel.TextTransparency = options.Disabled and 0.35 or 0
            viewDisplay.TextTransparency = options.Disabled and 0.35 or 0
            inst.Size = U2n(1, 0, 0, y)
            view.Size = U2n(100, 0, 0, y2)
            view.Position = U2n(0, x, 0.5, 0)
            
            local theme = window.Theme
            local themeT = theme.Text
            local themeS = theme.Stroke

            inst.Separator.BackgroundColor3 = themeT
            viewLabel.TextColor3 = themeT
            viewDisplay.TextColor3 = theme.Main
            vuis.Color = themeS
            viewDisplay.UICorner.CornerRadius = cornerState[woptions.RoundEverything]
            vuis.Enabled = not woptions.NoStrokes
            viewDisplay.BackgroundColor3 = themeS

            local v = options.Value
            if typeof(v) == "EnumItem" then
                v = v.Value
            elseif tonumber(v) then
                v = tonumber(v)
            elseif Enum.KeyCode:FromName(tostring(v)) then
                v = Enum.KeyCode:FromName(tostring(v)).Value
            else
                v = false
            end

            options.Value = v
            if inputting == self then
                viewDisplay.Text = "..."
            else
                viewDisplay.Text = (not options.Value or not Enum.KeyCode:FromValue(options.Value)) and "None" or gsubInput(Enum.KeyCode:FromValue(options.Value).Name)
            end
        end
    }
}

local groupBoxFuncs = {
    Class = "Groupbox",
    DefaultOptions = {
        Text = "",
        Side = "Left",
        Visible = true,
        Order = 0,
        Translations = tfreeze({ })
    },
    Init = function(self, options)
        local groupbox = getPlaceholder("Groupbox")

        local object = addFunctions({
            Options = options,
            Holder = groupbox,
            Objects = { },
            ChildAdded = event.new(),
            Class = self.Class
        }, self)

        options._Objects = 0
        defer(addPossibleTranslations, object)

        local cons = { }
        defer(addCons, object, cons)

        cons[#cons + 1] = object.ChildAdded:Connect(function(newObject)
            options._Objects += 1

            if newObject and newObject.Options then
                if newObject.Options.Order == false then
                    newObject.Order = -max32 + options._Objects
                end

                if typeof(object.Options.Translations) == "table" and object.Options.Translations[newObject.Flag] then
                    newObject.Options.Translations = object.Options.Translations[newObject.Flag]
                    defer(addPossibleTranslations, newObject)
                end
            else
                warn("Invalid object", newObject)
            end
        end)

        local function r()
            object.Proxy:Refresh()
        end

        cons[#cons + 1] = object.Holder.Holder.Contents.ChildAdded:Connect(function(ch)
            cons[#cons + 1] = ch:GetPropertyChangedSignal("Visible"):Connect(r)
            cons[#cons + 1] = ch:GetPropertyChangedSignal("Size"):Connect(r)
            r()
        end)

        cons[#cons + 1] = object.Holder.Holder.Contents.ChildRemoved:Connect(r)

        return object
    end,
    Refresh = function(self)
        local window = getWindow(self)
        local holder = self.Holder.Holder
        local options = self.Options
        local woptions = window.Options
        local theme = window.Theme
        local themeT = theme.Text
        local themeS = theme.Stroke
        
        local hp = holder.Parent
        local hc = holder.Contents
        local huis = holder.UIStroke
        local ht = holder.Title

        holder.BackgroundColor3 = themeT
        huis.Color = themeS
        hc.BackgroundColor3 = themeS
        holder.Frame.BackgroundColor3 = window.Theme.Main
        ht.TextColor3 = themeT
        holder.UICorner.CornerRadius = cornerState[woptions.RoundEverything]
        hc.UICorner.CornerRadius = cornerState[woptions.RoundEverything]
        huis.Enabled = not woptions.NoStrokes

        local texttt = translate(self, "Text")
        local textVisible = clean(texttt) ~= ""

        ht.Text = texttt
        safeReparent(hp, self.Parent.Holder.GroupboxZone[options.Side .. "GroupboxZone"])
        orderUpdate(hp, options.Order)

        local ySize = 0
        for i, v in hc:GetChildren() do
            if v:IsA("GuiObject") and v.Visible then
                ySize += v.AbsoluteSize.Y
            end
        end

        hc.Position = U2n(0.5, 0, 0, textVisible and 20 or 7)
        hc.Size = U2n(1, -10, 1, textVisible and -25 or -10)
        hp.Size = U2n(1, 0, 0, ySize ~= 0 and (textVisible and 35 or 20) + ySize or 0)
        hp.Visible = options.Visible and ySize ~= 0
    end
}

local function initTabButton(tabButton, object, cons, options)
    defer(hoverLogic, object, tabButton)

    cons[#cons + 1] = tabButton.MouseButton1Down:Connect(function()
        castCircle(tabButton, getWindow(object))
    end)

    cons[#cons + 1] = tabButton.MouseEnter:Connect(function()
        spawn(playSound, "Hover", object)
        tweenOnce(tabButton.ButtonItself.Icon, TIn(0.4 / handleAnimationSpeed(getWindow(object).AnimationSpeed)), { ImageTransparency = 0 })
        tweenOnce(tabButton.ButtonItself.Title, TIn(0.4 / handleAnimationSpeed(getWindow(object).AnimationSpeed)), { TextTransparency = 0 })
    end)

    cons[#cons + 1] = tabButton.MouseLeave:Connect(function()
        if object.Parent.CurrentTab and object.Parent.CurrentTab.Holder ~= object.Holder or not object.Parent.CurrentTab then
            tweenOnce(tabButton.ButtonItself.Icon, TIn(0.6 / handleAnimationSpeed(getWindow(object).AnimationSpeed)), { ImageTransparency = 0.25 })
            tweenOnce(tabButton.ButtonItself.Title, TIn(0.6 / handleAnimationSpeed(getWindow(object).AnimationSpeed)), { TextTransparency = 0.25 })
        end
    end)

    cons[#cons + 1] = tabButton.MouseButton1Click:Connect(function()
        spawn(playSound, "Click", object)
        object:SwitchTo()
    end)

    cons[#cons + 1] = tabButton.ButtonItself.Icon.Changed:Connect(function()
        tabButton.ButtonItself.Icon.Visible = setIcon(options.Icon, icons, object.Proxy, tabButton.ButtonItself.Icon) ~= ""
    end)
end

local tabFuncs = {
    Class = "Tab",
    DefaultOptions = {
        Icon = "",
        Text = "Tab",
        Visible = true,
        Tooltip = "",
        DisabledTooltip = "",
        RecolorIcon = true,
        Translations = tfreeze({ }),
        Order = 0,
        Image = ""
    },
    Init = function(self, options)
        local tabButton = getPlaceholder("TabButton")
        local tab = getPlaceholder("Tab")
        tab.Visible = false

        local object = addFunctions({
            Options = options,
            TabButton = tabButton,
            Holder = tab,
            Objects = { },
            ChildAdded = event.new(),
            Class = self.Class
        }, self)

        options._Objects = 0
        defer(addPossibleTranslations, object)

        local cons = { }
        defer(addCons, object, cons)

        cons[#cons + 1] = object.ChildAdded:Connect(function(newObject)
            options._Objects += 1

            if newObject and newObject.Options then
                if newObject.Options.Order == false then
                    newObject.Order = -max32 + options._Objects
                end

                if typeof(object.Options.Translations) == "table" and object.Options.Translations[newObject.Flag] then
                    newObject.Options.Translations = object.Options.Translations[newObject.Flag]
                    defer(addPossibleTranslations, newObject)
                end
            else
                warn("Invalid object", newObject)
            end
        end)

        initTabButton(tabButton, object, cons, options)

        cons[#cons + 1] = tab.NormalZone.ChildAdded:Connect(function(child)
            object.Proxy:Refresh()

            if child:IsA("GuiObject") then
                cons[#cons + 1] = child:GetPropertyChangedSignal("Visible"):Connect(function()
                    object.Proxy:Refresh()
                end)
                cons[#cons + 1] = child:GetPropertyChangedSignal("Size"):Connect(function()
                    object.Proxy:Refresh()
                end)
            end
        end)

        cons[#cons + 1] = tab.NormalZone.ChildRemoved:Connect(function()
            object.Proxy:Refresh()
        end)

        local gbc2 = function()
            object.Proxy:Refresh()
        end

        local gbc; gbc = function(child)
            object.Proxy:Refresh()

            if child:IsA("GuiObject") then
                cons[#cons + 1] = child:GetPropertyChangedSignal("Visible"):Connect(function()
                    object.Proxy:Refresh()
                end)

                cons[#cons + 1] = child:GetPropertyChangedSignal("Size"):Connect(function()
                    object.Proxy:Refresh()
                end)
            end
        end

        cons[#cons + 1] = tab.GroupboxZone.LeftGroupboxZone.ChildAdded:Connect(gbc)
        cons[#cons + 1] = tab.GroupboxZone.LeftGroupboxZone.ChildRemoved:Connect(gbc2)
        cons[#cons + 1] = tab.GroupboxZone.RightGroupboxZone.ChildAdded:Connect(gbc)
        cons[#cons + 1] = tab.GroupboxZone.RightGroupboxZone.ChildRemoved:Connect(gbc2)

        local cnt = 0
        cons[#cons + 1] = rs.RenderStepped:Connect(function()
            cnt = (cnt + 1) % 5

            if cnt == 0 then
                tab.MobileSizeFix.Size = U2n(mrandom(), 0, 0, 1)
            end
        end)

        defer(function()
            render()
            if not object.Parent.Self.CurrentTab then
                object.Proxy:SwitchTo()
            end
        end)

        return object
    end,
    SwitchTo = function(self, dont)
        local window = getWindow(self)
        if not window then return self end

        for i, v in self.Parent.Objects do
            if v.Class == "Tab" or v.Class == "CustomTab" then
                local visible = v.Proxy == self.Proxy
                v.Holder.Visible = visible

                tweenOnce(v.TabButton.ButtonItself.Icon, TIn(0.75 / handleAnimationSpeed(window.AnimationSpeed)), { ImageTransparency = visible and 0 or 0.25 })
                tweenOnce(v.TabButton.ButtonItself.Title, TIn(0.75 / handleAnimationSpeed(window.AnimationSpeed)), { TextTransparency = visible and 0 or 0.25 })
                tweenOnce(v.TabButton, TIn(1.5 / handleAnimationSpeed(window.AnimationSpeed)), { BackgroundTransparency = visible and 0.95 or 1 })
                tweenOnce(v.TabButton.Indicator, TIn(0.5 / handleAnimationSpeed(window.AnimationSpeed)), { Position = U2n(0, visible and 0 or -2, 0.5, 0) })
            end
        end

        self.Parent.Self.CurrentTab = self.Proxy
        return self:Refresh(dont)
    end,
    Refresh = function(self, dont)
        local window = getWindow(self)
        if not window then return self end

        local options = self.Options
        local tb = self.TabButton
        local bi = tb.ButtonItself
        local holder = self.Holder
        local class = self.Class
        local parnt = self.Parent
        local prox = self.Proxy

        local ls = "LibrarySettings" .. window.Flag
        if options.Flag:sub(1, #ls) ~= ls then
            local pwrcd = parnt.Window.RealWindow.Contents.DisplayBlur.Downsampler.Display
            safeReparent(tb, pwrcd.PageButtons.List)
            safeReparent(holder, pwrcd.Pages)
        end

        setIcon(options.Icon, icons, prox, bi.Icon)
        bi.Title.Text = translate(self, "Text")
        bi.Visible = options.Visible
        
        local theme = window.Theme
        local themeM = theme.Main
        local themeT = theme.Text

        tb.BackgroundColor3 = themeM
        tb.Indicator.BackgroundColor3 = themeM
        tb.Filler.BackgroundColor3 = themeT
        setIcon(options.Image, backgrounds, prox, tb.ImageLabel)
        orderUpdate(tb, tonumber(options.Order) or 0)
        bi.Icon.ImageColor3 = options.RecolorIcon and themeT or C3n(1, 1, 1)
        bi.Title.TextColor3 = themeT

        if class == "Tab" then
            holder.ScrollBarImageColor3 = themeM

            local ySize = 0
            for i, v in holder.NormalZone:GetChildren() do
                if v:IsA("GuiObject") and v.Visible then
                    ySize += v.AbsoluteSize.Y
                end
            end

            holder.NormalZone.Size = U2n(1, 0, 0, ySize)

            local leftYSize = 0
            local rightYSize = 0

            local gbz = holder.GroupboxZone
            for i, v in gbz.LeftGroupboxZone:GetChildren() do
                if v:IsA("GuiObject") and v.Visible then
                    leftYSize += v.AbsoluteSize.Y
                end
            end

            for i, v in gbz.RightGroupboxZone:GetChildren() do
                if v:IsA("GuiObject") and v.Visible then
                    rightYSize += v.AbsoluteSize.Y
                end
            end

            gbz.Size = U2n(1, 0, 0, max(leftYSize, rightYSize))
        end

        if not options.Visible and parnt.CurrentTab and parnt.CurrentTab.Proxy == prox then
            parnt.CurrentTab.Holder.Visible = false
            parnt.Self.CurrentTab = false
        elseif options.Visible and parnt.CurrentTab and prox == parnt.CurrentTab.Proxy and not dont then
            return self:SwitchTo(true)
        end

        return self
    end,
    AddGroupbox = function(...)
        local object = newObject(groupBoxFuncs, ...);
        (...).Objects[object.Flag] = object;
        (...).ChildAdded:Fire(object)

        return object
    end,
    Groupbox = function(self, ...)
        return self:AddGroupbox(...)
    end,
    NewGroupbox = function(self, ...)
        return self:AddGroupbox(...)
    end,
    AddLeftGroupbox = function(self, ...)
        local gb = self:AddGroupbox(...)
        gb.Side = "Left"

        return gb
    end,
    LeftGroupbox = function(self, ...)
        return self:AddLeftGroupbox(...)
    end,
    NewLeftGroupbox = function(self, ...)
        return self:AddLeftGroupbox(...)
    end,
    AddRightGroupbox = function(self, ...)
        local gb = self:AddGroupbox(...)
        gb.Side = "Right"

        return gb
    end,
    RightGroupbox = function(self, ...)
        return self:AddRightGroupbox(...)
    end,
    NewRightGroupbox = function(self, ...)
        return self:AddRightGroupbox(...)
    end
}

local customTabFuncs = {
    Class = "CustomTab",
    Init = function(self, options)
        local tabButton = getPlaceholder("TabButton")
        local tab = getPlaceholder("CustomTab")

        local object = addFunctions({
            Options = options,
            TabButton = tabButton,
            Holder = tab,
            Frame = tab,
            ConfigSet = event.new(),
            Class = self.Class
        }, self)

        defer(addPossibleTranslations, object)

        local cons = { }
        defer(addCons, object, cons)
        initTabButton(tabButton, object, cons, options)

        defer(function()
            if not object.Parent.CurrentTab then
                object.Proxy:SwitchTo()
            end
        end)

        return object
    end,
    Set = function(self, value)
        local oldValue = self.Value
        if value ~= oldValue then
            self.Value = value
            self.ConfigSet:Fire(value)
        end
    end,
    SwitchTo = tabFuncs.SwitchTo,
    Refresh = tabFuncs.Refresh
}

customTabFuncs.DefaultOptions = tclone(tabFuncs.DefaultOptions)
customTabFuncs.DefaultOptions.Value = ""
customTabFuncs.DefaultOptions.NoConfigs = false

basicObjects.Keybind = basicObjects.Input
for i, v in basicObjects do
    tabFuncs["Add" .. i] = function(...)
        local object = newObject(v, ...);
        (...).Objects[object.Flag] = object;
        (...).ChildAdded:Fire(object)

        return object
    end

    tabFuncs[i] = function(...) return tabFuncs["Add" .. i](...) end
    tabFuncs["New" .. i] = function(...) return tabFuncs["Add" .. i](...) end

    groupBoxFuncs["Add" .. i] = tabFuncs[i]
    groupBoxFuncs["New" .. i] = tabFuncs[i]
    groupBoxFuncs[i] = tabFuncs[i]
end

local toggle = tabFuncs.AddToggle
tabFuncs.AddCheckBox = function(...)
    local toggle = toggle(...)
    toggle.CheckBox = true

    return toggle
end

tabFuncs.CheckBox = tabFuncs.AddCheckBox
tabFuncs.NewCheckBox = tabFuncs.AddCheckBox
groupBoxFuncs.AddCheckBox = tabFuncs.AddCheckBox
groupBoxFuncs.CheckBox = tabFuncs.AddCheckBox
groupBoxFuncs.NewCheckBox = tabFuncs.AddCheckBox

local function unlockMouse()
    uis.MouseBehavior = Enum.MouseBehavior.Default
end

local function makeDraggable(instance, object, cons, dragTarget, resetDelta, noSmooth)
    dragTarget = dragTarget or instance
    
    local dragPos, dragStartPosition, dragConnection, dragUpConnection
    local con = instance.MouseButton1Down:Connect(function()
        local window = getWindow(object)
        
        dragStartPosition = dragTarget.Position
        dragPos = V2n(mouse.X, mouse.Y)

        if dragConnection then
            dragConnection:Disconnect()
            dragConnection = nil
        end

        if dragUpConnection then
            dragUpConnection:Disconnect()
            dragUpConnection = nil
        end

        dragConnection = mouse.Move:Connect(function()
            local mouseVec = V2n(mouse.X, mouse.Y)
            local delta = mouseVec - dragPos
            
            if resetDelta then
                dragPos = mouseVec
            end
            
            if not noSmooth then
                dragTarget:TweenPosition(U2n(dragStartPosition.X.Scale, dragStartPosition.X.Offset + delta.X, dragStartPosition.Y.Scale, dragStartPosition.Y.Offset + delta.Y), nil, nil, 0.35 / handleAnimationSpeed(window.Options.AnimationSpeed), true)
            else
                if not resetDelta then
                    dragTarget.Position = U2n(dragStartPosition.X.Scale, dragStartPosition.X.Offset + delta.X, dragStartPosition.Y.Scale, dragStartPosition.Y.Offset + delta.Y)
                else
                    dragTarget.Position = U2n(dragTarget.Position.X.Scale, dragTarget.Position.X.Offset + delta.X, dragTarget.Position.Y.Scale, dragTarget.Position.Y.Offset + delta.Y)
                end
            end
        end)

        dragUpConnection = uis.InputEnded:Connect(function(input)
            if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end

            dragConnection:Disconnect()
            dragUpConnection:Disconnect()

            dragConnection, dragUpConnection = nil, nil
        end)
    end)

    if cons then
        cons[#cons + 1] = con
    end
end

local defaultNotificationOptions = { __index = {
    Duration = 5,
    Title = "Notification",
    Text = "Hello, world!",
    HasButtons = false,
    Icon = "",
    Side = "-",
    UseOgScaling = "-",
    Callback = function(state) end
} }

local defaultColorPickerOptions = { __index = {
    Text = "Color picker",
    Value = C3n(1, 1, 1),
    Callback = function(color) end
} }

local floatingLabel = {
    Class = "FloatingLabel",
    DefaultOptions = {
        Text = "",
        Title = "",
        Position = U2n(0, 20, 0.5, 0),
        AnchorPoint = V2n(0, 0.5),
        Visible = true,
        Icon = "",

        _text = "",
        _icon = "",
        _title = "",
        _position = "",
    },

    Init = function(self, options)
        local floatingLabel = getPlaceholder("FloatingLabel")

        local cons = { }
        local object = addFunctions({
            Label = floatingLabel,
            Options = options,
            Connections = cons,
            Destroying = event.new(),
            Class = self.Class
        }, self)

        defer(addCons, object, cons)

        local canChange = true
        cons[#cons + 1] = floatingLabel.Changed:Connect(function()
            if not canChange then return end

            canChange = false
            object:_Rescale()

            render()

            object:_Rescale()
            canChange = true
        end)

        makeDraggable(floatingLabel, object, cons)
        object.Options._text ..= " "

        return object
    end,

    Destroy = function(self)
        self.Destroying:Fire()
        self.Label:Destroy()

        for i, v in self.Connections do
            v:Disconnect()
        end

        local window = getWindow(self)
        if not window then return end

        window.Objects[self.Flag] = nil
    end,

    _Rescale = function(self)
        local l = self.Label
        if not l or not l:FindFirstChild("Contents") then return end

        local l1, l2 = l.Contents.Contents.Text, l.Contents.Contents.Title
        local t1, t2 = l1.TextBounds, l2.TextBounds
        local hasIcon = setIcon(self.Options.Icon, icons, self, l2.ImageLabel) ~= ""

        l2.ImageLabel.Visible = hasIcon

        local add = hasIcon and 24 or 0
        local a1, a2 = #l1.Text ~= 0, #l2.Text ~= 0

        l1.Size = U2n(1, 0, 1, -16)
        l1.Position = U2o(0, 16)
        l.Visible = self.Options.Visible and (a1 or a2)

        if a1 and a2 then
            l.Size = U2o(max(t1.X, t2.X + 16) + 8 + add, t1.Y + t2.Y + 7)
        elseif a1 then
            l1.Size = U2s(1, 1)
            l1.Position = U2s(0, 0)

            l.Size = U2o(t1.X + 8, t1.Y + 8)
        elseif a2 then
            l.Size = U2o(t2.X + 24 + add, 22)
        end
    end,

    Refresh = function(self)
        local window = getWindow(self)
        if not window or window.Closed then return end

        local l = self.Label
        local options = self.Options

        safeReparent(l, gui.FloatingLabels)
        
        local lc = l.Contents
        local lcc = lc.Contents
        local lcct = lcc.Title
        local lcct2 = lcc.Text
        
        l.AnchorPoint = options.AnchorPoint
        l.Visible = options.Visible and (#lcct2.Text ~= 0 or #lcct.Text ~= 0)

        local op = options.Position
        if options._position ~= op then
            options._position = op
            l.Position = op
        end

        if options._text ~= options.Text or options._title ~= options.Title or options._icon ~= options.Icon then
            options._text, options._title, options._icon = options.Text, options.Title, options.Icon

            lcct2.Text = options.Text:sub(1, 199999)
            lcct.Text = options.Title:sub(1, 199999)
            self:_Rescale()
        end
        
        local theme = window.Theme
        local themeT = theme.Text
        local woptions = window.Options

        lc.BackgroundColor3 = theme.Back
        lc.OutsideStroke.Color = theme.Stroke
        lcct.TextColor3 = themeT
        lcct2.TextColor3 = themeT
        lc.TopNeon.BackgroundColor3 = theme.Main
        lc.UICorner.CornerRadius = cornerState[woptions.RoundEverything]
        lc.OutsideStroke.Enabled = not woptions.NoStrokes
    end
}

local tabHeaderFuncs = {
    Class = "Header",
    DefaultOptions = {
        Text = "Header",
        Visible = true,
        Order = false,
        Translations = tfreeze({ }),
        ShowStart = true
    },
    Init = function(self, options)
        local instance = getPlaceholder("TabHeader")
        local object = addFunctions({
            Options = options,
            Instance = instance,
            Class = self.Class
        }, self)

        local cons = { }
        defer(addCons, object, cons)

        local cd = true
        cons[#cons + 1] = instance.View.Label.Changed:Connect(function()
            if not cd or not getWindow(object).Visible then return end

            cd = false
            instance.View.Label.Size = U2n(0, getTextSize(instance.View.Label.Text, instance.View.Label.TextSize, instance.View.Label.Font, V2n(99999, 99999)).X, 1, 0)
            render()
            instance.View.Label.Size = U2n(0, getTextSize(instance.View.Label.Text, instance.View.Label.TextSize, instance.View.Label.Font, V2n(99999, 99999)).X, 1, 0)
            cd = true
            render()
            instance.View.Label.Size = U2n(0, getTextSize(instance.View.Label.Text, instance.View.Label.TextSize, instance.View.Label.Font, V2n(99999, 99999)).X, 1, 0)
        end)

        return object
    end,
    Refresh = function(self)
        local inst = self.Instance
        local options = self.Options
        
        local themeT = getWindow(self).Theme.Text
        local view = inst.View
        local left = view.Left
        local label = view.Label

        inst.Separator.BackgroundColor3 = themeT
        left.BackgroundColor3 = themeT
        view.Right.BackgroundColor3 = themeT
        label.TextColor3 = themeT
        left.Visible = options.ShowStart

        orderUpdate(inst, options.Order)
        inst.Visible = options.Visible
        safeReparent(inst, self.Parent.Window.RealWindow.Contents.DisplayBlur.Downsampler.Display.PageButtons.List)
        label.Text = translate(self, "Text"):sub(0, 199999)
    end
}

local tabSeparatorFuncs = {
    Class = "Separator",
    DefaultOptions = {
        Visible = true,
        Invisible = false,
        Order = false,
    },
    Init = function(self, options)
        local instance = getPlaceholder("TabSeparator")
        return addFunctions({
            Options = options,
            Instance = instance,
            Class = self.Class
        }, self)
    end,
    Refresh = function(self)
        local inst = self.Instance
        local window = getWindow(self)
        local options = self.Options

        local spm = inst.SeparatorMiddle
        local themeT = window.Theme.Text

        inst.Separator.BackgroundColor3 = themeT
        spm.BackgroundColor3 = themeT

        inst.Visible = options.Visible
        orderUpdate(inst, options.Order)
        safeReparent(inst, self.Parent.Window.RealWindow.Contents.DisplayBlur.Downsampler.Display.PageButtons.List)
        spm.Visible = not options.Invisible
        inst.Size = U2n(1, 0, 0, 10)
    end
}

local nsaCacheRoute = coreFolder .. "NSACache" .. json
local neverShowAgainCache do
    if IF and IF(nsaCacheRoute) then
        local s, r = pcall(rf, nsaCacheRoute, true)
        if s and typeof(r) == "table" then
            neverShowAgainCache = r
            print("LOADED FROM FILES")
        end
    end
    
    if typeof(neverShowAgainCache) ~= "table" then
        neverShowAgainCache = { }
        
        if wf then
            pcall(wf, nsaCacheRoute, neverShowAgainCache)
        end
    end
end

local iwnFunctions = {
    Class = "WindowNotification",
    DefaultOptions = {
        Title = "In-Window Notification",
        Text = "Hello, World!",
        HasButtons = false,
        _exists = false,
        NeverShowAgainFlag = nil,
        _returned = nil
    },
    Init = function(self, options)
        local instance = getPlaceholder("IWNotification")
        instance.GroupTransparency = 1
        
        local destroying = event.new()
        local object = addFunctions({
            Options = options,
            Instance = instance,
            Class = self.Class,
            Destroying = destroying
        }, self)
        
        local nsaf = options.NeverShowAgainFlag
        local nsa = neverShowAgainCache[nsaf]
        if nsa ~= nil then
            options._returned = nsa
            defer(destroying.Fire, destroying)
            
            return
        end

        local localCons = { }
        local nsaState = false
        if nsaf ~= nil then
            localCons[#localCons + 1] = instance.ButtonsZone.Toggle.MouseButton1Down:Connect(function()
                castCircle(instance.ButtonsZone.Toggle, getWindow(object.Proxy))
            end)
            
            local function refreshState()
                tweenOnce(instance.ButtonsZone.Toggle.View.Icon, TIn(0.3 / handleAnimationSpeed(getWindow(object.Proxy).AnimationSpeed)), { ImageTransparency = nsaState and 0 or 1 })
            end
            
            localCons[#localCons + 1] = instance.ButtonsZone.Toggle.MouseButton1Click:Connect(function()
                nsaState = not nsaState
                refreshState()
            end)
            
            refreshState()
        end
        
        local b1 = getPlaceholder("IWNButton")
        b1.Parent = instance.ButtonsZone.Buttons
        b1.TextButton.Label.Text = "OK"
        b1.TextButton.ImageLabel.Image = "rbxassetid://130396712201457"
        orderUpdate(b1, 1)
        
        options._b1 = b1

        localCons[#localCons + 1] = b1.TextButton.MouseButton1Down:Connect(function()
            castCircle(b1.TextButton, getWindow(object))
        end)
        
        localCons[#localCons + 1] = b1.TextButton.MouseButton1Click:Once(function()
            options._returned = true
            destroying:Fire()
        end)
        
        if options.HasButtons then
            local b2 = getPlaceholder("IWNButton")
            b2.Parent = instance.ButtonsZone.Buttons
            b2.TextButton.Label.Text = "NO"
            b2.TextButton.ImageLabel.Image = "rbxassetid://10152135063"
            options._b2 = b2
            
            localCons[#localCons + 1] = b2.TextButton.MouseButton1Down:Connect(function()
                castCircle(b2.TextButton, getWindow(object))
            end)
            
            localCons[#localCons + 1] = b2.TextButton.MouseButton1Click:Once(function()
                options._returned = false
                destroying:Fire()
            end)
        end
        
        destroying:Once(function()
            getWindow(object)._WindowNotificationRemoving:Fire(object.Proxy)
            
            if nsaState then
                neverShowAgainCache[nsaf] = false
                if wf then
                    pcall(wf, nsaCacheRoute, neverShowAgainCache)
                end
            end
            
            wait()

            for i, v in localCons do
                v:Disconnect()
            end

            localCons = nil
        end)
        
        defer(themeSync, object, localCons)
        defer(addPossibleTranslations, object)
        
        return object
    end,
    Refresh = function(self)
        local inst = self.Instance
        local options = self.Options

        inst.TextZone.Text.Text = translate(self, "Text")
        inst.TextZone.Title.Text = translate(self, "Title")
        inst.ButtonsZone.Toggle.Visible = options.NeverShowAgainFlag ~= nil

        if not options._exists then return end
        
        local window = getWindow(self.Proxy or self)
        if not window then return end
        
        local woptions = window.Options

        local themeT = woptions.Theme.Text
        local themeM = woptions.Theme.Main
        local themeB = woptions.Theme.Back
        local themeS = woptions.Theme.Stroke
        
        inst.BackgroundColor3 = themeB
        inst.Shading.BackgroundColor3 = themeS
        inst.UIStroke.Color = themeS
        inst.UICorner.CornerRadius = Un(0, woptions.CornerRadius * 0.1)
        inst.TextZone.Text.TextColor3 = themeT
        inst.TextZone.Title.TextColor3 = themeT
        inst.ButtonsZone.Toggle.View.Icon.ImageColor3 = themeM
        inst.ButtonsZone.Toggle.View.Icon.UIStroke.Color = themeS
        inst.ButtonsZone.Toggle.View.Icon.UICorner.CornerRadius = cornerState[woptions.RoundEverything]
        inst.ButtonsZone.Toggle.View.Label.TextColor3 = themeT
        
        options._b1.GroupColor3 = themeM
        options._b1.TextButton.UICorner.CornerRadius = cornerState[woptions.RoundEverything]
        options._b1.TextButton.UIStroke.Enabled = not woptions.NoStrokes
        
        local tr = translate(self, "Dialog1", true)
        if #tr == 0 then
            tr = UI_DEBUG.EN_DIALOG_BUTTONS[1]
        end
        
        options._b1.TextButton.Label.Text = tr
        
        if options._b2 then
            options._b2.GroupColor3 = themeT:Lerp(themeS, 0.5)
            options._b2.TextButton.UICorner.CornerRadius = cornerState[woptions.RoundEverything]
            options._b2.TextButton.UIStroke.Enabled = not woptions.NoStrokes
            
            tr = translate(self, "Dialog2", true)
            if #tr == 0 then
                tr = UI_DEBUG.EN_DIALOG_BUTTONS[2]
            end

            options._b2.TextButton.Label.Text = tr
        end
    end
}

local handleWNS do
    local function refreshWNSQueue(wnsq, window)
        local qSize = min(#wnsq, 3)
        local offs = window.Window.RealWindow.Contents.NotificationsOverlay.Offsetter
        offs:TweenPosition(U2o(0, (max(qSize, 1) - 1) * -2))
        tweenOnce(offs.Parent, TIn(0.15), { BackgroundTransparency = qSize > 0 and 0.25 or 1 })
        
        if qSize > 0 then
            for i = 1, qSize do
                local v = wnsq[i]
                if not v then break end

                v._exists = true
                local v = v.Instance
                safeReparent(v, offs)
                
                tweenOnce(v, TIn(0.15), { GroupTransparency = 0 })
                v:TweenSizeAndPosition(U2n(0.2, 220 - ((i - 1) * 10), 0.2, 120), U2n(0.5, 0, 0.5, (i - 1) * 4), nil, nil, 0.15, true)
                v.Shading.BackgroundTransparency = 1 - ((i - 1) / 3)
                v.ZIndex = 110 - i
            end
        end
    end
    
    local function destroyIWN(iwn)
        local inst = iwn.Instance
        inst.ZIndex = 110
        tweenOnce(inst, TIn(0.2), { Size = U2n(inst.Size.X.Scale, inst.Size.X.Offset + 40, inst.Size.Y.Scale, inst.Size.Y.Offset + 40), GroupTransparency = 1 })
        wait(0.2)
        inst:Destroy()
    end
    
    handleWNS = function(wnsQueue, window, iwn, destroyed)
        if destroyed then
            spawn(destroyIWN, iwn)
        end
        
        refreshWNSQueue(wnsQueue, window)
    end
end

local function _decodeThingy(thing)
    return jd(encoder:Decode(thing))
end

local function refreshBlurs(blurs, enabled)
    for _, blur in blurs do
        if enabled then
            local enabled = false
            for _, v in blur[1] do
                if v then
                    enabled = true
                    break
                end
            end
        
            blur[2].Intensity = enabled and (blur[4] or blur[5] or 1.5) or 0
        else
            blur[2].Intensity = 0
        end
    end
end

local windowFuncs; windowFuncs = {
    Class = "Window",
    GetTheme = function(window)
        local theme = {
            Type = 8,

            ["0"] = window.Options.ShadowSize,
            ["1"] = floor(window.Options.ShadowTransparency * 100),
            ["2"] = floor(window.Options.BackgroundTransparency * 100),
            ["3"] = window.Options.ImageEnabled and 1 or 0,
            ["4"] = tonumber(window.Options.ImageColor:ToHex(), 16),
            ["5"] = floor(window.Options.ImageTransparency * 100),
            ["6"] = window.Options.Image,
            ["7"] = window.Options.NeonThickness,
            ["8"] = window.Options.NeonType,
            ["9"] = window.Options.NotificationSide,
            ["10"] = window.Options.AnimationSpeed,
            ["11"] = window.Options.Volume,
            ["12"] = window.Options.MobileButtonAlwaysVisible and 1 or 0,
            ["13"] = window.Options.MobileButtonVisible and 1 or 0,
            ["14"] = window.Options.NotificationOgScaling and 1 or 0,
            ["15"] = tonumber(window.Options.Theme.Main:ToHex(), 16),
            ["16"] = tonumber(window.Options.Theme.Stroke:ToHex(), 16),
            ["17"] = tonumber(window.Options.Theme.Back:ToHex(), 16),
            ["18"] = tonumber(window.Options.Theme.Text:ToHex(), 16),
            ["19"] = window.Options.InfoLabelExtra,
            ["20"] = window.Options.ExtraInfoLabelTextEnabled and 1 or 0,
            ["21"] = window.Options.OutsideStroke and 1 or 0,
            ["22"] = floor(window.Options.CornerRadius),
            ["23"] = window.Options.BlurBackground and 1 or 0,
            ["24"] = window.Options.FullBlurSize and 1 or 0,
            ["25"] = floor(uiBackBlur.BlurSize * 100),
            ["26"] = window.Options.RoundEverything and 1 or 0,
            ["27"] = window.Options.NoStrokes and 1 or 0,
            ["28"] = window.Options.ModernToggles and 1 or 0,
            ["29"] = window.Options.LargeModernToggles and 1 or 0,
            ["30"] = window.Options.InfoLabelExtraAntiRich and 1 or 0,
            ["31"] = window.Options.EnableUIBlur and 1 or 0,
            ["32"] = window.Options.BlurProfile and 1 or 0
        }

        return theme
    end,
    SetTheme = function(window, theme)
        local type = tonumber(theme.Type)
        if not type or floor(type) ~= type or type > 8 or type < 1 then window:Notification({ Title = "Theme", Text = "The given theme is not a theme (most likely a config!)" }) return false end

        if type == 1 then
            window.Options.ShadowSize = theme.ShadowSize
            window.Options.ShadowTransparency = theme.ShadowTransparency
            window.Options.BackgroundTransparency = theme.BackgroundTransparency
            window.Options.ImageEnabled = theme.ImageEnabled
            window.Options.ImageColor = C3h(string["for" .. "mat"]("%06x", theme.ImageColor)) -- suspend studio warning
            window.Options.ImageTransparency = theme.ImageTransparency
            window.Options.Image = theme.Image
            window.Options.NeonThickness = theme.NeonThickness
            window.Options.NeonType = theme.NeonType
            window.Options.NotificationSide = theme.NotificationSide
            window.Options.AnimationSpeed = theme.AnimationSpeed
            window.Options.Volume = theme.Volume
            window.Options.MobileButtonAlwaysVisible = theme.MobileButtonAlwaysVisible
            window.Options.MobileButtonVisible = theme.MobileButtonVisible
            window.Options.Theme.Main = C3h(string["for" .. "mat"]("%06x", theme.Main)) -- same here and under
            window.Options.Theme.Stroke = C3h(string["for" .. "mat"]("%06x", theme.Stroke))
            window.Options.Theme.Back = C3h(string["for" .. "mat"]("%06x", theme.Back))
            window.Options.Theme.Text = C3h(string["for" .. "mat"]("%06x", theme.Text))
            window.Options.OutsideStroke = true
            window.Options.CornerRadius = 0
            window.Options.BlurBackground = false
            window.Options.InfoLabelExtra = ""
            window.Options.ExtraInfoLabelTextEnabled = true
            window.Options.NotificationOgScaling = false
            window.Options.FullBlurSize = false
            uiBackBlur.BlurSize = 1
            window.Options.RoundEverything = false
            window.Options.NoStrokes = false
            window.Options.ModernToggles = false
            window.Options.LargeModernToggles = false
            window.Options.InfoLabelExtraAntiRich = true
        else
            window.Options.ShadowSize = theme["0"]
            window.Options.ShadowTransparency = theme["1"] / 100
            window.Options.BackgroundTransparency = theme["2"] / 100
            window.Options.ImageEnabled = theme["3"] == 1
            window.Options.ImageColor = C3h(string["for" .. "mat"]("%06x", theme["4"])) -- suspend studio warning
            window.Options.ImageTransparency = theme["5"] / 100
            window.Options.Image = theme["6"]
            window.Options.NeonThickness = theme["7"]
            window.Options.NeonType = theme["8"]
            window.Options.NotificationSide = theme["9"]
            window.Options.AnimationSpeed = theme["10"]
            window.Options.Volume = theme["11"]
            window.Options.MobileButtonAlwaysVisible = theme["12"] == 1
            window.Options.MobileButtonVisible = theme["13"] == 1
            window.Options.NotificationOgScaling = theme["14"] == 1
            window.Options.Theme.Main = C3h(string["for" .. "mat"]("%06x", theme["15"])) -- same here and under
            window.Options.Theme.Stroke = C3h(string["for" .. "mat"]("%06x", theme["16"]))
            window.Options.Theme.Back = C3h(string["for" .. "mat"]("%06x", theme["17"]))
            window.Options.Theme.Text = C3h(string["for" .. "mat"]("%06x", theme["18"]))

            if type >= 3 then
                window.Options.InfoLabelExtra = theme["19"]
                window.Options.ExtraInfoLabelTextEnabled = theme["20"] == 1
            else
                window.Options.InfoLabelExtra = ""
                window.Options.ExtraInfoLabelTextEnabled = true
            end

            if type >= 4 then
                window.Options.OutsideStroke = theme["21"] == 1
                window.Options.CornerRadius = theme["22"]
                window.Options.BlurBackground = theme["23"] == 1
            else
                window.Options.OutsideStroke = true
                window.Options.CornerRadius = 0
                window.Options.BlurBackground = false
            end

            if type >= 5 then
                window.Options.FullBlurSize = theme["24"] == 1
            else
                window.Options.FullBlurSize = false
            end

            if type >= 6 then
                uiBackBlur.BlurSize = theme["25"] / 100
            else
                uiBackBlur.BlurSize = 1
            end

            if type >= 7 then
                window.Options.RoundEverything = theme["26"] == 1
                window.Options.NoStrokes = theme["27"] == 1
                window.Options.ModernToggles = theme["28"] == 1
                window.Options.LargeModernToggles = theme["29"] == 1
                window.Options.InfoLabelExtraAntiRich = theme["30"] == 1
            else
                window.Options.RoundEverything = false
                window.Options.NoStrokes = false
                window.Options.ModernToggles = false
                window.Options.LargeModernToggles = false
                window.Options.InfoLabelExtraAntiRich = true
            end
            
            if type >= 8 then
                window.Options.EnableUIBlur = theme["31"] == 1
                window.Options.BlurProfile = theme["32"] == 1
            else
                window.Options.EnableUIBlur = true
                window.Options.BlurProfile = false
            end
        end

        window:Refresh()
        return true
    end,
    GetConfig = function(self, cfg, getCfg)
        getCfg = getCfg or self.GetConfig
        cfg = cfg or { Type = 0 }

        local options = self.Options
        local cl = self.Class
        local fl = options.Flag

        if cl == "FloatingLabel" or cl == "Separator" or cl == "Header" then return end

        if cl == "ColorPicker" then
            if options.NoConfigs then return end
            return tonumber(options.Value:ToHex(), 16)
        end

        if cl == "Keybind" then
            return options.Value or -1 -- bypass NoConfigs, because you can set keybind to anything
        end

        if cl == "Button" or cl == "Label" then
            local pickers = { }
            for i, v in self.ColorPickers do
                pickers[tostring(i)] = getCfg(v, cfg, getCfg)
            end

            if count(pickers) == 0 then return end
            return { ColorPickers = pickers } -- fun fact: Keybinds also count as ColorPickers in that situation XD
        end

        if cl == "Toggle" or cl == "Input" then
            local pickers = { }
            for i, v in self.ColorPickers do
                pickers[tostring(i)] = getCfg(v, cfg, getCfg)
            end

            local c = count(pickers)
            local nc = options.NoConfigs

            if c == 0 and nc then return end

            local value = cl == "Toggle" and (options.Value and 1 or 0) or options.Value
            return c ~= 0 and not nc and {
                Value = value,
                ColorPickers = pickers
            } or c ~= 0 and {
                ColorPickers = pickers
            } or value
        end

        if cl == "Dropdown" or cl == "Slider" or cl == "TextBox" or cl == "CustomTab" then
            if options.NoConfigs then return end
            return options.Value
        end

        if cl == "Window" or cl == "Tab" or cl == "Groupbox" then
            for i, v in self.Objects do
                cfg[i] = getCfg(v, { }, getCfg)
            end

            return cfg
        end

        return warn("Unknown class", cl)
    end,
    SetConfig = function(self, cfg, setCfg)
        setCfg = setCfg or self.SetConfig

        local cl = self.Class
        local window = getWindow(self) or cl == "Window" and self
        if self == window and cfg.Type ~= 0 then window:Notification({ Title = "Config", Text = "The given config is not a config (most likely a theme!)" }) return false end

        local options = self.Options
        local fl = options.Flag
        if cfg == nil or cl == "FloatingLabel" or cl == "Separator" or cl == "Header" then return end

        if cl == "ColorPicker" then
            if options.NoConfigs then return end
            local newCol = C3h(string["for" .. "mat"]("%06x", cfg)) -- suspend studio warning
            if options.Value == newCol then return end

            return self:Set(newCol)
        end

        if cl == "Keybind" then
            return self:Set(cfg ~= -1 and cfg or nil) -- also bypass NoConfigs here
        end

        if cl == "CustomTab" then
            if options.NoConfigs then return end
            return self:Set(cfg)
        end

        if cl == "Dropdown" then
            if options.NoConfigs or tEqual(options.Value, cfg) then return end
            return self:Set(cfg)
        end

        if cl == "Window" or cl == "Tab" or cl == "Groupbox" then
            for i, v in cfg do
                local obj = self.Objects[i]
                if obj then
                    setCfg(obj, v, setCfg)
                end
            end

            return
        end

        local isToggle = cl == "Toggle"
        if typeof(cfg) == "table" then
            if cfg.ColorPickers then
                for i, v in cfg.ColorPickers do
                    i = tonumber(i)

                    local obj = self.ColorPickers[i]
                    if obj then
                        setCfg(obj, v, setCfg)
                    end
                end
            end

            if cfg.Value ~= nil then
                local b = typeof(cfg.Value) == "boolean"
                local value = b and cfg or not b and isToggle and cfg.Value == 1 or not isToggle and cfg.Value

                if options.NoConfigs or options.Value == value then return end
                self:Set(value)
            end
        else
            local b = typeof(cfg) == "boolean"
            local value = b and cfg or not b and isToggle and cfg == 1 or not isToggle and cfg

            if options.NoConfigs or options.Value == value then return end
            self:Set(value)
        end

        return true
    end,

    GetThemeString = function(self)
        return self:EncodeShareString(self:GetTheme())
    end,
    SetThemeString = function(self, str)
        local result = self:DecodeShareString(str)
        if not result or typeof(result) ~= "table" then return false, false end

        local res = self:SetTheme(result)
        return true, res == nil and true or res
    end,

    GetConfigString = function(self)
        return self:EncodeShareString(self:GetConfig())
    end,
    SetConfigString = function(self, str)
        local result = self:DecodeShareString(str)
        if not result or typeof(result) ~= "table" then return false, false end

        local res = self:SetConfig(result)
        return true, res == nil and true or res
    end,

    DecodeShareString = function(self, str)
        local s, e = _pcall(_decodeThingy, str)
        return s and e or false
    end,
    EncodeShareString = function(self, str)
        return encoder:Encode(je(str))
    end,

    FloatingLabel = function(...)
        local label = newObject(floatingLabel, ...);
        (...).Objects[label.Flag] = label;
        (...).ChildAdded:Fire(label)

        return label
    end,
    ColorPicker = function(self, options)
        local opts = setmetatable(options or { }, defaultColorPickerOptions)
        local options = self.Options

        local cp = getPlaceholder("ColorPickerWindow")
        safeReparent(cp, gui.Holder.ColorPickerWindows)
        cp.Visible = true

        local cons = { }

        local first = true
        local function applyTheme()
            if options.KeepTheme and not first then return end
            first = false

            local options = self.Options
            cp.Contents.BackgroundColor3 = self.Theme.Back
            cp.Contents.TopNeon.BackgroundColor3 = self.Theme.Main
            cp.Contents.OutsideStroke.Color = self.Theme.Stroke
            cp.Contents.OutsideStroke.Enabled = not options.NoStrokes
            cp.Contents.UICorner.CornerRadius = cornerState[options.RoundEverything]
            cp.Contents.Contents.TopbarZone.Title.TextColor3 = self.Theme.Text
            cp.Contents.Contents.TopbarZone.Right.Close.ImageLabel.ImageColor3 = self.Theme.Text
            cp.Contents.Contents.Display.ColorZone.HUEZone.UIStroke.Color = self.Theme.Stroke
            cp.Contents.Contents.Display.ColorZone.HUEZone.Cursor.BackgroundColor3 = self.Theme.Text
            cp.Contents.Contents.Display.ColorZone.HUEZone.Cursor.UIStroke.Color = self.Theme.Stroke
            cp.Contents.Contents.Display.ColorZone.PickerZone.Contents.UIStroke.Color = self.Theme.Stroke
            cp.Contents.Contents.Display.ColorZone.PickerZone.Contents.Cursor.BackgroundColor3 = self.Theme.Text
            cp.Contents.Contents.Display.ColorZone.PickerZone.Contents.Cursor.UIStroke.Color = self.Theme.Stroke
            cp.Contents.Contents.Display.ColorZone.Preview.UIStroke.Color = self.Theme.Stroke
            cp.Contents.Contents.TopbarZone.Title.Text = options.Text or "Color Picker"
            cp.Contents.Contents.Display.ColorZone.Preview.UICorner.CornerRadius = cornerState[options.RoundEverything]
            cp.Contents.Contents.Display.ColorZone.HUEZone.UICorner.CornerRadius = cornerState[options.RoundEverything]
            cp.Contents.Contents.Display.ColorZone.PickerZone.Contents.UICorner.CornerRadius = cornerState[options.RoundEverything]
            cp.Contents.Contents.Display.BottomZone.TextButton.UICorner.CornerRadius = cornerState[options.RoundEverything]
            cp.Contents.Contents.Display.BottomZone.TextBoxes.R.UICorner.CornerRadius = cornerState[options.RoundEverything]
            cp.Contents.Contents.Display.BottomZone.TextBoxes.G.UICorner.CornerRadius = cornerState[options.RoundEverything]
            cp.Contents.Contents.Display.BottomZone.TextBoxes.B.UICorner.CornerRadius = cornerState[options.RoundEverything]

            cp.Contents.Contents.Display.ColorZone.Preview.UIStroke.Enabled = not options.NoStrokes
            cp.Contents.Contents.Display.ColorZone.HUEZone.UIStroke.Enabled = not options.NoStrokes
            cp.Contents.Contents.Display.ColorZone.PickerZone.Contents.UIStroke.Enabled = not options.NoStrokes
            cp.Contents.Contents.Display.BottomZone.TextButton.UIStroke.Enabled = not options.NoStrokes
            cp.Contents.Contents.Display.BottomZone.TextBoxes.R.UIStroke.Enabled = not options.NoStrokes
            cp.Contents.Contents.Display.BottomZone.TextBoxes.G.UIStroke.Enabled = not options.NoStrokes
            cp.Contents.Contents.Display.BottomZone.TextBoxes.B.UIStroke.Enabled = not options.NoStrokes

            for i, v in cp.Contents.Contents.Display.BottomZone.TextBoxes:GetChildren() do
                if v:IsA("TextButton") then
                    v.BackgroundColor3 = self.Theme.Stroke
                    v.UIStroke.Color = self.Theme.Stroke
                    v.TextBox.TextColor3 = self.Theme.Text
                    v.TextLabel.TextColor3 = self.Theme.Text
                end
            end

            cp.Contents.Contents.Display.BottomZone.TextButton.BackgroundColor3 = self.Theme.Text
            cp.Contents.Contents.Display.BottomZone.TextButton.TextColor3 = self.Theme.Text
            cp.Contents.Contents.Display.BottomZone.TextButton.UIStroke.Color = self.Theme.Stroke
        end

        cons[#cons + 1] = self.ThemeChanged:Connect(applyTheme)
        applyTheme()

        cp.Size = U2o(50, 50)

        tweenOnce(cp, TIn(1 / handleAnimationSpeed(options.AnimationSpeed), Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = U2s(0.8, 0.8) })

        local HSV = { }
        HSV.H, HSV.S, HSV.V = opts.Value:ToHSV()

        local fHSV = Color3.fromHSV
        local function updateColor()
            local rgb = fHSV(HSV.H, HSV.S, HSV.V)

            cp.Contents.Contents.Display.ColorZone.PickerZone.Contents.Cursor.Position = U2s(HSV.S, 1 - HSV.V)
            cp.Contents.Contents.Display.ColorZone.HUEZone.Cursor.Position = U2s(0.5, HSV.H)
            cp.Contents.Contents.Display.ColorZone.Preview.BackgroundColor3 = rgb
            cp.Contents.Contents.Display.ColorZone.PickerZone.Contents.BackgroundColor3 = fHSV(HSV.H, 1, 1)
            cp.Contents.Contents.Display.BottomZone.TextBoxes.R.TextBox.Text = tostring(clamp(round(rgb.R * 255), 0, 255))
            cp.Contents.Contents.Display.BottomZone.TextBoxes.G.TextBox.Text = tostring(clamp(round(rgb.G * 255), 0, 255))
            cp.Contents.Contents.Display.BottomZone.TextBoxes.B.TextBox.Text = tostring(clamp(round(rgb.B * 255), 0, 255))

            render()
        end

        makeDraggable(cp, self, cons)

        local HDragging = false
        local VSDragging = false

        local con1; con1 = cp.Contents.Contents.Display.ColorZone.HUEZone.InputBegan:Connect(function(input)
            if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
            HDragging = true

            local old = uis.MouseIconEnabled
            uis.MouseIconEnabled = false
            tweenOnce(cp.Contents.Contents.Display.ColorZone.HUEZone.Cursor, TIn(0.35 / handleAnimationSpeed(options.AnimationSpeed)), { Size = U2n(1, 2, 0, 5), BackgroundTransparency = 0 })

            while HDragging and con1.Connected do
                HSV.H = clamp((mouse.Y - cp.Contents.Contents.Display.ColorZone.HUEZone.AbsolutePosition.Y) / cp.Contents.Contents.Display.ColorZone.HUEZone.AbsoluteSize.Y, 0, 1)
                self.Tooltip = "Hue: " .. floor(HSV.H * 360) .. "°"
                tooltipObject.CustomMousePosition = cp.Contents.Contents.Display.ColorZone.HUEZone.Cursor.AbsolutePosition + V2n(cp.Contents.Contents.Display.ColorZone.HUEZone.Cursor.AbsoluteSize.X - 2)

                updateColor()
            end

            tooltipObject.CustomMousePosition = mouse
            uis.MouseIconEnabled = old
            tweenOnce(cp.Contents.Contents.Display.ColorZone.HUEZone.Cursor, TIn(0.5 / handleAnimationSpeed(options.AnimationSpeed)), { Size = U2n(1, 2, 0, 2), BackgroundTransparency = 0.25 })

            wait(render())
            self.Tooltip = ""
        end)

        cons[#cons + 1] = cp.Contents.Contents.Display.ColorZone.HUEZone.InputEnded:Connect(function(input) 
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
                HDragging = false
            end
        end)

        local con2; con2 = cp.Contents.Contents.Display.ColorZone.PickerZone.InputBegan:Connect(function(input)
            if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
            VSDragging = true

            local old = uis.MouseIconEnabled
            uis.MouseIconEnabled = false
            tweenOnce(cp.Contents.Contents.Display.ColorZone.PickerZone.Contents.Cursor, TIn(0.35 / handleAnimationSpeed(options.AnimationSpeed)), { Size = U2o(7, 7), BackgroundTransparency = 0 })

            while VSDragging and con2 do
                HSV.S = clamp((mouse.X - cp.Contents.Contents.Display.ColorZone.PickerZone.AbsolutePosition.X) / cp.Contents.Contents.Display.ColorZone.PickerZone.AbsoluteSize.X, 0, 1)
                HSV.V = 1 - clamp((mouse.Y - cp.Contents.Contents.Display.ColorZone.PickerZone.AbsolutePosition.Y) / cp.Contents.Contents.Display.ColorZone.PickerZone.AbsoluteSize.Y, 0, 1)
                self.Tooltip = "Hue: " .. floor(HSV.H * 360) .. "°; Saturation: " .. floor(HSV.S * 100) .. "%; Value: " .. floor(HSV.V * 100) .. "%"
                tooltipObject.CustomMousePosition = cp.Contents.Contents.Display.ColorZone.PickerZone.Contents.Cursor.AbsolutePosition - (cp.Contents.Contents.Display.ColorZone.PickerZone.Contents.Cursor.AbsoluteSize / 2)

                updateColor()
            end

            tooltipObject.CustomMousePosition = mouse
            uis.MouseIconEnabled = old
            tweenOnce(cp.Contents.Contents.Display.ColorZone.PickerZone.Contents.Cursor, TIn(0.5 / handleAnimationSpeed(options.AnimationSpeed)), { Size = U2o(5, 5), BackgroundTransparency = 0.25 })

            wait(render())
            self.Tooltip = ""
        end)

        cons[#cons + 1] = con1
        cons[#cons + 1] = con2

        cons[#cons + 1] = cp.Contents.Contents.Display.ColorZone.PickerZone.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
                VSDragging = false 
            end
        end)

        local function setupTextBox(textBox, component)
            textBox.FocusLost:Connect(function(enterPressed)
                local text = textBox.Text
                if tonumber(text) then
                    local value = tonumber(text) / 255
                    if component == "R" then
                        local newH, newS, newV = fHSV(HSV.H, HSV.S, HSV.V):ToHSV()
                        local newColor = fHSV(newH, newS, newV)
                        HSV.H, HSV.S, HSV.V = C3n(value, newColor.G, newColor.B):ToHSV()
                    elseif component == "G" then
                        local newH, newS, newV = fHSV(HSV.H, HSV.S, HSV.V):ToHSV()
                        local newColor = fHSV(newH, newS, newV)
                        HSV.H, HSV.S, HSV.V = C3n(newColor.R, value, newColor.B):ToHSV()
                    elseif component == "B" then
                        local newH, newS, newV = fHSV(HSV.H, HSV.S, HSV.V):ToHSV()
                        local newColor = fHSV(newH, newS, newV)
                        HSV.H, HSV.S, HSV.V = C3n(newColor.R, newColor.G, value):ToHSV()
                    end
                end

                updateColor()
            end)
        end

        setupTextBox(cp.Contents.Contents.Display.BottomZone.TextBoxes.R.TextBox, "R")
        setupTextBox(cp.Contents.Contents.Display.BottomZone.TextBoxes.G.TextBox, "G")
        setupTextBox(cp.Contents.Contents.Display.BottomZone.TextBoxes.B.TextBox, "B")

        local result = nil
        local completed = false

        cons[#cons + 1] = cp.Contents.Contents.Display.BottomZone.TextButton.MouseButton1Click:Connect(function()
            result = fHSV(HSV.H, HSV.S, HSV.V)
            completed = true
        end)

        cons[#cons + 1] = cp.Contents.Contents.TopbarZone.Right.Close.MouseButton1Click:Connect(function()
            result = nil
            completed = true
        end)

        updateColor()

        repeat render() until completed

        for i, v in cons do
            if v.Connected then
                v:Disconnect()
            end
        end

        spawn(softCallback, opts.Callback, result)
        spawn(function()
            tweenOnce(cp, TIn(0.5 / handleAnimationSpeed(options.AnimationSpeed), Enum.EasingStyle.Quint, Enum.EasingDirection.In), { Size = U2o(0, 0) })
            wait(0.5 / handleAnimationSpeed(options.AnimationSpeed))

            cp:Destroy()
        end)

        spawn(playSound, "Click", self)
        return result
    end,
    PlaySound = function(self, name)
        spawn(playSound, name, self)
    end,
    Notify = function(self, ...)
        return self:Notification(...)
    end,
    Notification = function(self, options)
        options = setmetatable(options or { }, defaultNotificationOptions)

        if options.HasButtons then
            if options.Duration >= 1000 or options.Duration <= 0 then
                options.Duration = inf
            end
        else
            if options.Duration >= 1000 or options.Duration <= 0 then
                options.Duration = 120
            end

            options.Duration = clamp(options.Duration, 2, 120)
        end

        local opts = self.Options

        if options.Side == "-" then
            options.Side = opts.NotificationSide or "Left"
        end

        if options.UseOgScaling == "-" then
            options.UseOgScaling = opts.NotificationOgScaling or false
        end

        local s = options.Side
        if s == "-" then
            s = "Left"
        end

        gui.Notifications.NotificationsRight.Position = U2n(1, 0, 0, tbMeasurer.AbsoluteSize.Y + 2)

        local scaling = options.UseOgScaling
        local text = options.Text
        local side = gui.Notifications["Notifications" .. s]

        local tpos = U2n(s == "Left" and -1 or 1, s == "Right" and 1 or -1, 0, 0)
        local tpos2 = U2n(s == "Left" and -1 or 2, 0, 0, 3)

        if s == "Right" then
            ridx -= 1
        end

        local notif = getPlaceholder("Notification")
        local scale = U2n(1, 0, 0, scaling and (device == "Mobile" and 80 or 110) or max(getTextSize(text, 14, notif.Background.Holder.Text.Font, V2n(side.AbsoluteSize.X - 15, 99999)).Y, 14) + 33)

        safeReparent(notif, side)
        orderUpdate(notif, s == "Right" and ridx or 0)

        notif.Size = scale
        notif.Background.Position = tpos
        notif.Background.Holder.Position = tpos2
        notif.Background.Holder.AnchorPoint = V2n(s == "Left" and 0 or 1, 0)
        notif.Background.Holder.Title.Text = options.Title
        notif.Background.Holder.Text.Text = text
        notif.Background.Progress.Fill.Size = U2s(1, 1)
        notif.Background.Progress.Fill.AnchorPoint = V2n(s == "Left" and 0 or 1, 0)
        notif.Background.Progress.Fill.Position = U2s(s == "Left" and 0 or 1, 0)
        notif.Background.Holder.Buttons.Visible = options.HasButtons
        notif.Background.Holder.Halfer.Position = U2s(s == "Left" and 0 or 0.5, 0)
        notif.Background.OutsideStroke.Enabled = not opts.NoStrokes
        notif.Background.UICorner.CornerRadius = cornerState[opts.RoundEverything]
        notif.Background.Holder.UICorner.CornerRadius = cornerState[opts.RoundEverything]
        notif.Background.Progress.CanvasGroup.Half2.UICorner.CornerRadius = cornerState[opts.RoundEverything]
        safeReparent(notif.Background.Progress.CanvasGroup.Half2.UICorner, notif.Background.Progress.CanvasGroup["Half" .. (s == "Left" and "2" or "1")])
        notif.Background.Progress.CanvasGroup.Half2.Position = U2s(s == "Left" and 0 or 0.5, 0)
        notif.Background.Progress.CanvasGroup.Half2.Size = U2s(s == "Left" and 1 or 0.5, 1)
        notif.Background.Progress.CanvasGroup.Half1.Size = U2s(s == "Left" and 0.5 or 1, 1)
        notif.Visible = true

        notif.Background.Holder.BackgroundColor3 = self.Theme.Back
        notif.Background.BackgroundColor3 = self.Theme.Back
        notif.Background.Progress.CanvasGroup.GroupColor3 = self.Theme.Main
        notif.Background.Progress.Fill.BackgroundColor3 = self.Theme.Main
        notif.Background.Holder.Frame.BackgroundColor3 = self.Theme.Text
        notif.Background.Holder.Buttons.BackgroundColor3 = self.Theme.Back
        notif.Background.Holder.Title.TextColor3 = self.Theme.Text
        notif.Background.Holder.Text.TextColor3 = self.Theme.Text
        notif.Background.Holder.Buttons.Yes.ImageColor3 = self.Theme.Text
        notif.Background.Holder.Buttons.No.ImageColor3 = self.Theme.Text
        notif.Background.Holder.Halfer.BackgroundColor3 = self.Theme.Back

        local old = notif.Size
        notif.Size = U2s(1, 0)

        local function main()
            spawn(playSound, "Notification", self)
            local pick = false
            local done = false

            if options.Duration ~= inf then
                spawn(function()
                    render()

                    tweenOnce(notif.Background.Progress.Fill, TIn(options.Duration, Enum.EasingStyle.Linear), { Size = U2s(0, 1) })
                    wait(options.Duration)
                    done = true
                end)
            end

            local con1 = notif.Background.Holder.Buttons.Yes.MouseButton1Click:Connect(function()
                pick = true
                done = true
            end)

            local con2 = notif.Background.Holder.Buttons.No.MouseButton1Click:Connect(function()
                pick = false
                done = true
            end)

            spawn(function()
                tweenOnce(notif, TIn(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { Size = old })

                wait(0.2)
                if done then return end

                tweenOnce(notif.Background, TIn(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { Position = U2o(s == "Right" and 1 or 0, 0) })
                tweenOnce(notif.Background.Holder, TIn(.67 * 1.67 --[[AAAA, 67]], Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { Position = U2n(s == "Left" and 0 or 1, 0, 0, 3) })
            end)

            repeat render() until done

            con1:Disconnect()
            con2:Disconnect()

            spawn(function()
                tweenOnce(notif.Background.Holder, TIn(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), { Position = tpos2 })
                wait(0.2)

                tweenOnce(notif.Background, TIn(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), { Position = tpos })
                wait(0.5)

                tweenOnce(notif, TIn(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { Size = U2s(1, 0) })
                wait(0.2)

                notif:Destroy()
            end)

            spawn(softCallback, options.Callback, options.HasButtons and pick or nil)
            return pick
        end

        if options.HasButtons then
            return main()
        else
            spawn(main)
        end
    end,
    DefaultOptions = {
        RecolorIcon = false,
        Icon = "",
        Image = "",
        ImageColor = C3n(1, 1, 1),
        Title = config.Name,
        Text = "",
        Footer = "",
        NotificationSide = "Right",
        ExtraInfoLabelText = "",
        InfoLabelExtra = "",
        ExtraInfoLabelTextEnabled = true,
        NotificationOgScaling = false,
        Closed = false,
        Visible = true,
        BlurBackground = false,
        DisableBlurBackground = false,
        OutsideStroke = true,
        CornerRadius = 0,
        _PrevVisible = false,
        _OldVisible = false,
        MobileButtonVisible = false,
        MobileButtonAlwaysVisible = false,
        AnimationSpeed = 1,
        NeonThickness = 1,
        BackgroundTransparency = 0,
        ImageTransparency = 0.85,
        ImageEnabled = true,
        ShadowTransparency = 0.5,
        Size = device == "Mobile" and U2n(1, 100, 0.5, 75) or U2n(0.7, 250, 0.375, 150), -- better dont change it, I forgot to implement it correctly, now I'm just lazy to fix it
        ShadowSize = 27,
        OnClose = function() end,
        Tooltip = "",
        NeonType = "Stroke", -- None, Stroke, Top
        Translations = tfreeze({ }),
        Language = "EN",
        _PrevLang = "EN",
        UnlockMouse = false,
        FullBlurSize = false,
        Keybind = Enum.KeyCode.LeftAlt,
        Debounce = false,
        _first = false,
        UserProfile = false,
        SubscriptionExpiry = false,
        NoStrokes = false,
        RoundEverything = false,
        EnableUIBlur = true,
        BlurProfile = false,
        ModernToggles = false,
        LargeModernToggles = false,
        _LargeString = "",
        MobileButtonNeon = true,
        _Ready = false,
        InfoLabelExtraAntiRich = true,
        ThemeString = "",

        NotificationSound = sounds.Notification.SoundId,
        ClickSound = sounds.Click.SoundId,
        HoverSound = sounds.Hover.SoundId,
        Volume = 100, -- being divided by 200

        Theme = tfreeze({
            Back = C3R(20, 20, 20),
            Main = C3R(255, 0, 127),
            Stroke = C3R(0, 0, 0),
            Text = C3R(255, 255, 255)
        })
    },
    WindowNotification = function(self, ...)
        local object = newObject(iwnFunctions, self, ...)
        local options = object.Options
        
        local returned = options._returned
        if returned ~= nil then
            print("RETURN OMFG")
            if options.HasButtons then
                return returned
            end
            
            return
        end
        
        self._WindowNotificationAdded:Fire(object)
        if options.HasButtons then
            while options._returned == nil do
                event.Clock:Wait()
            end

            return options._returned
        end
    end,
    InWindowNotification = function(self, ...)
        return self:WindowNotification(...)
    end,
    Init = function(self, options)
        local window = getPlaceholder("Window")
        local mobileButton = getPlaceholder("MobileButton")
        local sounds = getPlaceholder("Sounds")
        safeReparent(sounds, window)

        local destroying = event.new()
        
        local cursorEffects = {
            Stroke = { cursorLib:Outline() }
        }
        
        local effectsSum = { }
        for _, v in cursorEffects do
            for _, val in v do
                effectsSum[#effectsSum + 1] = val
            end
        end
        
        local cursor = cursorLib.new(effectsSum)
        cursorEffects.Main = { cursor }
        
        local cons = { }
        
        local wna = event.new()
        local wnr = event.new()
        
        local wns = { }
        local blurs = { }
        
        local object = addFunctions({
            Options = options,
            Window = window,
            MobileButton = mobileButton,
            Objects = { },
            AllObjects = { },
            ObjectAdded = event.new(),
            OnRefresh = event.new(),
            Defaults = { },
            Counters = { },
            PossibleLanguages = { "EN" },
            _Connections = cons,
            _Blurs = blurs,
            CurrentTab = false,
            Languages = langs,
            ChildAdded = event.new(),
            LanguageAdded = event.new(),
            ThemeChanged = event.new(),
            Cursor = cursor,
            Destroying = destroying,
            OnClose = destroying,
            BlurFrame = window.Blur,
            Icons = allIcons,
            Background = allBackgrounds,
            Emulator = emulator,
            IsMobile = device == "Mobile",
            IsDesktop = device == "PC",
            Platform = platform,
            RealPlatform = realPlatform,
            Device = device,
            Executor = executor,
            ExecutorVersion = version,
            Version = config.Version,
            Name = config.Name,
            Author = config.Author,
            Config = config,
            Class = self.Class,
            Translate = translators,
            Translators = translators,

            _WindowNotificationAdded = wna,
            _WindowNotificationRemoving = wnr
        }, self)
        
        cons[#cons + 1] = wna:Connect(function(inWindowNotification)
            wns[#wns + 1] = inWindowNotification
            handleWNS(wns, object.Proxy or object, inWindowNotification, false)
            
            inWindowNotification._con = destroying:Once(function()
                inWindowNotification._returned = false
                inWindowNotification.Destroying:Fire()
            end)
        end)
        
        cons[#cons + 1] = wnr:Connect(function(inWindowNotification)
            inWindowNotification._con:Disconnect()
            tremove(wns, tfind(wns, inWindowNotification))
            handleWNS(wns, object.Proxy or object, inWindowNotification, true)

            inWindowNotification._con:Disconnect()
        end)

        uiBackBlur:Bind(window.Blur)
        object.Options.Theme = tclone(object.Options.Theme)
        object.Options._PrevTheme = tclone(object.Options.Theme)

        defer(addPossibleTranslations, object)
        cons[#cons + 1] = object.ChildAdded:Connect(function(newObject)
            if newObject and newObject.Options then
                if typeof(object.Options.Translations) == "table" and object.Options.Translations[newObject.Flag] then
                    newObject.Options.Translations = object.Options.Translations[newObject.Flag]
                    defer(addPossibleTranslations, newObject)
                end
            else
                warn("Invalid object", newObject)
            end
        end)

        object._PrevLang = options.Language
        
        cons[#cons + 1] = window.RealWindow.Contents.NotificationsOverlay.Changed:Connect(function()
            local v = window.RealWindow.Contents.NotificationsOverlay.BackgroundTransparency < 0.98
            window.RealWindow.Contents.NotificationsOverlay.Visible = v
            
            if not blurs.Display or not blurs.Display[1] then return end
            
            blurs.Display[1].IWN = v
            blurs.BackgroundImage[1].IWN = v
            blurs.Topbar[1].IWN = v
            blurs.KeySystem[1].IWN = v
            blurs.SettingsOverlay[1].IWN = v
            
            refreshBlurs(blurs, options.EnableUIBlur)
        end)
        
        window.RealWindow.Contents.NotificationsOverlay.BackgroundTransparency = 1

        local titleZone = window.RealWindow.Contents.TopbarZone.TitleZone
        local cd = true

        cons[#cons + 1] = titleZone.Title.Changed:Connect(function()
            if not cd then return end

            cd = false
            titleZone.Title.Size = U2n(0, titleZone.Title.TextBounds.X, 1, 0)
            render()
            titleZone.Title.Size = U2n(0, titleZone.Title.TextBounds.X, 1, 0)
            cd = true
        end)

        cons[#cons + 1] = titleZone.Icon.Changed:Connect(function()
            titleZone.Icon.Visible = setIcon(options.Icon, icons, object.Proxy, titleZone.Icon) ~= ""
        end)

        local footer = window.RealWindow.Contents.Footer.Label
        cons[#cons + 1] = footer:GetPropertyChangedSignal("Text"):Connect(function()
            if not object.Options.Visible then return end

            local isVisible = clean(footer.Text) ~= ""

            footer.Parent.Visible = isVisible
            window.RealWindow.Contents.DisplayBlur.Downsampler.Display.Size = U2n(1, 0, 1, isVisible and -15 or 0)
        end)
        
        cons[#cons + 1] = window.MouseEnter:Connect(function()
            if options.Visible then
                cursorLib:SetActive(cursor)
            end
        end)

        makeDraggable(window, object, cons)
        makeDraggable(window.RealWindow.Contents.NotificationsOverlay, object, cons, window)
        makeDraggable(window.RealWindow.Contents.KeySystemOverlay, object, cons, window)
        makeDraggable(mobileButton, object, cons)

        local start = 0
        cons[#cons + 1] = mobileButton.MouseButton1Down:Connect(function()
            start = tick()
        end)

        cons[#cons + 1] = mobileButton.MouseButton1Click:Connect(function()
            if tick() - start > 0.35 then return end
            object:Toggle()
        end)

        local startPos, startPosition, startSize, moveConnection, upConnection

        local oldDeltaX, oldDeltaY = 0, 0
        local function move()
            if not moveConnection or not upConnection then return end

            local delta = V2n(mouse.X, mouse.Y) - startPos
            local xOffset, yOffset = max(0, startSize.X.Offset + delta.X), max(0, startSize.Y.Offset + delta.Y)

            window:TweenSizeAndPosition(U2n(startSize.X.Scale, xOffset, startSize.Y.Scale, yOffset), U2n(startPosition.X.Scale, startPosition.X.Offset + (xOffset > 0 and delta.X / 2 or oldDeltaX), startPosition.Y.Scale, startPosition.Y.Offset + (yOffset > 0 and delta.Y / 2 or oldDeltaY)), nil, nil, 0.35 / handleAnimationSpeed(object.Options.AnimationSpeed), true)

            oldDeltaX, oldDeltaY = xOffset > 0 and delta.X / 2 or oldDeltaX, yOffset > 0 and delta.Y / 2 or oldDeltaY
        end

        cons[#cons + 1] = window.RealWindow.Corner.Resize.MouseButton1Down:Connect(function()
            startPos = V2n(mouse.X, mouse.Y)
            startSize = window.Size
            startPosition = window.Position

            oldDeltaX, oldDeltaY = 0, 0

            if moveConnection then
                moveConnection:Disconnect()
                moveConnection = nil
            end

            if upConnection then
                upConnection:Disconnect()
                upConnection = nil
            end

            moveConnection = mouse.Move:Connect(function()
                defer(move) -- wait for full mouse update
            end)

            upConnection = uis.InputEnded:Connect(function(input)
                if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end

                moveConnection:Disconnect()
                upConnection:Disconnect()

                moveConnection, upConnection = nil, nil
            end)
        end)

        local dontRefresh = false
        cons[#cons + 1] = object.ThemeChanged:Connect(function(theme)
            if dontRefresh then return end
            
            for cat, objs in cursorEffects do
                local col = theme[cat]
                for _, obj in objs do
                    obj.Color = col
                end
            end

            dontRefresh = true
            object.Proxy:RefreshAll()
            dontRefresh = false
        end)

        local shOpen = false
        local msf = window.RealWindow.Contents.Display.PageButtons.List.MobileSizeFix
        local cnt = 0

        cons[#cons + 1] = rs.RenderStepped:Connect(function()
            cnt = (cnt + 1) % 5

            if cnt == 0 then
                msf.Size = U2n(mrandom(), 0, 0, 1)
            end

            for i, v in object.Options._PrevTheme do
                if object.Options.Theme[i] ~= v then
                    object.Options._PrevTheme = tclone(object.Options.Theme)
                    object.ThemeChanged:Fire(object.Options.Theme)
                    break
                end
            end

            if not object.Options.UnlockMouse and not shOpen or not object.Options.Visible then return end
            unlockMouse()
        end)

        local tui = window.RealWindow.Contents.TopbarZone.Right.ToggleUI
        cons[#cons + 1] = tui.MouseEnter:Connect(function()
            tweenOnce(tui.ImageLabel, TIn(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed)), { ImageTransparency = 0 })
        end)

        cons[#cons + 1] = tui.MouseLeave:Connect(function()
            tweenOnce(tui.ImageLabel, TIn(0.6 / handleAnimationSpeed(object.Options.AnimationSpeed)), { ImageTransparency = 0.25 })
        end)

        cons[#cons + 1] = tui.MouseButton1Click:Connect(function()
            object:Toggle()
        end)

        local clb = window.RealWindow.Contents.TopbarZone.Right.Close
        cons[#cons + 1] = clb.MouseEnter:Connect(function()
            tweenOnce(clb.ImageLabel, TIn(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed)), { ImageTransparency = 0 })
        end)

        cons[#cons + 1] = clb.MouseLeave:Connect(function()
            tweenOnce(clb.ImageLabel, TIn(0.6 / handleAnimationSpeed(object.Options.AnimationSpeed)), { ImageTransparency = 0.25 })
        end)

        cons[#cons + 1] = clb.MouseButton1Click:Connect(function()
            object:TryClose()
        end)

        local dsc = window.RealWindow.Contents.TopbarZone.Right.Close
        cons[#cons + 1] = dsc.MouseEnter:Connect(function()
            tweenOnce(dsc.ImageLabel, TIn(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed)), { ImageTransparency = 0 })
        end)

        cons[#cons + 1] = dsc.MouseLeave:Connect(function()
            tweenOnce(dsc.ImageLabel, TIn(0.6 / handleAnimationSpeed(object.Options.AnimationSpeed)), { ImageTransparency = 0.25 })
        end)

        cons[#cons + 1] = dsc.MouseButton1Click:Connect(function()
            local options = object.Proxy.Options
            if toclip and options.Discord then
                toclip(options.Discord)
            end
        end)

        local s = window.RealWindow.Contents.TopbarZone.Right.Settings
        local so = window.RealWindow.Contents.SettingsOverlay
        local soshi = so.SettingsHub.Image
        
        so.Visible = false
        so.SettingsHub.AnchorPoint = V2n(0, 0)
        so.BackgroundTransparency = 1
        soshi.Position = U2s(0, 0)

        window.Visible = false
        window.Size = U2s(0, 0)
        window.RealWindow.ClipsDescendants = true
        window.RealWindow.Overlay.Visible = true
        window.Shadow.Size = U2s(0, 0)
        window.Shadow.ImageTransparency = 1
        window.RealWindow.Overlay.BackgroundTransparency = 0
        options._LargeString = tostring(options.NoStrokes) .. tostring(options.ModernToggles) .. tostring(options.RoundEverything) .. tostring(options.LargeModernToggles)

        cons[#cons + 1] = s.MouseEnter:Connect(function()
            tweenOnce(s.ImageLabel, TIn(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed)), { ImageTransparency = 0 })
        end)

        cons[#cons + 1] = s.MouseLeave:Connect(function()
            if not shOpen then
                tweenOnce(s.ImageLabel, TIn(0.6 / handleAnimationSpeed(object.Options.AnimationSpeed)), { ImageTransparency = 0.25 })
            end
        end)

        cons[#cons + 1] = s.MouseButton1Click:Connect(function()
            shOpen = not shOpen
            
            if blurs.Display and blurs.Display[1] then
                blurs.Display[1].SH = shOpen
                blurs.BackgroundImage[1].SH = shOpen
                blurs.SettingsBackgroundImage[1].SH = shOpen
            
                refreshBlurs(blurs, options.EnableUIBlur)
            end
            
            if shOpen then
                so.Visible = true

                tweenOnce(so, TIn(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed)), { BackgroundTransparency = 0.5 })
                tweenOnce(so.SettingsHub, TIn(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed)), { AnchorPoint = V2n(0, 1) })
                tweenOnce(soshi, TIn(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed)), { Position = U2s(0, 1) })
            else
                tweenOnce(so, TIn(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed)), { BackgroundTransparency = 1 })
                tweenOnce(so.SettingsHub, TIn(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed)), { AnchorPoint = V2n(0, 0) })
                tweenOnce(soshi, TIn(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed)), { Position = U2s(0, 0) })

                wait(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed))
                if shOpen then return end

                so.Visible = false
            end
        end)

        cons[#cons + 1] = so.MouseButton1Click:Connect(function()
            shOpen = false

            if blurs.Display and blurs.Display[1] then
                blurs.Display[1].SH = shOpen
                blurs.BackgroundImage[1].SH = shOpen
                blurs.SettingsBackgroundImage[1].SH = shOpen
                
                refreshBlurs(blurs, options.EnableUIBlur)
            end

            tweenOnce(so, TIn(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed)), { BackgroundTransparency = 1 })
            tweenOnce(so.SettingsHub, TIn(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed)), { AnchorPoint = V2n(0, 0) })
            tweenOnce(soshi, TIn(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed)), { Position = U2s(0, 0) })
            tweenOnce(s.ImageLabel, TIn(0.6 / handleAnimationSpeed(object.Options.AnimationSpeed)), { ImageTransparency = 0.25 })

            wait(0.4 / handleAnimationSpeed(object.Options.AnimationSpeed))
            if shOpen then return end

            so.Visible = false
        end)

        defer(windowSetup, object)

        local origOptions = options
        local options = { Position = U2o(20, 65), AnchorPoint = V2n(0, 0),
            Visible = false,
            ShowFPS = true,
            ShowExecutor = true,
            ShowTime = true,
            ShowPing = true,
            ShowPlayers = true,
            ShowGaps = true
        }

        local label = object:FloatingLabel("Info" .. id(), options)
        local myCons = { }

        label.Destroying:Once(function()
            object.Options.InfoLabel = nil
            for i, v in myCons do
                v:Disconnect()
            end
        end)

        local buffer = { }
        local cnt = 0
        
        myCons[#myCons + 1] = rs.RenderStepped:Connect(function(dt)
            local fps = 1 / dt
            if fps > 100000 then
                fps = 0
            end

            local ffps = max(round(fps), 1)
            while #buffer >= ffps do
                tremove(buffer, 1)
            end

            tinsert(buffer, fps)

            cnt = (cnt + 1) % 5
            if not label.Visible or cnt ~= 0 then return end

            local lines = { }
            local inserted = false
            if options.ShowExecutor then
                inserted = true
                tinsert(lines, executor .. " | " .. version)
            end

            if inserted and options.ShowGaps then
                tinsert(lines, "")
            end

            local inserted2 = false
            local inserts = 0
            
            if options.ShowFPS then
                inserted2 = true
                inserts = 1

                local estFps = 0
                for i, v in buffer do
                    estFps += v
                end

                estFps = clamp(round((estFps / #buffer) * 10) / 10, 0, 2e9)

                local estFpsS = tostring(estFps)
                if not estFpsS:find("%.") then
                    estFpsS ..= ".0"
                end

                tinsert(lines, "FPS: " .. paintRichText(estFpsS, estFps <= 120 and C3n(1):Lerp(C3n(0, 1, 1), estFps / 120) or C3n(0, 1, 1):Lerp(C3n(0.7, 0.3, 1), clamp((estFps - 120) / 120, 0, 2))))
            end

            if options.ShowPing then
                inserts = 1
                
                local pingS = round(ping * 1000)
                pingS = "Ping: " .. (pingS >= 0 and paintRichText(tostring(pingS) .. " ms", C3n(0, 1):Lerp(C3n(1), clamp(pingS / 1000, 0, 1))) or paintRichText("Disconnected", C3n(1)))

                if not inserted2 then
                    inserted2 = true
                    tinsert(lines, pingS)
                else
                    lines[#lines] ..= " | " .. pingS
                end
            end
            
            --[[if options.ShowCPUSpeed then
                inserts += 1
                tinsert(lines, "CPU: " .. paintRichText((round(CPUSpeed * 100) / 100) .. " " .. CPUPrefix, C3n(1):Lerp(C3n(0, 1), clamp(RealCPUSpeed / 3.25, 0, 1))))
            end]]
            
            if inserts == 2 and options.ShowGaps and (options.ShowPlayers or options.ShowTime) then
                tinsert(lines, "")
            end

            if options.ShowPlayers then
                inserted2 = true
                tinsert(lines, "Players: " .. (#plrs:GetPlayers()) .. " / " .. plrs.MaxPlayers)
            end

            if options.ShowTime then
                inserted2 = true
                tinsert(lines, os.date("%H:%M:%S"))
            end

            if inserted and not inserted2 and options.ShowGaps then
                lines[#lines] = nil
            end

            local lines = concat(lines, "\n")
            if #origOptions.ExtraInfoLabelText ~= 0 and origOptions.ExtraInfoLabelTextEnabled then
                lines ..= (lines ~= "" and "\n" or "") .. typeof(origOptions.ExtraInfoLabelText) == "table" and table.concat(origOptions.ExtraInfoLabelText, "\n") or options.ExtraInfoLabelText
            end

            if origOptions.InfoLabelExtra ~= "" then
                lines ..= (lines ~= "" and "\n" or "") .. (origOptions.InfoLabelExtraAntiRich and antiRich(origOptions.InfoLabelExtra) or origOptions.InfoLabelExtra)
            end

            label.Text = lines
        end)

        object.Options.InfoLabel = label
        for i, v in myCons do
            cons[#cons + 1] = v
        end
        
        local pb = window.RealWindow.Contents.Display.PageButtons
        local rz = pb.Resizer
        local pgs = pb.Parent.Pages
        
        makeDraggable(rz, object, cons, nil, true, true)
        
        local size = 145
        local minSize = 100
        local maxSize = 200
        
        local oldPos = rz.Position
        
        local ignore = false
        cons[#cons + 1] = rz:GetPropertyChangedSignal("Position"):Connect(function()
            if ignore then
                ignore = false
                return
            end
            
            size = clamp(size + rz.Position.X.Offset, minSize, maxSize)
            
            ignore = true
            rz.Position = oldPos
            
            pb.Size = U2n(0, size, 1, -40)
            pgs.Size = U2n(1, -size, 1, -40)
        end)

        spawn(function()
            gui.Enabled = false
            render()
            gui.Enabled = true

            while wait(0.05) and not object.Closed do
                object:RefreshUserProfile()
            end
        end)
        
        local ksb = window.RealWindow.Contents.KeySystemOverlay.Canvas.Holder.Upscaler.Contents.Button
        local kst = ksb.Parent.Bar.Bar.Icon.TextBox
        
        local function resetKSB()
            local options = object.Proxy.Options
            options._ksb = false
            options._kss = options._ksd and 7 or #kst.Text == 0 and 1 or 4
            object:Refresh()
        end
        
        cons[#cons + 1] = ksb.Parent.Bar.MouseButton1Click:Connect(function()
            kst:CaptureFocus()
        end)
        
        cons[#cons + 1] = ksb.MouseButton1Down:Connect(function()
            castCircle(ksb, object.Proxy)
        end)
        
        cons[#cons + 1] = kst.Changed:Connect(function()
            local options = object.Proxy.Options
            if not options._ksa or options._ksb then return end
            resetKSB()
        end)
        
        cons[#cons + 1] = ksb.MouseButton1Click:Connect(function()
            local options = object.Proxy.Options
            if not options._ksa or options._ksb then return end
            
            options._ksb = true
            local doDelay = true
            
            if #kst.Text == 0 then
                kst.Text = options._ksa
                
                if toclip then
                    spawn(pcall, toclip, options._ksa)
                    options._kss = 2
                else
                    options._kss = 3
                end
                
                object:Refresh()
            else
                options._kss = 5
                object:Refresh()
                
                local s, r = pcall(options.KeyCallback, kst.Text, object.Proxy)
                if not s or not r then
                    options._kss = 6
                    object:Refresh()
                else
                    doDelay = false
                    options._kss = 7
                    object:Refresh()
                    
                    wait(0.75)
                    
                    blurs.KeySystem[1].KS = true
                    object:Refresh()
                    refreshBlurs(blurs, options.EnableUIBlur)
                    
                    wait(0.25)
                    
                    options._ksa = false
                    options._ksd = true
                end
            end

            object:Refresh()
            if doDelay then
                wait(2.5)
                resetKSB()
            end
        end)

        window.RealWindow.Contents.KeySystemOverlay.Canvas.GroupTransparency = 1
        window.RealWindow.Contents.KeySystemOverlay.Visible = false
        window.RealWindow.Contents.KeySystemOverlay.Canvas.Holder.Upscaler.Size = U2n(1, 25, 1, 12)
        window.RealWindow.Contents.KeySystemOverlay.Canvas.Holder.Upscaler.GroupTransparency = 1

        blurs.Profile = { { }, uiBlur.new(pb.UserProfile.User.Profile, { pb.UserProfile.User.Profile.TextLabel }, "ProfileBlur"), 0.1, 5 }
        blurs.BackgroundImage = { { }, uiBlur.new(window.RealWindow.Contents, { window.RealWindow.Contents.BackgroundImage }, "BackgroundImageBlur"), 0.5 }
        blurs.SettingsBackgroundImage = { { }, uiBlur.new(window.RealWindow.Contents.SettingsOverlay.SettingsHub, { window.RealWindow.Contents.SettingsOverlay.SettingsHub.Image }, "ImageBlur"), 0.5 }
        blurs.SettingsOverlay = { { }, uiBlur.new(window.RealWindow.Contents, { window.RealWindow.Contents.SettingsOverlay }, "SettingsBlur"), 0.225 }
        blurs.Topbar = { { }, uiBlur.new(window.RealWindow.Contents, { window.RealWindow.Contents.TopbarZone }, "TopbarBlur"), 0.225 }
        blurs.Display = { { }, uiBlur.new(window.RealWindow.Contents, { window.RealWindow.Contents.Display, window.RealWindow.Contents.Footer }, "DisplayBlur"), 0.3, 2 }
        blurs.KeySystem = { { KS = true }, uiBlur.new(window.RealWindow.Contents, { window.RealWindow.Contents.KeySystemOverlay }, "KeySystemBlur"), 1.5, 3 }
        blurs.KeySystemImage = { { _ = true }, uiBlur.new(window.RealWindow.Contents.KeySystemBlur.Downsampler.KeySystemOverlay.Canvas, { window.RealWindow.Contents.KeySystemBlur.Downsampler.KeySystemOverlay.Canvas.BackgroundImage }, "ImageBlur"), 0.5 }
        
        refreshBlurs(blurs, options.EnableUIBlur)
        
        window:Clone().Parent = workspace
        
        return object
    end,
    KeySystem = function(self, options)
        if typeof(options) ~= "table" then error("No table was passed", 0) end
        if typeof(options.Callback) ~= "function" then error("Missing .Callback = function", 0) end
        if typeof(options.KeyUrl) ~= "string" then error("Missing .KeyUrl = string", 0) end
        
        local woptions = self.Options
        if woptions._ksa then return false end
        
        woptions._ksa = options.KeyUrl
        woptions._kss = 1
        woptions._ksb = false
        woptions._ksd = false
        
        woptions.KeyCallback = options.Callback
        woptions.KeyBackground = options.Background or options.BackgroundImage
        
        self:Refresh()
        refreshBlurs(self._Blurs, woptions.EnableUIBlur)
        
        self.Window.RealWindow.Contents.KeySystemBlur.Downsampler.KeySystemOverlay.Visible = true
        
        tweenOnce(self.Window.RealWindow.Contents.KeySystemBlur.Downsampler.KeySystemOverlay.Canvas.Holder.Upscaler, TIn(0.01), { GroupTransparency = 1 })
        tweenOnce(self.Window.RealWindow.Contents.KeySystemBlur.Downsampler.KeySystemOverlay.Canvas, TIn(0.75 / handleAnimationSpeed(woptions.AnimationSpeed)), { GroupTransparency = 0 })
        
        while not woptions.Visible or self.Window.RealWindow.Overlay.BackgroundTransparency < 0.99 do wait() end

        self._Blurs.KeySystem[1].KS = false
        self:Refresh()
        refreshBlurs(self._Blurs, woptions.EnableUIBlur)
        
        local as = 0.75 / handleAnimationSpeed(woptions.AnimationSpeed)
        self.Window.RealWindow.Contents.KeySystemBlur.Downsampler.KeySystemOverlay.Canvas.Holder.Upscaler:TweenSize(U2s(1, 1), nil, nil, as, true)
        tweenOnce(self.Window.RealWindow.Contents.KeySystemBlur.Downsampler.KeySystemOverlay.Canvas.Holder.Upscaler, TIn(as / 3), { GroupTransparency = 0 })
        
        repeat wait() until not woptions._ksa or woptions.Closed
        
        woptions.KeyCallback = nil
        woptions.KeyBackground = nil
        
        woptions._ksa = nil
        woptions._kss = 1
        woptions._ksb = nil
        woptions._ksd = true
        
        as = 0.75 / handleAnimationSpeed(woptions.AnimationSpeed)
        self.Window.RealWindow.Contents.KeySystemBlur.Downsampler.KeySystemOverlay.Canvas.Holder.Upscaler:TweenSize(U2n(1, 25, 1, 12), nil, nil, as, true)
        tweenOnce(self.Window.RealWindow.Contents.KeySystemBlur.Downsampler.KeySystemOverlay.Canvas, TIn(as), { GroupTransparency = 1 })
        tweenOnce(self.Window.RealWindow.Contents.KeySystemBlur.Downsampler.KeySystemOverlay.Canvas.Holder.Upscaler, TIn(as * 2), { GroupTransparency = 1 })
        self._Blurs.KeySystem[1].KS = true
        self:Refresh()
        refreshBlurs(self._Blurs, woptions.EnableUIBlur)
        
        spawn(function()
            wait(as)
            self.Window.RealWindow.Contents.KeySystemBlur.Downsampler.KeySystemOverlay.Visible = false
        end)
            
        return not woptions.Closed
    end,
    RefreshUserProfile = function(self)
        if self.Options.Closed then return end
        
        local window = self.Window
        local options = self.Options
        local pageButtons = window.RealWindow.Contents.DisplayBlur.Downsampler.Display.PageButtons

        if not options.UserProfile then
            pageButtons.UserProfile.Visible = false
            pageButtons.List.Size = U2n(1, 0, 1, -5)

            return
        end

        pageButtons.UserProfile.Visible = true
        pageButtons.List.Size = U2n(1, 0, 1, -45)
        pageButtons.UserProfile.User.Image = userIcon

        local text = plr.Name ~= plr.DisplayName and plr.DisplayName ~= "" and (plr.DisplayName:gsub("_", " ")) or "@" .. plr.Name
        if options.SubscriptionExpiry then
            if tonumber(options.SubscriptionExpiry) then
                text ..= "\n<font size=\"10\" transparency=\"0.25\">" .. formatTime(options.SubscriptionExpiry - tick()) .. "</font>"
            else
                text ..= "\n<font size=\"10\" transparency=\"0.25\">" .. tostring(options.SubscriptionExpiry) .. "</font>"
            end
        end

        pageButtons.UserProfile.User.Profile.ProfileBlur.Downsampler.TextLabel.Text = text
    end,
    Refresh = function(self)
        local options = self.Options
        if self.Options.Closed then return end

        self.OnRefresh:Fire()

        if table.isfrozen(options.Theme) then
            options.Theme = tclone(options.Theme)
        end
        
        options.Language = options.Language:sub(1, 2):upper()
        self:RefreshUserProfile()

        local generatedString = tostring(options.NoStrokes) .. tostring(options.ModernToggles) .. tostring(options.RoundEverything) .. tostring(options.LargeModernToggles)
        if options._PrevLang ~= options.Language or options._LargeString ~= generatedString then
            options._PrevLang = options.Language
            options._LargeString = generatedString
            return self:RefreshAll()
        end

        local title = translate(self, "Text")
        if #title == 0 then
            title = translate(self, "Title")

            if #title == 0 then
                title = "Window"
            end
        end

        local window = self.Window
        local realWindow = window.RealWindow
        local realWindowContents = realWindow.Contents
        local topbarZone = realWindowContents.TopbarBlur.Downsampler.TopbarZone
        local settingsOverlay = realWindowContents.SettingsBlur.Downsampler.SettingsOverlay
        local footer = realWindowContents.DisplayBlur.Downsampler.Footer
        local display = realWindowContents.DisplayBlur.Downsampler.Display
        local pageButtons = display.PageButtons
        
        realWindow.UICorner.CornerRadius = Un(0, options.CornerRadius * 0.1)
        
        local theme = options.Theme
        local themeB, themeM, themeS, themeT = theme.Back, theme.Main, theme.Stroke, theme.Text

        realWindow.BackgroundColor3 = themeB
        realWindow.Overlay.BackgroundColor3 = themeB
        settingsOverlay.SettingsHub.BackgroundColor3 = themeB
        settingsOverlay.SettingsHub.AntiCorner.BackgroundColor3 = themeB

        realWindow.OutsideStroke.Color = themeS
        realWindow.OutsideStroke.Enabled = options.OutsideStroke
        settingsOverlay.BackgroundColor3 = themeS
        window.Shadow.ImageColor3 = themeS
        footer.Label.TextStrokeColor3 = themeS
        display.Pages.PagesDark.BackgroundColor3 = themeS

        realWindow.InsideStroke.Color = themeM
        realWindow.TopNeon.BackgroundColor3 = themeM
        realWindow.Corner.Resize.BackgroundColor3 = themeM

        settingsOverlay.SettingsHub.Separator.BackgroundColor3 = themeT
        topbarZone.TitleZone.Title.TextColor3 = themeT
        topbarZone.TitleZone.Icon.ImageColor3 = options.RecolorIcon and themeT or C3n(1, 1, 1)
        topbarZone.Right.Settings.ImageLabel.ImageColor3 = themeT
        topbarZone.Right.ToggleUI.ImageLabel.ImageColor3 = themeT
        topbarZone.Right.Discord.ImageLabel.ImageColor3 = themeT
        topbarZone.Right.Close.ImageLabel.ImageColor3 = themeT
        topbarZone.Right.Settings.Visible = not options._ksa
        topbarZone.Right.ToggleUI.Visible = not options._ksa
        topbarZone.Right.Discord.Visible = toclip and options.Discord and clean(options.Discord) ~= ""
        topbarZone.Right.Close.Visible = not not options._ksa
        footer.Label.TextColor3 = themeT
        footer.SeparatorTop.BackgroundColor3 = themeT
        pageButtons.SeparatorTop.BackgroundColor3 = themeT
        pageButtons.UserProfile.User.BackgroundColor3 = themeT
        pageButtons.SeparatorLeft.BackgroundColor3 = themeT
        pageButtons.Filler.BackgroundColor3 = themeT
        pageButtons.UserProfile.User.Profile.ProfileBlur.Downsampler.TextLabel.TextColor3 = themeT

        if options._OldVisible then
            if options.ShadowTransparency ~= options._OldShadowTransparency or options.BackgroundTransparency ~= options._OldBackgroundTransparency then
                options._OldShadowTransparency = options.ShadowTransparency
                options._OldBackgroundTransparency = options.BackgroundTransparency
                window.Shadow.ImageTransparency = 1 - ((1 - options.ShadowTransparency) * (1 - options.BackgroundTransparency))
            end
            if options.NeonType ~= options._OldNeonType or options.ShadowSize ~= options._OldShadowSize then
                options._OldNeonType = options.NeonType
                options._OldShadowSize = options.ShadowSize

                window.Shadow.Size = U2n(1, options.ShadowSize * 2, 1, options.ShadowSize * 2)
            end
        end
        
        for _, v in self._Blurs do
            v[2].Smooth = v[3] / handleAnimationSpeed(options.AnimationSpeed)
        end
        
        self._Blurs.Profile[1].Enabled = options.BlurProfile
        refreshBlurs(self._Blurs, options.EnableUIBlur)
        
        local bgImage = realWindowContents.BackgroundImageBlur.Downsampler.BackgroundImage
        setIcon(options.ImageEnabled and options.Image or "", backgrounds, self, bgImage, true)
        local button = self.MobileButton
        button.Visible = options.Flag ~= guid and (options.MobileButtonAlwaysVisible or device == "Mobile" or options.MobileButtonVisible and not options.Visible)
        safeReparent(button, options.Flag ~= guid and gui.MobileButtons or nil)
        window.Parent = options.Flag ~= guid and gui.Holder.Windows or nil
        button.CanvasGroup.TextLabel.Text = (otherLib:GetCharacters(title)[1] or "-"):upper()
        setIcon(options.Icon or "", nil, self, button.CanvasGroup.ImageLabel)
        button.CanvasGroup.ImageLabel.Visible = true
        button.CanvasGroup.TextLabel.Visible = button.CanvasGroup.ImageLabel.Image == ""
        button.CanvasGroup.BackgroundTransparency = 1
        button.CanvasGroup.Size = U2s(1, 1)
        button.UIStroke.Enabled = not options.NoStrokes
        button.CanvasGroup.UIStroke.Enabled = options.MobileButtonNeon
        button.UICorner.CornerRadius = cornerState[options.RoundEverything]
        button.CanvasGroup.UICorner.CornerRadius = cornerState[options.RoundEverything]

        button.BackgroundColor3 = themeB
        button.UIStroke.Color = themeS
        button.CanvasGroup.TextLabel.TextColor3 = themeT
        button.CanvasGroup.TextLabel.TextStrokeColor3 = themeS
        button.CanvasGroup.UIStroke.Color = themeM
        
        local shi = settingsOverlay.SettingsHub.ImageBlur.Downsampler.Image
        window.SoundCache.Volume = options.Volume / 200
        window.Sounds.Notification.SoundId = options.NotificationSound
        window.Sounds.Click.SoundId = options.ClickSound
        window.Sounds.Hover.SoundId = options.HoverSound
        topbarZone.TitleZone.Title.Text = title:sub(1, 199999)
        setIcon(options.Icon or "", nil, self, topbarZone.TitleZone.Icon)
        footer.Label.Text = translate(self, "Footer")
        bgImage.ImageTransparency = options.ImageTransparency
        bgImage.ImageColor3 = options.ImageColor
        shi.ImageTransparency = options.ImageTransparency
        shi.ImageColor3 = options.ImageColor
        realWindow.BackgroundTransparency = options.BackgroundTransparency
        settingsOverlay.SettingsHub.BackgroundTransparency = 0
        setIcon(options.ImageEnabled and options.Image or "", backgrounds, self, shi, true)
        realWindow.InsideStroke.Thickness = options.NeonThickness
        bgImage.UICorner.CornerRadius = realWindow.UICorner.CornerRadius
        realWindow.Corner.UICorner.CornerRadius = realWindow.UICorner.CornerRadius
        realWindow.Overlay.UICorner.CornerRadius = realWindow.UICorner.CornerRadius
        settingsOverlay.UICorner.CornerRadius = realWindow.UICorner.CornerRadius
        settingsOverlay.SettingsHub.UICorner.CornerRadius = realWindow.UICorner.CornerRadius
        shi.UICorner.CornerRadius = realWindow.UICorner.CornerRadius
        window.Blur.Size = options.FullBlurSize and U2s(1, 1) or U2n(1, -12, 1, -12)

        local keysys = realWindowContents.KeySystemBlur.Downsampler.KeySystemOverlay.Canvas
        keysys.BackgroundColor3 = themeB
        keysys.Darkener.BackgroundColor3 = themeS
        keysys.UICorner.CornerRadius = realWindow.UICorner.CornerRadius
        keysys.Darkener.UICorner.CornerRadius = realWindow.UICorner.CornerRadius
        
        local keysysbgImage = keysys.ImageBlur.Downsampler.BackgroundImage
        setIcon(options.KeyBackground or bgImage.Image, backgrounds, self, keysysbgImage, true)
        keysysbgImage.Image = bgImage.Image
        keysysbgImage.UICorner.CornerRadius = realWindow.UICorner.CornerRadius
        keysysbgImage.ImageTransparency = options.ImageTransparency
        keysysbgImage.ImageColor3 = options.ImageColor
        
        keysys = keysys.Holder.Upscaler
        keysys.Shadow.ImageColor3 = themeS
        
        keysys = keysys.Contents
        keysys.BackgroundColor3 = themeB
        keysys.UICorner.CornerRadius = realWindow.UICorner.CornerRadius
        keysys.Title.TextColor3 = themeT
        keysys.Button.BackgroundColor3 = themeT
        keysys.Button.UIStroke.Color = themeT
        keysys.Button.UIStroke.Enabled = not options.NoStrokes
        keysys.Button.UICorner.CornerRadius = cornerState[options.RoundEverything]
        keysys.Bar.Bar.BackgroundColor3 = themeS
        keysys.Bar.Bar.UIStroke.Color = themeT
        keysys.Bar.Bar.UIStroke.Enabled = not options.NoStrokes
        keysys.Bar.Bar.UICorner.CornerRadius = cornerState[options.RoundEverything]
        keysys.Bar.Bar.Icon.ImageColor3 = themeT
        keysys.Bar.Bar.Icon.Separator.BackgroundColor3 = themeT
        keysys.Bar.Bar.Icon.TextBox.TextColor3 = themeT
        keysys.Bar.Bar.Icon.TextBox.PlaceholderColor3 = themeT:Lerp(themeS, 0.25)

        local kst = translate(self, "KeySystemTitle")
        if #kst == 0 then
            kst = "Key Required"
        end

        keysys.Title.Text = kst

        kst = translate(self, "KeyPlaceholder")
        if #kst == 0 then
            kst = "Your key here..."
        end

        keysys.Bar.Bar.Icon.TextBox.PlaceholderText = kst
        
        local kss = options._kss or 1
        kst = translate(self, "KeyButton" .. kss)
        if #kst == 0 then
            kst = UI_DEBUG.EN_KEY_STATES[kss]
        end
        
        keysys.Button.Text = kst
        
        if options.NeonType == "Stroke" then
            realWindowContents.Size = U2n(1, -options.NeonThickness * 2, 1, -options.NeonThickness * 2)
            realWindowContents.Position = U2s(0.5, 0.5)
            realWindowContents.AnchorPoint = V2n(0.5, 0.5)
            realWindow.AnchorPoint = V2n(0.5, 0.5)
            realWindow.Position = U2s(0.5, 0.5)
            realWindow.TopNeon.Visible = false
            realWindow.InsideStroke.Enabled = true
        else
            realWindowContents.Size = U2n(1, 0, 1, options.CornerRadius <= 0 and options.NeonType == "Top" and -options.NeonThickness or 0)
            realWindowContents.Position = U2n(0.5, 0, 0, options.CornerRadius <= 0 and options.NeonType == "Top" and options.NeonThickness or 0)
            realWindowContents.AnchorPoint = V2n(0.5, 0)
            realWindow.TopNeon.Size = U2n(1, 0, 0, options.NeonThickness)
            realWindow.AnchorPoint = V2n(0, 0)
            realWindow.Position = U2s(0, 0)
            realWindow.TopNeon.Visible = options.CornerRadius <= 0 and options.NeonType == "Top"
            realWindow.InsideStroke.Enabled = false
        end

        local tt = options.Tooltip
        if tt ~= options._PrevTooltip then
            options._PrevTooltip = tt
            tooltipObject.Options.Window = self
            tooltipObject.Options.Text = tt
            tooltipObject:Refresh()
        end

        window.Blur.Visible = not options.DisableBlurBackground and options.BlurBackground and options.Visible
        if options._OldVisible ~= options.Visible and not options.Debounce and options._Ready then
            options._OldVisible = options.Visible
            if options.Visible then
                self:Show()
            else
                self:Hide()
            end
        end

        return self
    end,
    FirstLaunch = ranTimes <= 1,
    LaunchTimes = round(ranTimes),
    RefreshAll = function(self)
        refreshEverything(self)
        self.ThemeChanged:Fire(self.Options.Theme)
    end,
    AddTab = function(...)
        local tab = newObject(tabFuncs, ...);
        (...).Objects[tab.Flag] = tab;
        (...).ChildAdded:Fire(tab)

        return tab
    end,
    Tab = function(self, ...)
        return self:AddTab(...)
    end,
    NewTab = function(self, ...)
        return self:AddTab(...)
    end,
    AddCustomTab = function(...)
        local tab = newObject(customTabFuncs, ...);
        (...).Objects[tab.Flag] = tab;
        (...).ChildAdded:Fire(tab)

        return tab
    end,
    CustomTab = function(self, ...)
        return self:AddCustomTab(...)
    end,
    NewCustomTab = function(self, ...)
        return self:AddCustomTab(...)
    end,
    AddHeader = function(...)
        local head = newObject(tabHeaderFuncs, ...);
        (...).Objects[head.Flag] = head;
        (...).ChildAdded:Fire(head)

        return head
    end,
    Header = function(self, ...)
        return self:AddHeader(...)
    end,
    NewHeader = function(self, ...)
        return self:AddHeader(...)
    end,
    AddTabHeader = function(self, ...)
        return self:AddHeader(...)
    end,
    TabHeader = function(self, ...)
        return self:AddHeader(...)
    end,
    NewTabHeader = function(self, ...)
        return self:AddHeader(...)
    end,
    AddSeparator = function(...)
        local separator = newObject(tabSeparatorFuncs, ...);
        (...).Objects[separator.Flag] = separator;
        (...).ChildAdded:Fire(separator)

        return separator
    end,
    Separator = function(self, ...)
        return self:AddSeparator(...)
    end,
    NewSeparator = function(self, ...)
        return self:AddSeparator(...)
    end,
    AddTabSeparator = function(self, ...)
        return self:AddSeparator(...)
    end,
    TabSeparator = function(self, ...)
        return self:AddSeparator(...)
    end,
    NewTabSeparator = function(self, ...)
        return self:AddSeparator(...)
    end,
    SetTab = function(self, tabOrTabName)
        if typeof(tabOrTabName) == "string" then
            local tab = self.Objects[tabOrTabName]
            if not tab then
                local f = string["for" .. "mat"] -- suspend the warning in Roblox Studio
                error(f("Tab '%s' not found!", tabOrTabName), 0)
            end

            return tab:SwitchTo()
        elseif typeof(tabOrTabName) == "table" or typeof(tabOrTabName) == "userdata" then
            if not tabOrTabName.SwitchTo then
                error("Tab not found!", 0)
            end

            return tabOrTabName:SwitchTo()
        end

        error("Tab not found!", 0)
    end,
    _Show = function(self)
        if self.Options.Debounce then return end
        self.Options.Debounce = true

        local window = self.Window.RealWindow
        local t = 1 / handleAnimationSpeed(self.Options.AnimationSpeed)

        window.Parent.Visible = true
        window.Overlay.Visible = true
        window.ClipsDescendants = true
        window.Overlay.BackgroundTransparency = 0

        tweenOnce(window.Parent, TIn(t, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = self.Options.Size })
        tweenOnce(window.Parent.Shadow, TIn(t, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { ImageTransparency = 1 - ((1 - self.Options.ShadowTransparency) * (1 - self.Options.BackgroundTransparency)), Size = U2n(1, self.Options.ShadowSize * 2, 1, self.Options.ShadowSize * 2) })
        tweenOnce(window.Overlay, TIn(t * 2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { BackgroundTransparency = 1 })
        cursorLib:SetActive(self.Cursor)

        wait(0.1 / handleAnimationSpeed(self.Options.AnimationSpeed))

        window.ClipsDescendants = false

        wait(t - 0.1)

        window.Overlay.Visible = false

        wait(0.1)
        self.Options.Debounce = false
    end,
    _Hide = function(self)
        if self.Options.Debounce then return end

        local kb = self.Options.Keybind
        local mb = device == "Mobile" or self.Options.MobileButtonAlwaysVisible or self.Options.MobileButtonVisible

        if not self.Options.Keybind and not mb and not self.Options.Closed then
            if not self.Options.ToggleKeyObject or not self.Options.ToggleKeyObject.ColorPickers[0] or not self.Options.ToggleKeyObject.ColorPickers[0].Value then
                self.Options.Visible = true
                return self:Notification({ Title = "Unable to hide the UI", Duration = 10, Text = "Please set the keybind first!" })
            else
                kb = Enum.KeyCode:FromValue(self.Options.ToggleKeyObject.ColorPickers[0].Value)
            end
        end

        self.Options.Debounce = true
        cursorLib:SetActive(self.Cursor, false)

        if self.IsDesktop and not self.Options.Closed then
            if not self.Options._first then
                self.Proxy:Notification({ Title = "UI hidden", Duration = 5, Text = (kb and "Press " .. kb.Name or "") .. (mb and (kb and " or" or "Press") .. " the floating button" or "") .. " to open UI" })
            end

            self.Options._first = false
        end

        local window = self.Window.RealWindow
        local t = 1 / handleAnimationSpeed(self.Options.AnimationSpeed)

        self.Options.Size = window.Parent.Size
        window.Parent.Visible = true
        window.Overlay.Visible = true
        window.ClipsDescendants = false
        window.Overlay.BackgroundTransparency = 1

        tweenOnce(window.Parent, TIn(t, Enum.EasingStyle.Quint, Enum.EasingDirection.In), { Size = U2s(0, 0) })
        tweenOnce(window.Parent.Shadow, TIn(t * 5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { ImageTransparency = 1, Size = U2s(0, 0) })
        tweenOnce(window.Overlay, TIn(t / 1.5), { BackgroundTransparency = 0 })

        wait(t - 0.1)
        window.ClipsDescendants = true

        if t - 0.1 > 0 then
            wait(0.1 / handleAnimationSpeed(self.Options.AnimationSpeed))
        end

        window.Parent.Visible = false
        cursorLib:SetActive(self.Cursor, false)
        
        wait(0.1)
        
        cursorLib:SetActive(self.Cursor, false)
        self.Options.Debounce = false
    end,
    Close = function(self)
        if self.Options.Closed then return end
        self.Options.Closed = true

        spawn(self.Options.OnClose, self)
        self.Destroying:Fire()
        
        for i, v in self.Defaults do
            i:Set(v)
        end

        for i, v in self._Connections do
            if v.Connected then
                v:Disconnect(v)
            end
        end

        uiBackBlur:Unbind(self.BlurFrame)
        
        render(2)
        
        self.Options.Debounce = false
        self.Options.Closed = true
        
        self:Hide()
        
        local function clear()
            self.Window:Destroy()
            self.MobileButton:Destroy()
            self.Cursor:Destroy()

            for i, v in self.Objects do
                if v.Class ~= "Tab" and v.Class ~= "Header" and v.Class ~= "Separator" then
                    v:Destroy()
                end
            end

            for _, v in self._Blurs do
                v[2]:Destroy()
            end
        end
        
        if not self.Window.Visible then
            clear()
        else
            self.Window:GetPropertyChangedSignal("Visible"):Once(function()
                render()
                clear()
            end)
        end
    end,
    Show = function(self)
        if self.Options.Debounce then return end

        self.Options.Visible = true
        spawn(self._Show, self)
    end,
    Hide = function(self)
        if self.Options.Debounce then return end

        self.Options.Visible = false
        spawn(self._Hide, self)
    end,
    Toggle = function(self)
        if self.Options.Debounce then return end

        self.Options.Visible = not self.Options.Visible

        if not self.Options.Visible and not self.Options.Keybind and device ~= "Mobile" and not (self.Options.MobileButtonAlwaysVisible or self.Options.MobileButtonVisible) and not self.Options.Closed then
            if not self.Options.ToggleKeyObject or not self.Options.ToggleKeyObject.ColorPickers[0] or not self.Options.ToggleKeyObject.ColorPickers[0].Value then
                self.Options.Visible = true
                return self:Notification({ Title = "Unable to hide the UI", Duration = 10, Text = "Please set the keybind first!" })
            end
        end

        self:Refresh()
    end,
    
    TryClose = function(self)
        local options = self.Options
        if options._closedb or options.Closed then return end
        options._closedb = true
        
        if self:WindowNotification({ Title = "Are you sure?", Text = "Are you sure you wanna close the UI?", HasButtons = true }) then
            self:Close()
        end
        
        options._closedb = false
    end
}

tooltipObject = newObject({
    Class = "Tooltip",
    DefaultOptions = {
        Text = "",
        Window = false,
        CustomMousePosition = mouse,
        Dark = false
    },

    Init = function(self, options)
        local tooltip = getPlaceholder("Tooltip")

        local cd = true
        tooltip.TextLabelInvisible.Changed:Connect(function()
            if not cd then return end

            cd = false
            tooltip.TextLabel.Text = tooltip.TextLabelInvisible.Text
            tooltip.Size = U2o(tooltip.TextLabelInvisible.TextBounds.X + 14, tooltip.TextLabelInvisible.TextBounds.Y + 14)
            render()
            tooltip.TextLabel.Text = tooltip.TextLabelInvisible.Text
            tooltip.Size = U2o(tooltip.TextLabelInvisible.TextBounds.X + 14, tooltip.TextLabelInvisible.TextBounds.Y + 14)
            cd = true
            render()
            tooltip.TextLabel.Text = tooltip.TextLabelInvisible.Text
            tooltip.Size = U2o(tooltip.TextLabelInvisible.TextBounds.X + 14, tooltip.TextLabelInvisible.TextBounds.Y + 14)
        end)

        local object = addFunctions({
            Tooltip = tooltip,
            Options = options,
            Class = self.Class
        }, self)

        rs.RenderStepped:Connect(function()
            object.Proxy:Refresh()
        end)

        return object
    end,

    Refresh = function(self)
        local options = self.Options
        local cap : string = options.Text
        local tt = self.Tooltip
        tt.Visible = #cap ~= 0
        tt.TextLabelInvisible.Text = cap:sub(0, 199999)
        safeReparent(tt, gui)

        options.CustomMousePosition = options.CustomMousePosition or mouse

        local safe = 25
        local tooltipSize = tt.AbsoluteSize
        local screenSize = gui.AbsoluteSize
        local mousePos = V2n(options.CustomMousePosition.X, options.CustomMousePosition.Y)
        local targetPos = mousePos + V2n(15, 50)

        tt.Position = U2o(clamp(targetPos.X, safe, screenSize.X - tooltipSize.X - safe), clamp(targetPos.Y, safe + tooltipSize.Y, screenSize.Y - tooltipSize.Y - safe))
        tt.TextLabelInvisible.Size = U2o(floor(gui.AbsoluteSize.X / 2.5), 10000)

        local theme = (options.Window or coreWindow)
        if theme then
            theme = theme.Theme
        end

        if not theme then return end

        tt.BackgroundColor3 = theme.Back:Lerp(theme.Stroke, options.Dark and 0.35 or 0)
        tt.OutsideStroke.Color = theme.Stroke
        tt.TextLabel.TextColor3 = theme.Text
    end
})

library = newObject({
    Class = "Library",
    DefaultOptions = {
        Tooltip = "",

        Theme = {
            Back = C3R(20, 20, 20),
            Main = C3R(255, 0, 127),
            Stroke = C3R(0, 0, 0),
            Text = C3R(255, 255, 255)
        }
    },

    FirstLaunch = ranTimes <= 1,
    LaunchTimes = round(ranTimes),
    Init = function(self, options)
        coreWindow = newObject(windowFuncs, nil, { Visible = false, UnlockMouse = false, Text = guid, Flag = guid, MobileButtonVisible = false, MobileButtonAlwaysVisible = false })
        coreWindow.Window.Visible = false
        coreWindow.Window:GetPropertyChangedSignal("Parent"):Connect(function()
            safeReparent(coreWindow.Window, nil)
            safeReparent(coreWindow.MobileButton, nil)
        end)
        safeReparent(coreWindow.Window, nil)

        local object = addFunctions({
            _CoreWindow = coreWindow,
            Options = options,
            Languages = langs,
            Windows = { },
            WindowAdded = event.new(),
            WindowRemoved = event.new(),
            EventClass = event,
            Icons = allIcons,
            Background = allBackgrounds,
            Example = require(script.Example), -- function
            Emulator = emulator,
            IsMobile = device == "Mobile",
            IsDesktop = device == "PC",
            Platform = platform,
            RealPlatform = realPlatform,
            Device = device,
            Executor = executor,
            ExecutorVersion = version,
            Version = config.Version,
            Name = config.Name,
            Author = config.Author,
            Config = config,
            Class = self.Class,
            Translate = translators,
            Translators = translators
        }, self)
        
        spawn(function()
            --[[for i, v in coreWindow.Objects do
                if v.Class ~= "Tab" and v.Class ~= "Header" and v.Class ~= "Separator" then
                    v:Destroy()
                end
            end
            
            uiBackBlur:Unbind(coreWindow.BlurFrame)
            coreWindow.Cursor:Destroy()
            coreWindow.MobileButton:Destroy()
            coreWindow.Window:Destroy()
            for _, v in coreWindow._Blurs do
                v[2]:Destroy()
            end]]
        end)

        return object
    end,

    Refresh = function(self)
        local options = self.Options
        self._CoreWindow.Theme = options.Theme

        local tt = options.Tooltip

        if tt ~= "" then
            tooltipObject.Options.Window = self
            tooltipObject.Options.Text = tt
            tooltipObject:Refresh()

            options.Tooltip = ""
        end
    end,

    Window = function(self, ...)
        self:Refresh()

        local window = newObject(windowFuncs, nil, ...)
        tinsert(self.Windows, window)

        self.WindowAdded:Fire(window)
        window.Destroying:Once(function()
            tremove(self.Windows, tfind(self.Windows, window))
            self.WindowRemoved:Fire(window)
        end)

        repeat render() until window.Options.ExecutionTimes -- function

        window._Ready = true

        local ts = window.ThemeString
        if ts ~= "" then
            window:SetThemeString(ts)
        end

        return window
    end,

    Notification = function(self, ...)
        self:Refresh()
        return self._CoreWindow:Notification(...)
    end,
    Notify = function(self, ...)
        return self:Notification(...)
    end,

    DecodeShareString = function(self, str)
        local s, e = _pcall(_decodeThingy, str)
        return s and e or false
    end,
    EncodeShareString = function(self, str)
        return encoder:Encode(je(str))
    end
})

global[... or config.Name] = library
library.WindowRemoved:Connect(function()
    if #library.Windows == 0 then
        uiBackBlur.BlurSize = 1
    end
end)

spawn(function()
    local loadedImagesCache = Inew("CanvasGroup", gui)
    loadedImagesCache.BackgroundTransparency = 1
    loadedImagesCache.Name = "LoadedImagesCache"
    loadedImagesCache.GroupTransparency = 0.98
    loadedImagesCache.Size = U2o(1, 1)
    
    local function loadImage(id, name)
        local img = Inew("ImageLabel", loadedImagesCache)
        img.BackgroundTransparency = 1
        img.ImageTransparency = 0.98
        img.Image = "rbxassetid://" .. id
        img.Name = name
        img.Size = loadedImagesCache.Size
    end
    
    for i, v in icons do
        spawn(loadImage, v, i)
    end
    
    for i, v in backgrounds do
        spawn(loadImage, v, i)
    end
end)

return library
    end;

    modules[objects["Instance9"]] = function(...)
        local script = objects["Instance9"];
local data = {
    EN = {
        Dialog1 = "OK",
        Dialog2 = "NO",
        
        KeySystemTitle = "Key Required",
        KeyPlaceholder = "Your key here...",
        
        KeyButton1 = "Get Key",
        KeyButton2 = "Copied the URL to Clipboard!",
        KeyButton3 = "Copy the URL from the Text Box",
        KeyButton4 = "Check Key",
        KeyButton5 = "Checking...",
        KeyButton6 = "Invalid Key",
        KeyButton7 = "Valid Key!"
    },
    
    RU = {
        Dialog1 = "ОК",
        Dialog2 = "Нет",
        
        KeySystemTitle = "Нужен Ключ",
        KeyPlaceholder = "Ваш Ключ...",
        
        KeyButton1 = "Получить Ключ",
        KeyButton2 = "Ссылка скопирована!",
        KeyButton3 = "Скопируйте ссылку из Текстового Поля",
        KeyButton4 = "Проверить Ключ",
        KeyButton5 = "Проверка...",
        KeyButton6 = "Неверный Ключ",
        KeyButton7 = "Верный Ключ!"
    }
}

local getmetatable = getmetatable
local typeof = typeof or type
local freeze = table and table.freeze or function(...) return ... end
local freeze = function(...)
    freeze(...)
    return ...
end

local function addF(self, value)
    if getmetatable(value) == "Translator" then
        self, value = value, self
    end
    
    if typeof(value) == "string" then
        value = { Text = value }
    end
    
    for i, v in self do
        print(value[i], i, v)
        if value[i] == nil then
            value[i] = v
        end
    end

    return value
end

local translatorMeta = freeze({ __add = addF, __newindex = error, __metatable = "Translator" })
for language, tbl in data do
    setmetatable(tbl, translatorMeta)
end

return setmetatable(data, freeze({ __add = function(self, value)
    if getmetatable(value) == "Translator" then
        self, value = value, self
    end

    for i, v in value do
        local t = self[i]
        if typeof(t) == "string" then
            local newT = { Text = t }
            t = newT
            self[i] = t
        end
        
        if typeof(t) == "table" then
            t += v
        end
    end

    return value
end, __newindex = error, __metatable = "Translator" }))
    end;

    modules[objects["Instance10"]] = function(...)
        local script = objects["Instance10"];
return function(lib)
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    
    local window = lib:Window({
        Text = "Example Window",
        Translations = { RU = "Окно-Пример" } + lib.Translate,
        ThemeString = "oU7L9DGCA0KBAIAiWgBgpmOWO9xOiQc4FB6sQNhWSbXxXZRdUUfEgiJXCtjJxCeTElOkVybxK2luAJOccP1E8SI15Fl1l7ZOnDeZdt5QqQ1p7AIIYAirR3NMU4Yz5ekLRGCev7ZW9ZXcRkBKghEUVxHUO1zNDICWmg3CbSGprVBTDeDSGAUEZxC00caiMAeX1jfAmIai5wnT2E3QqQwrsGoyoE",
        Keybind = Enum.KeyCode.RightShift,
        UserProfile = true,
        Language = "English" -- gonna be turned into RU (2 first uppercase letters, aka Russian = RU)
    })
    
    print(window.Translations)
    
    task.spawn(function()
        window:WindowNotification({ HasButtons = true, Translations = { EN = { Title = "Test 1", Text = "Some Testing Text" }, RU = { Title = "Тест 1", Text = "Какой-то Текст для Теста" } } })
        window:WindowNotification({ Translations = { EN = { Title = "Test 2", Text = "Some Testing Text" }, RU = { Title = "Тест 2", Text = "Какой-то Текст для Теста 2" } } })
        window:WindowNotification({ Translations = { EN = { Title = "Test 3", Text = "Some Testing Text" }, RU = { Title = "Тест 3", Text = "Какой-то Текст для Теста 3" } } })

        window:WindowNotification({ HasButtons = true, Translations = { EN = { Title = "Key System", Text = "Enter the Key to proceed" }, RU = { Title = "Система Ключей", Text = "Введите Ключ, чтобы продолжить" } } })
    end)
    
    if not window:KeySystem({ Callback = function(key)
        return key == "KEY"
    end, KeyUrl = "Hi!" }) then return end
    
    window:AddHeader({ Translations = { EN = "Regular Tabs", RU = "Обычные Табы" } })
    
    local tab1 = window:AddTab({ Translations = { EN = "Tab 1", RU = "Таб 1" }, Icon = "Home" })
    tab1:AddButton({ Callback = print, Text = "Button", Translations = { RU = "Кнопка" } })
    
    local left = tab1:AddLeftGroupbox({ Text = "Left", Translations = { RU = "Левая" } })
    left:AddToggle({ Text = "Toggle", Translations = { RU = "Тоггл" } })
    left:AddSlider({ Text = "Slider", Translations = { RU = "Слайдер" } })
    left:AddInput({ Text = "Input", Translations = { RU = "Ввод" } })
    left:AddDropdown({ Text = "Dropdown", Options = { "Option 1", "Option 2", "Option 3" }, Translations = { RU = "Радио" } })
    
    local right = tab1:AddRightGroupbox({ Text = "Right", Translations = { RU = "Правая" } })
    right:AddButton({ Text = "Button", Callback = print, Translations = { RU = "Кнопка" } })
    right:AddToggle({ Text = "Toggle", Translations = { RU = "Тоггл" } })
    right:AddSlider({ Text = "Slider", Translations = { RU = "Слайдер" } })
    right:AddInput({ Text = "Input", Translations = { RU = "Ввод" } })
    right:AddDropdown({ Text = "Dropdown", Options = { "Option 1", "Option 2", "Option 3" }, Translations = { RU = "Радио" } })
end
    end;

    modules[objects["Instance23"]] = function(...)
        local script = objects["Instance23"];
local global = (getfenv().getgenv or function() return _G end)()
local key = "EditableCursorLib"

if global[key] then
    return global[key]
end

local base = "111611945515467"

local BASE_DECREASE, BIG_DECREASE = 1, 4 -- fixes pixels being weird

local BASE = 128 - BASE_DECREASE
local BIG = 196 - BIG_DECREASE

local EFFECTS = { -- Order, ID, Name, Is Pixelated, Size, Put Behind Base, Default Color | nil
    -- There gonna be +1 order skip for each new category

    GlitchyGlow = { 1, "109237646553064", "Glitchy Glow", true, BIG, true, nil },
    Glitch = { 2, "137064778284738", "Glitch", true, BASE, false, nil },
    GlitchyOutline = { 3, "100747681027577", "Inside Glitchy Outline", true, BASE, false, nil },
    SmallGlitch = { 4, "115837731276292", "Small Glitch", true, BASE, false, nil },

    Glow = { 6, "111303583666486", "Glow", false, BIG, true, nil },
    CenteredGlow = { 7, "117156608404145", "Centered Glow", false, BASE, false, nil },
    InsideGlow = { 8, "82284124866450", "Inside Glow", false, BASE, false, nil },

    Outline = { 10, "137779358107707", "Outline", false, BIG, true, Color3.new(0, 0, 0) },
    CenteredOutline = { 11, "107008327010804", "Centered Outline", false, BASE, false, nil },
    InsideOutline = { 12, "89472362438218", "Inside Outline", false, BASE, false, Color3.new(0, 0, 0) },

    GradientTop = { 14, "125702466733350", "Top Gradient", false, BASE, false, nil },
    GradientBottom = { 15, "78860595216966", "Bottom Gradient", false, BASE, false, nil },

    Normal3D = { 17, "105926903515772", "3D", false, BASE, false, Color3.new(1, 1, 1) },
    Blurred3D = { 18, "110410299371403", "Blurred 3D", false, BASE, false, Color3.new(1, 1, 1) },
    Metallic3D = { 19, "136384212097552", "Metallic 3D", false, BASE, false, Color3.new(1, 1, 1) }
}

BASE += BASE_DECREASE
BIG += BIG_DECREASE

for i, v in EFFECTS do
    local ratio = v[5] / BASE
    v[5] = UDim2.fromScale(ratio, ratio)
end

local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer or plrs.PlayerAdded:Wait()

local cursorsGUI = Instance.new("ScreenGui")
task.spawn(function()
    cursorsGUI.Parent = getfenv().gethui and getfenv().gethui() or game:GetService("CoreGui") or plr:WaitForChild("PlayerGui")
end)

pcall(function()
    cursorsGUI.OnTopOfCoreBlur = true
end)

cursorsGUI.IgnoreGuiInset = false
cursorsGUI.ResetOnSpawn = false
cursorsGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
cursorsGUI.DisplayOrder = 2147483647
cursorsGUI.Name = "Editable Cursor Library"

local cursor = Instance.new("CanvasGroup", cursorsGUI)
cursor.BackgroundTransparency = 1
cursor.AnchorPoint = Vector2.new(0.25, 0.25)
cursor.Size = UDim2.fromOffset(50, 50) -- that gonna be variable + actual size gonna be x2 smaller
cursor.Name = "Cursor Holder"

local cursorDefault = Instance.new("Frame") do
    cursorDefault.BackgroundTransparency = 1
    cursorDefault.AnchorPoint = Vector2.new(0.5, 0.5)
    cursorDefault.Size = UDim2.fromScale(0.5, 0.5)
    cursorDefault.Position = cursorDefault.Size
    cursorDefault.Visible = false
    cursorDefault.Name = "Cursor"

    local baseImage = Instance.new("ImageLabel", cursorDefault)
    baseImage.BackgroundTransparency = 1
    baseImage.AnchorPoint = Vector2.new(0.5, 0.5)
    baseImage.Size = UDim2.fromScale(1, 1)
    baseImage.Position = UDim2.fromScale(0.5, 0.5)
    baseImage.Image = "rbxassetid://" .. base
    baseImage.ZIndex = 0
    baseImage.Name = "Cursor Image"

    local baseInfront = Instance.new("Frame", cursorDefault)
    baseInfront.Size = UDim2.fromScale(1, 1)
    baseInfront.BackgroundTransparency = 1
    baseInfront.ZIndex = 1
    baseInfront.Name = "Infront"

    local baseBehind = baseInfront:Clone()
    baseBehind.Parent = cursorDefault
    baseBehind.ZIndex = -1
    baseBehind.Name = "Behind"
end

local setmetatable = setmetatable
local insert = table.insert
local find = table.find
local remove = table.remove
local rawset = rawset

local c3n = Color3.new
local v2 = Vector2.new
local U2s = UDim2.fromScale
local U2o = UDim2.fromOffset

local rmd = Enum.ResamplerMode.Default
local rmp = Enum.ResamplerMode.Pixelated

local clamp = math.clamp
local max = math.max

local function createEffect(effectName)
    local effectData = EFFECTS[effectName]
    local image = Instance.new("ImageLabel")
    image.BackgroundTransparency = 1
    image.AnchorPoint = v2(0.5, 0.5)
    image.Image = "rbxassetid://" .. effectData[2]
    image.Name = effectData[3]
    image.ResampleMode = effectData[4] and rmp or rmd
    image.Size = effectData[5]
    image.Position = U2s(0.5, 0.5)

    return image, effectData[6], effectData[7], effectData[3]
end

local defaultEffectOptions = {
    Order = 0,
    Color = c3n(1, 1, 1),
    Transparency = 0,
    Visible = true,

    Destroy = function(self)
        self.Destroyed = true
        self.Effect:Destroy()

        if self.Cursor then
            local cursorEffects = self.Cursor.Effects
            local me = find(cursorEffects, self)
            if me then
                remove(cursorEffects, me)
            end
        end

        return self
    end,

    Refresh = function(self)
        local eff = self.Effect
        local visible = self.Visible
        local trans = clamp(self.Transparency, 0, 1)

        eff.Visible = visible
        if not visible or trans == 1 then return end

        eff.ImageColor3 = self.Color
        eff.ImageTransparency = trans
        eff.ZIndex = self.Order
    end
}

local function newEffect(effectName, options)
    local options = options or { }    
    local effect, putBehind, defaultColor, name = createEffect(effectName)

    if options.Color == nil then
        options.Color = defaultColor or defaultEffectOptions.Color
    end

    for i, v in defaultEffectOptions do
        if options[i] == nil then
            options[i] = v
        end
    end

    options.NameShort = effectName
    options.Name = name
    options.Effect = effect
    options.PutBehind = putBehind
    options.Destroyed = false

    return options
end

local cursorProxyData = { }
local CursorBase = {
    Destroy = function(self)
        local self = cursorProxyData[self]
        if not self then return end

        self.Frame:Destroy()
        self.Active = false
        self.Destroyed = true

        cursorProxyData[self] = nil
    end
}

for i, v in EFFECTS do
    CursorBase[i] = function(self, options)
        local effect = newEffect(i, options)
        if effect.Destroyed then return end

        effect.Effect.Parent = self.Frame[effect.PutBehind and "Behind" or "Infront"]
        effect.Cursor = self

        insert(self.Effects, effect)

        return self
    end
end

local biggestPriority = 0
local maxBit32 = (2 ^ 31) - 1

local activeQueue : { [number]: { } } = { }
local cursorBase = {
    __index = function(self, index)
        local self = cursorProxyData[self]
        if not self then return end

        local ret = CursorBase[index]
        if ret == nil then ret = self[index] end

        return ret
    end,
    __metatable = "Editable Cursor",
    __tostring = "Cursor",
    __newindex = function(self, index, value)
        self = cursorProxyData[self]
        if not self then return end

        local isPriority = index == "Priority"
        local isActive = index == "Active"

        if isActive and self.Destroyed then value = false end
        self[index] = isPriority and clamp(value, -maxBit32, maxBit32) or value

        local myQueue, me
        if isPriority or isActive and not value then
            local old = self._Priority
            self._Priority = isPriority and clamp(value, -maxBit32, maxBit32) or self.Priority

            myQueue = activeQueue[old]
            if myQueue then
                me = find(myQueue, self)
                if me then
                    remove(myQueue, me)
                end

                if #myQueue == 0 then
                    activeQueue[old] = nil
                end
            end
        end

        if isActive and value then
            local priority = self.Priority

            myQueue = activeQueue[priority] or { }
            activeQueue[priority] = myQueue

            me = find(myQueue, self)
            if me then
                remove(myQueue, me)
            end

            insert(myQueue, 1, self)
        end

        local biggest = -maxBit32 - 1
        for priority in activeQueue do
            biggest = max(biggest, priority)
        end

        if not self.Active then
            self.Frame.Visible = false
        end
    end
}

local cursors = { }
local cursorLib = {
    new = function(effects)
        local newCursor = cursorDefault:Clone()
        newCursor.Parent = cursor

        local proxy = newproxy(true)
        local meta = getmetatable(proxy)
        local cursorData = {
            Active = false,
            Destroyed = false,

            Transparency = 0,

            Priority = 0,
            _Priority = 0,

            Size = 20, -- in pixels

            Centered = false,
            Effects = effects or { },

            Frame = newCursor,
            Color = c3n(1, 1, 1),

            Image = "",
            Blurry = false
        }

        cursorProxyData[proxy] = cursorData
        for i, v in cursorBase do
            meta[i] = v
        end

        insert(cursors, proxy)

        local effects = proxy.Effects
        for i = #effects, 1, -1 do
            local v = effects[i]
            if not v.Destroyed then
                v.Effect.Parent = newCursor[v.PutBehind and "Behind" or "Infront"]
                v.Cursor = proxy
            else
                remove(effects, i)
            end
        end

        return proxy
    end,
    SetActive = function(self, cursor, active)
        cursor.Active = false

        if active or active == nil then
            cursor.Active = true
        end

        return cursor
    end,

    Effects = { }
}

for i, v in EFFECTS do
    cursorLib[i] = function(self, options)
        return newEffect(i, options)
    end

    cursorLib.Effects[i] = table.freeze({ Order = v[1], Name = v[2], })
end

task.spawn(function() -- HANDLE CURSORS
    local mouse = plr:GetMouse()
    local guiServ = game:GetService("GuiService")
    local uis = game:GetService("UserInputService")

    local windowActive = true
    local mouseActive = true

    uis.WindowFocused:Connect(function()
        windowActive = true
        mouseActive = true
    end)

    uis.WindowFocusReleased:Connect(function()
        windowActive = false
    end)

    local uitmv = Enum.UserInputType.MouseMovement
    uis.InputBegan:Connect(function(inp)
        if inp.UserInputType == uitmv then
            mouseActive = true
        end
    end)

    uis.InputEnded:Connect(function(inp)
        if inp.UserInputType == uitmv then
            mouseActive = false
        end
    end)

    local mblc = Enum.MouseBehavior.LockCenter
    local last
    local function refreshCursor()
        cursor.Position = U2o(mouse.X, mouse.Y)
        for i, v in cursor:GetChildren() do
            v.Visible = false
        end

        local queue = activeQueue[biggestPriority]
        if not queue then return false end

        local currentCursor = queue[1]
        if not currentCursor then return false end

        cursor.GroupTransparency = currentCursor.Transparency
        cursor.Size = U2o(currentCursor.Size * 2, currentCursor.Size * 2)

        local isActive = uis.MouseEnabled and mouseActive and windowActive and not guiServ.MenuIsOpen and currentCursor.Active
        local frame = currentCursor.Frame

        frame.Visible = isActive
        frame.AnchorPoint = currentCursor.Centered and v2(1, 1) or v2(0.5, 0.5)

        if not isActive then return false end

        local cursorImage = frame:FindFirstChildOfClass("ImageLabel")
        cursorImage.ImageColor3 = currentCursor.Color

        if currentCursor.Image:gsub("[\n\r\f\t\0 ]", "") ~= "" then
            cursorImage.Image = currentCursor.Image

            for i, v in frame:GetChildren() do
                v.Visible = false
            end

            cursorImage.Visible = true
            cursorImage.ResampleMode = currentCursor.Blurry and rmd or rmp

            return true
        else
            cursorImage.Image = "rbxassetid://" .. base
            cursorImage.ResampleMode = rmd

            for i, v in frame:GetChildren() do
                v.Visible = true
            end
        end

        local effects = currentCursor.Effects
        for i = #effects, 1, -1 do
            local effect = effects[i]
            if not effect.Destroyed then
                effect:Refresh()
            else
                remove(effects, i)
            end
        end

        return true
    end
    
    local set = true
    local function cycle()
        if refreshCursor() then
            set = false
            uis.MouseIconEnabled = false
        else
            if not set then
                set = true
                uis.MouseIconEnabled = true
            end
        end
    end

    game:GetService("RunService").PreRender:Connect(cycle)
    -- while wait(1) do cycle() end
end)

global[key] = cursorLib
table.freeze(cursorLib.Effects)
return table.freeze(cursorLib)
    end;

    modules[objects["Instance5"]] = function(...)
        local script = objects["Instance5"];
return {
    Home = 14456045412,
    Cursor = 14913216473,
    Teleport = 6723742952,
    Audio = 302250236,
    Star = 3057073083,
    Sword = 7485051715,
    Shield = 7169354142,
    Roblox = 7414445494,
    Shiny = 8575479406,
    Shield2 = 7461510428,
    Roblox2 = 4689592016,
    Play = 10392248278,
    Paw = 13001190533,
    Tank = 86455593915524,
    Radiation = 10814128637,
    BlackHole = 102208106546256,
    Fan = 15332137726,
    Jumpstyle = 9560888465,
    Repeat = 79750966941583,
    RobuxOld = 14134388410,
    Factory = 110700397690037,
    Robux = 5986140521,
    Loading = 17119858971,
    Save = 101071239052290,
    Brush = 71254649724235,
    Discord = 91037557794799,
    Shop = 9405933217,
    Run = 70627586472131,
    User = 2795572800,
    Computer = 12684119225,
    PC = 12684119225,
    Check = 130396712201457,
    CheckMark = 130396712201457,
    Punch = 13050670424,
    Phone = 13021320268,
    Mobile = 13021320268,
    Crown = 11322089611,
    Cog = 4492476121,
    Settings = 4492476121,
    Gear = 4492476121,
    Globe = 96232528933854,
    Earth = 96232528933854,
    World = 96232528933854,
    Cog2 = 183390139,
    Gear2 = 183390139,
    Music = 7059338404,
    Hammer = 10885640682,
    Backpack = 6870729295,
    Friends = 10885655986,
    Emote = 110748588642372,
    RobloxPremium = 10885647358,
    RobloxStudio = 10885637246,
    Lightning = 11780984626,
    Avatar = 13285615740,
    Cross = 10152135063,
    Server = 9692125126,
    StarCreator = 11322155020,
    UserConfiguration = 11656483170,
    Config = 11656483170,
    Menu = 14895352864,
    Dance = 17824304373,
    Hammer2 = 127904742940104,
    Script = 9405930424,
    Info = 5832745500,
    Cloud = 16149050754,
    Music2 = 170813352,
    Trash = 90865958932830,
    Backpack2 = 124233015832617,
    Exit = 9405925508,
    Car = 13773498965,
    UI = 18979524646,
    Pipette = 97399695601030,
    Pipette2 = 126362121736567,
    Key = 117047144730308
}
    end;

    modules[objects["Instance3"]] = function(...)
        local script = objects["Instance3"];
return {
    Diamonds = 82443989458069,
    Diamonds2 = 140557430121570,
    Diamonds3 = 118040930519315,
    Anime = 1523757323,
    Anime1 = 8942361465,
    Anime2 = 6541436826,
    Anime3 = 13737759127,
    Anime4 = 4597457883,
    Anime5 = 14210882753,
    Anime6 = 130644346538217,
    Anime7 = 98743068907468,
    Anime8 = 1293887210,
    Anime9 = 10899663828,
    Ambient = 195225054,
    Ambient2 = 259554878,
    Ambient3 = 12727588434
}
    end;

    modules[objects["Instance7"]] = function(...)
        local script = objects["Instance7"];
return {{"align-vertical-distribute-center","chevron-down","list-restart","table-cells-split","gavel","dna-off","refresh-ccw-dot","venus","bean","circle-question-mark","folder-code","bolt","heater","feather","align-horizontal-distribute-center","grip-vertical","pill-bottle","person-standing","badge-swiss-franc","between-horizontal-end","file-braces-corner","rotate-cw","house-plus","bus-front","shield-ellipsis","between-vertical-end","globe-lock","tags","concierge-bell","bookmark-minus","file-down","picture-in-picture","messages-square","scissors","file-check-corner","phone-call","anchor","hand-helping","text-wrap","birdhouse","wifi-off","cloud-alert","message-square","cloud-download","folder-plus","cctv-off","mirror-round","user-round","pointer","between-horizontal-start","chevrons-up-down","brush","message-circle-more","parentheses","book-up-2","flame","chevrons-up","square-dashed","square-mouse-pointer","superscript","signal","wifi-cog","hexagon","navigation-2-off","eye-off","arrows-up-from-line","file-code-corner","square-centerline-dashed-horizontal","panels-right-bottom","scaling","hash","arrow-left-from-line","ship","ticket-percent","calendar-clock","x","non-binary","voicemail","presentation","tree-palm","badge","captions-off","align-vertical-justify-center","download","mouse-right","lens-convex","focus","diamond-percent","arrow-big-up","volume-x","mouse-pointer-click","origami","hard-drive","grid-2x2-x","package-minus","cloud","pipette","corner-left-down","badge-cent","cloud-lightning","user-round-pen","arrow-left-to-line","book-open-text","monitor-cloud","parking-meter","cat","heart-handshake","dam","trees","ham","circle-pause","chess-king","bean-off","rat","separator-horizontal","ambulance","signal-zero","citrus","phone-missed","calendar-off","chart-column","battery-medium","square-minus","decimals-arrow-left","folder-output","menu","image-down","terminal","angry","circle-dot-dashed","medal","cake-slice","git-graph","armchair","tickets","qr-code","copy","goal","trending-down","creative-commons","ev-charger","user-star","road","nfc","align-center-horizontal","car","notebook-tabs","ear","videotape","sun-moon","chart-scatter","toolbox","calendar","calendar-cog","gallery-horizontal","clipboard-x","book-open","circle-pile","rectangle-ellipsis","badge-plus","badge-info","file-headphone","bow-arrow","clipboard-pen-line","user-round-key","folder-search","utensils-crossed","arrow-up","arrow-up-from-dot","align-vertical-justify-start","layers-minus","pause","shrub","flag","biceps-flexed","align-horizontal-distribute-end","donut","calendar-plus-2","move-vertical","file-pen-line","badge-russian-ruble","radius","pilcrow","corner-left-up","georgian-lari","cable","book-user","square-arrow-down","circle-plus","view","cctv","circle-arrow-left","volume","octagon-alert","panel-bottom-dashed","book-a","align-end-vertical","thumbs-up","globe","rabbit","layers-plus","banknote-arrow-down","message-square-off","dice-4","message-circle-x","folder-x","message-circle-warning","map","move","arrow-up-left","award","arrow-down-wide-narrow","unfold-horizontal","lens-concave","motorbike","music-4","shield-x","file-volume","disc-3","file-signal","columns-4","archive-x","square-dashed-kanban","mouse-pointer-2","clock-arrow-up","clock-fading","vegan","message-circle-plus","fast-forward","user-pen","chess-knight","wifi-pen","files","send-to-back","alarm-clock","shopping-basket","send","brush-cleaning","skip-back","book-audio","file-scan","message-square-dashed","chevrons-left","umbrella","skip-forward","clipboard-copy","map-pin-off","arrow-up-from-line","circle-chevron-up","circle-small","align-vertical-space-between","lamp-desk","circle-arrow-up","zap","beaker","paintbrush","move-left","chevron-up","pen-tool","form","pencil-ruler","dna","arrow-big-down-dash","chart-area","bug-off","card-sim","map-pin-search","ellipse","spell-check","popcorn","blocks","washing-machine","microchip","badge-minus","cloud-sun","circle","shield-alert","map-minus","separator-vertical","ampersands","user-search","fence","square-user-round","sunrise","strikethrough","calendar-days","folder-bookmark","banknote-arrow-up","dollar-sign","message-square-quote","list-minus","cloud-hail","eye-closed","app-window-mac","ellipsis","copy-check","history","satellite","bookmark-plus","folder-key","coffee","circle-power","hourglass","tickets-plane","folder-git","bomb","layers-2","battery-full","user-minus","chart-gantt","folder-tree","command","badge-dollar-sign","align-start-vertical","briefcase-conveyor-belt","message-circle-question-mark","bluetooth-off","square-square","cannabis","book","grip-horizontal","circle-minus","audio-waveform","moon-star","arrow-down-narrow-wide","database-backup","wand","receipt-turkish-lira","calendar-minus-2","copy-minus","folder-input","book-image","mouse-left","shirt","server-off","move-up","plug-2","chess-rook","brackets","calendar-heart","list-ordered","mic-off","arrow-big-left","square-split-horizontal","clover","sun-snow","sofa","funnel-x","clock-2","calendar-fold","fish-off","baby","leaf","fold-vertical","hop","paperclip","cigarette","minus","smile-plus","diamond-plus","file-chart-column","triangle-dashed","git-pull-request-closed","badge-check","plug-zap","heading-4","chess-queen","graduation-cap","grid-3x2","zodiac-sagittarius","square-dashed-bottom-code","clock-7","ethernet-port","scan-text","shower-head","equal-not","move-down","clock-arrow-down","ticket-slash","ruler","circle-user-round","list-filter","map-pin-check","egg-off","cog","dog","swords","spotlight","panel-right-dashed","truck-electric","check-line","bubbles","bot","chart-bar-increasing","trash-2","air-vent","dot","file-symlink","clipboard-paste","chevron-last","book-heart","circle-parking","cloud-check","panel-left","circle-chevron-right","squares-unite","arrow-down-up","git-fork","forward","brain-circuit","between-vertical-start","database","panel-right","log-out","git-branch-plus","clipboard-minus","file-text","table-rows-split","milk-off","tv-minimal","cloud-upload","banknote","drumstick","calendar-search","bell-ring","circle-chevron-left","arrow-down","arrow-up-down","folder-dot","whole-word","monitor","disc-2","trending-up-down","tv-minimal-play","circle-stop","align-vertical-space-around","arrow-big-down","circle-parking-off","calendar-x-2","user-plus","move-diagonal-2","bandage","gallery-horizontal-end","panel-top-dashed","zoom-out","zoom-in","tram-front","zodiac-virgo","podcast","locate","audio-lines","fingerprint-pattern","zodiac-pisces","upload","flip-vertical-2","rocket","zodiac-libra","ear-off","zodiac-leo","zodiac-gemini","star","text-cursor","printer","megaphone-off","zodiac-aries","arrow-big-right","section","file-clock","zodiac-aquarius","toy-brick","square-chevron-down","dice-1","drill","app-window","shield-check","hand-metal","send-horizontal","spell-check-2","x-line-top","square-dot","list-plus","worm","rotate-ccw-key","workflow","chart-pie","wine-off","wine","copy-slash","wind","wind-arrow-down","layout-panel-left","receipt-japanese-yen","circle-percent","wifi-sync","circle-arrow-out-down-right","square-x","italic","chart-column-increasing","stamp","step-forward","wifi-high","a-arrow-down","container","sticker","wifi","wheat-off","wheat","weight-tilde","weight","square-bottom-dashed-scissors","import","badge-turkish-lira","square-terminal","file-music","gamepad-directional","beef","route-off","file-user","webcam","square-radical","waypoints","image-upscale","book-type","smile","signpost-big","waves-vertical","cloudy","waves-ladder","square-percent","waves-horizontal","navigation-off","arrow-left","car-taxi-front","spade","waves-arrow-down","chevrons-right-left","watch","iteration-ccw","wand-sparkles","wallpaper","wallet-minimal","wallet-cards","wallet","square-pause","align-end-horizontal","vote","equal","megaphone","calendar-x","volume-off","sliders-vertical","egg","volume-1","volleyball","video","circle-pound-sterling","video-off","japanese-yen","text-cursor-input","vibrate","venus-and-mars","library","file-terminal","circle-chevron-down","accessibility","replace-all","square-library","amphora","chart-bar-stacked","tally-2","vault","badge-x","van","utility-pole","sheet","circle-check-big","utensils","users-round","map-pinned","corner-down-left","circuit-board","users","user-x","user-round-x","user-round-search","folder-open-dot","book-dashed","monitor-speaker","message-square-share","bluetooth","tree-pine","receipt-indian-rupee","user-round-cog","user-round-check","user-lock","user-key","stretch-horizontal","square-chart-gantt","flask-conical","user","funnel","square-star","folder-sync","maximize-2","zodiac-ophiuchus","unplug","square-user","arrow-up-narrow-wide","fishing-hook","unlink","university","ungroup","frame","calendar-arrow-down","clock-12","unfold-vertical","lasso","undo-2","images","lollipop","book-text","undo","lamp-floor","file-plus-corner","image","underline","badge-euro","bike","umbrella-off","type-outline","gauge","file-x","folder-search-2","turntable","turkish-lira","option","truck","scroll-text","table-of-contents","trophy","gift","triangle-alert","toggle-right","triangle","ferris-wheel","camera-off","trending-up","tree-deciduous","shield-cog","transgender","chevrons-down","group","train-front-tunnel","battery","move-down-left","tent-tree","traffic-cone","rectangle-horizontal","tractor","tower-control","package-search","bitcoin","touchpad-off","battery-plus","database-search","touchpad","file-diff","torus","tornado","tool-case","spline-pointer","toilet","axis-3d","toggle-left","timer-reset","binoculars","refresh-cw","timer","timeline","rose","ticket-x","mail-minus","syringe","calculator","panel-bottom","move-up-right","clipboard-pen","bottle-wine","alarm-clock-off","dices","list","thermometer-sun","square-arrow-right","thermometer-snowflake","badge-pound-sterling","bookmark-check","thermometer","theater","message-square-text","a-arrow-up","clock-check","text-quote","piano","vibrate-off","mail-check","zodiac-cancer","joystick","file-code","text-align-justify","chart-column-big","text-align-end","text-align-center","cassette-tape","battery-low","test-tubes","test-tube-diagonal","signpost","bug","calendar-arrow-up","landmark","fish-symbol","tent","loader","bold","dice-2","file-type","clipboard-clock","beer","lectern","telescope","book-plus","tangent","binary","move-diagonal","flashlight-off","door-closed","locate-fixed","layout-template","tally-3","power","tag","bookmark-off","hand-heart","tablets","scan-qr-code","message-square-check","tablet-smartphone","shield-half","table-properties","brain","table-columns-split","table-cells-merge","table-2","key","clock-11","table","ticket-plus","arrow-up-0-1","bell-electric","scan-face","heading","book-open-check","panel-top-close","lasso-select","switch-camera","swiss-franc","square-parking","sunset","bus","sun-medium","bed-single","chart-no-axes-gantt","file-spreadsheet","sun-dim","clipboard-list","signal-medium","contact-round","subscript","keyboard-off","stretch-vertical","file-badge","battery-warning","mail-question-mark","arrow-down-from-line","briefcase","biohazard","rectangle-circle","braces","scale-3d","panel-top-bottom-dashed","mail-x","square-dashed-mouse-pointer","user-cog","lock-open","mouse-off","pizza","list-indent-decrease","arrow-up-wide-narrow","stone","clock-5","sticky-note","rotate-ccw","align-horizontal-justify-center","stethoscope","antenna","memory-stick","scan-eye","step-back","square-check","heart-plus","star-off","map-pin-minus-inside","git-merge","gallery-vertical-end","shield-off","hand-coins","zodiac-capricorn","wifi-low","squirrel","clock","file-pen","git-compare-arrows","cloud-sun-rain","align-horizontal-justify-start","folder-lock","squircle","roller-coaster","calendar-plus","shield-user","arrow-down-z-a","bath","squares-exclude","unlink-2","notepad-text-dashed","square-stack","folder-check","square-split-vertical","book-key","ribbon","microwave","square-slash","gallery-vertical","square-sigma","square-scissors","square-dashed-text","map-pin-pen","move-up-left","square-round-corner","folder-heart","line-squiggle","square-plus","square-play","arrow-up-a-z","square-pilcrow","square-dashed-top-solid","square-pi","navigation-2","lock-keyhole","swatch-book","receipt-cent","spool","folder-archive","folder-symlink","columns-3","ban","message-square-x","paint-roller","router","archive","square-m","square-kanban","building-2","circle-slash-2","bell-off","cake","cloud-rain","chart-bar","square-equal","wrench","square-divide","square-dashed-bottom","square-code","flag-triangle-right","square-chevron-up","quote","bell","square-chevron-left","search-x","music-3","chart-bar-big","user-check","proportions","square-centerline-dashed-vertical","plane","webhook-off","carrot","square-arrow-left","file-cog","circle-dashed","square-asterisk","square-arrow-up-right","sliders-horizontal","mailbox","squares-subtract","square-arrow-right-exit","square-arrow-right-enter","split","square-arrow-out-up-right","square-arrow-out-up-left","forklift","panda","alarm-clock-minus","heart-x","eraser","book-marked","square-arrow-out-down-left","bluetooth-connected","rotate-ccw-square","chart-no-axes-column","cannabis-off","folder-kanban","square-arrow-down-right","mars-stroke","grid-2x2","panel-left-open","square","file-box","sprout","paint-bucket","glass-water","spray-can","glasses","piggy-bank","sport-shoe","cuboid","cloud-off","check-check","activity","axe","plane-takeoff","repeat-off","cloud-rain-wind","speech","speaker","copy-x","file-axis-3d","radical","chart-column-decreasing","sparkles","bug-play","align-vertical-distribute-start","sparkle","waves-arrow-up","tally-5","soup","solar-panel","soap-dispenser-droplet","circle-divide","snowflake","snail","smartphone-nfc","life-buoy","circle-alert","smartphone","volume-2","battery-charging","russian-ruble","square-arrow-up-left","brick-wall-shield","footprints","monitor-stop","building","microscope","skull","siren","signature","book-alert","link-2","astroid","bell-minus","image-up","closed-caption","drum","arrow-up-z-a","sun","signal-low","message-square-diff","file-key","sigma","computer","scissors-line-dashed","file-braces","shrimp","house-plug","ticket-check","combine","popsicle","shopping-bag","mountain","mars","picture-in-picture-2","radio-off","flower-2","ship-wheel","squares-intersect","shield-question-mark","shield-plus","keyboard-music","star-half","heading-3","code-xml","pencil-line","mails","brain-cog","tablet","shield-cog-corner","pi","trash","book-down","hdmi-port","shield-ban","case-upper","circle-fading-arrow-up","shield","croissant","shelving-unit","shell","barcode","globe-x","share","bed","shapes","divide","grape","settings-2","party-popper","file-chart-pie","settings","server-crash","dice-6","server-cog","calendar-range","server","zap-off","square-check-big","search-slash","search-code","external-link","laptop-minimal","search-alert","search","map-pin-minus","scroll","chart-spline","message-square-more","screen-share-off","chart-candlestick","screen-share","arrow-down-a-z","lock-keyhole-open","school","move-horizontal","file-sliders","frown","scan-search","cup-soda","rotate-3d","notepad-text","sword","scan-barcode","scan","earth","slice","dice-3","milk","mouse-pointer-ban","crown","circle-slash","circle-star","rotate-cw-square","atom","package-x","bed-double","save-off","circle-dot","file-exclamation-point","hand-fist","message-circle-code","folder-git-2","message-square-code","info","towel-rack","saudi-riyal","arrow-big-left-dash","satellite-dish","dumbbell","sandwich","salad","sailboat","scale","file-stack","flashlight","panel-top-open","rows-4","rows-3","notebook","redo-2","rows-2","square-menu","route","monitor-smartphone","laptop","scan-line","clock-4","square-arrow-up","book-minus","file-question-mark","panels-left-bottom","rewind","list-video","arrow-down-to-line","reply","refresh-ccw","venetian-mask","calendar-check-2","replace","spline","banknote-x","git-pull-request-create-arrow","repeat-2","circle-check","repeat-1","repeat","remove-formatting","regex","refrigerator","refresh-cw-off","timer-off","arrow-big-right-dash","copyright","redo","clapperboard","backpack","rectangle-vertical","rectangle-goggles","haze","receipt-swiss-franc","receipt-russian-ruble","arrow-down-right","maximize","receipt","wifi-zero","receipt-euro","ratio","rainbow","plus","image-off","radio-receiver","radio","radiation","radar","square-chevron-right","mail-search","pyramid","puzzle","projector","list-music","printer-check","power-off","tally-1","ampersand","pound-sterling","shopping-cart","align-vertical-justify-end","folder-up","alarm-smoke","cloud-sync","file-input","clock-8","hand-grab","cloud-cog","blend","hd","radio-tower","list-tree","droplet","plug","eye","play","plane-landing","banana","gpu","pin-off","currency","circle-equal","pill","monitor-off","pilcrow-left","pickaxe","text-initial","arrow-up-right","circle-arrow-out-down-left","leafy-green","message-square-dot","file-chart-line","columns-3-cog","phone-off","phone-incoming","minimize-2","phone-forwarded","phone","cone","hammer","file-image","percent","palette","barrel","gallery-thumbnails","pentagon","cpu","pencil-off","thumbs-down","merge","hamburger","pen-off","hat-glasses","code","pen-line","heart-pulse","pc-case","nut","file-video-camera","calendar-minus","kanban","bone","apple","rocking-chair","bot-off","panel-top","panel-right-open","panel-right-close","circle-arrow-out-up-left","panel-left-right-dashed","cable-car","arrow-down-left","square-activity","panel-left-dashed","cigarette-off","monitor-play","message-circle","circle-arrow-out-up-right","house-heart","panel-bottom-close","fold-horizontal","shovel","calendar-1","cloud-moon","square-arrow-out-down-right","paintbrush-vertical","clock-plus","save","cloud-snow","anvil","arrow-big-up-dash","package-plus","package-open","diff","package-2","package","orbit","chevrons-down-up","clipboard-plus","circle-x","list-end","omega","circle-ellipsis","chevrons-right","octagon-pause","message-square-reply","corner-down-right","octagon-minus","file-minus-corner","lamp-wall-down","nut-off","paw-print","ellipsis-vertical","globe-off","square-stop","arrow-up-1-0","align-horizontal-justify-end","scan-heart","align-vertical-distribute-end","heart-crack","airplay","lock","map-pin-x-inside","newspaper","monitor-x","bell-check","network","square-pen","navigation","music-2","dice-5","octagon","ticket","move-right","move-down-right","train-front","bookmark","move-3d","album","milestone","chart-bar-decreasing","mouse-pointer","calendar-sync","funnel-plus","store","circle-arrow-down","notebook-pen","egg-fried","circle-play","moon","corner-right-up","monitor-up","ruler-dimension-line","user-round-plus","panel-left-close","monitor-pause","pilcrow-right","user-round-minus","monitor-dot","monitor-cog","mail-plus","monitor-check","map-pin","map-pin-x","mouse-pointer-2-off","drone","slash","mic-vocal","aperture","arrow-right-left","mic","vector-square","circle-gauge","message-square-warning","check","text-search","arrow-down-to-dot","monitor-down","message-square-plus","chef-hat","message-square-lock","message-square-heart","file-archive","signal-high","inbox","flip-horizontal-2","clock-9","image-play","align-horizontal-space-between","message-circle-off","calendar-check","database-zap","droplets","message-circle-heart","message-circle-dashed","message-circle-check","layout-list","file-search","meh","alarm-clock-plus","circle-dollar-sign","usb","house","receipt-pound-sterling","lamp","list-checks","id-card","mouse","minimize","helicopter","map-pin-plus","disc","brick-wall","book-x","mirror-rectangular","layout-grid","bird","mail","headphone-off","asterisk","magnet","octagon-x","languages","logs","alarm-clock-check","guitar","log-in","beer-off","scooter","square-parking-off","notebook-text","arrow-right-to-line","ticket-minus","tally-4","zodiac-taurus","loader-pinwheel","door-open","flag-triangle-left","grid-3x3","file","loader-circle","pocket-knife","book-copy","castle","car-front","clock-alert","reply-all","cloud-moon-rain","clipboard-type","land-plot","list-todo","printer-x","list-indent-increase","list-start","list-collapse","a-large-small","list-chevrons-up-down","list-chevrons-down-up","map-plus","list-check","link-2-off","link","line-style","arrow-right-from-line","flame-kindling","square-power","line-dot-right-horizontal","bring-to-front","candy","lightbulb","bell-plus","ligature","library-big","layout-panel-top","folders","mail-warning","layout-dashboard","layers","laugh","chevrons-left-right","chart-line","file-lock","cast","circle-fading-plus","clock-10","undo-dot","target","list-filter-plus","lamp-wall-up","drama","lamp-ceiling","baseline","martini","contrast","keyboard","candy-off","key-square","book-check","film","book-lock","kayak","briefcase-medical","calendars","text-align-start","iteration-cw","hop-off","warehouse","inspection-panel","drafting-compass","save-all","infinity","indian-rupee","image-plus","image-minus","id-card-lanyard","fishing-rod","book-headphones","credit-card","ice-cream-cone","ice-cream-bowl","house-wifi","shredder","panel-bottom-open","hotel","hospital","highlighter","balloon","map-pin-plus-inside","bookmark-x","badge-question-mark","pen","heart-off","candy-cane","heart-minus","heart","gamepad-2","headset","file-x-corner","heading-6","heading-5","shield-minus","circle-off","dessert","eclipse","church","heading-2","cylinder","badge-japanese-yen","heading-1","receipt-text","hard-hat","hard-drive-upload","hard-drive-download","file-minus","file-output","disc-album","handbag","arrow-down-0-1","captions","hand-platter","hand","philippine-peso","badge-alert","grip","folder-pen","cross","folder","chevron-right","grid-2x2-check","square-arrow-down-left","share-2","git-pull-request-draft","git-pull-request-create","cookie","folder-minus","git-merge-conflict","git-compare","chess-pawn","git-commit-vertical","briefcase-business","git-commit-horizontal","message-circle-reply","git-branch","triangle-right","folder-clock","ghost","gem","type","webhook","gamepad","align-horizontal-distribute-start","fullscreen","fuel","pointer-off","turtle","camera","folder-root","folder-open","git-pull-request","bluetooth-searching","arrow-up-to-line","squircle-dashed","clock-3","badge-percent","shuffle","folder-cog","folder-closed","grid-2x2-plus","flower","box","flask-round","clock-1","file-heart","flask-conical-off","space","flag-off","fish","fire-extinguisher","corner-up-left","clock-6","zodiac-scorpio","key-round","headphones","tv","file-up","file-type-corner","rss","file-search-corner","at-sign","map-pin-check-inside","file-play","music","handshake","file-digit","circle-user","copy-plus","file-check","file-chart-column-increasing","shrink","fan","factory","search-check","clipboard-check","columns-2","expand","euro","align-center-vertical","equal-approximately","earth-lock","droplet-off","cloud-fog","coins","dock","map-pin-house","package-check","chevron-first","pencil","diamond-minus","list-x","diameter","delete","corner-up-right","construction","pin","crosshair","crop","badge-indian-rupee","corner-right-down","redo-dot","copyleft","align-start-horizontal","chart-column-stacked","file-plus","git-pull-request-arrow","contact","decimals-arrow-right","bell-dot","folder-down","component","compass","align-horizontal-space-around","door-closed-locked","club","diamond","blinds","cloud-drizzle","cloud-backup","book-search","git-branch-minus","clipboard","recycle","mountain-snow","luggage","circle-arrow-right","bot-message-square","phone-outgoing","smartphone-charging","chevrons-left-right-ellipsis","train-track","chevron-left","chess-bishop","cherry","chart-network","chart-no-axes-column-increasing","chart-no-axes-column-decreasing","chart-no-axes-combined","metronome","case-sensitive","arrow-down-1-0","case-lower","caravan","arrow-left-right","lightbulb-off","panels-top-left","beef-off","locate-off","annoyed","test-tube","brick-wall-fire","cooking-pot","boxes","boom-box","book-up","laptop-minimal-check","mail-open","square-function","baggage-claim","variable","arrow-right","archive-restore"},{[48]={{1,{24,24},{175,0}},{1,{24,24},{400,225}},{1,{24,24},{800,250}},{1,{24,24},{800,800}},{1,{24,24},{550,375}},{1,{24,24},{650,150}},{1,{24,24},{400,875}},{2,{24,24},{100,75}},{1,{24,24},{125,275}},{1,{24,24},{425,250}},{1,{24,24},{775,125}},{1,{24,24},{150,300}},{1,{24,24},{450,525}},{1,{24,24},{325,500}},{1,{24,24},{50,75}},{1,{24,24},{550,400}},{1,{24,24},{525,700}},{1,{24,24},{975,250}},{1,{24,24},{350,25}},{1,{24,24},{175,250}},{1,{24,24},{150,675}},{1,{24,24},{425,875}},{1,{24,24},{150,825}},{1,{24,24},{125,400}},{1,{24,24},{650,725}},{1,{24,24},{125,300}},{1,{24,24},{925,25}},{1,{24,24},{925,700}},{1,{24,24},{625,125}},{1,{24,24},{425,75}},{1,{24,24},{675,175}},{1,{24,24},{650,575}},{1,{24,24},{325,775}},{1,{24,24},{900,450}},{1,{24,24},{0,825}},{1,{24,24},{925,300}},{1,{24,24},{100,100}},{1,{24,24},{275,675}},{1,{24,24},{675,975}},{1,{24,24},{400,50}},{2,{24,24},{125,150}},{1,{24,24},{25,675}},{1,{24,24},{350,750}},{1,{24,24},{675,50}},{1,{24,24},{375,525}},{1,{24,24},{25,550}},{1,{24,24},{825,300}},{2,{24,24},{0,100}},{1,{24,24},{850,400}},{1,{24,24},{150,275}},{1,{24,24},{75,550}},{1,{24,24},{300,225}},{1,{24,24},{950,150}},{1,{24,24},{600,600}},{1,{24,24},{50,425}},{1,{24,24},{300,575}},{1,{24,24},{50,575}},{1,{24,24},{925,575}},{1,{24,24},{675,825}},{1,{24,24},{625,950}},{1,{24,24},{575,825}},{2,{24,24},{200,75}},{1,{24,24},{400,575}},{1,{24,24},{500,650}},{1,{24,24},{450,375}},{1,{24,24},{225,100}},{1,{24,24},{800,50}},{1,{24,24},{825,650}},{1,{24,24},{675,525}},{1,{24,24},{550,775}},{1,{24,24},{25,925}},{1,{24,24},{75,200}},{1,{24,24},{400,975}},{1,{24,24},{775,900}},{1,{24,24},{400,150}},{2,{24,24},{125,175}},{1,{24,24},{325,825}},{2,{24,24},{150,50}},{1,{24,24},{700,550}},{1,{24,24},{775,975}},{1,{24,24},{275,100}},{1,{24,24},{400,175}},{1,{24,24},{100,75}},{1,{24,24},{400,400}},{1,{24,24},{150,975}},{1,{24,24},{525,500}},{1,{24,24},{50,825}},{1,{24,24},{225,550}},{1,{24,24},{125,125}},{2,{24,24},{25,175}},{1,{24,24},{200,925}},{1,{24,24},{725,450}},{1,{24,24},{75,875}},{1,{24,24},{675,275}},{1,{24,24},{650,525}},{1,{24,24},{300,425}},{1,{24,24},{425,800}},{1,{24,24},{150,600}},{1,{24,24},{275,75}},{1,{24,24},{575,150}},{2,{24,24},{100,0}},{1,{24,24},{25,250}},{1,{24,24},{200,275}},{1,{24,24},{775,350}},{1,{24,24},{575,625}},{1,{24,24},{50,525}},{1,{24,24},{625,350}},{1,{24,24},{500,275}},{1,{24,24},{950,825}},{1,{24,24},{450,500}},{1,{24,24},{600,75}},{1,{24,24},{525,100}},{1,{24,24},{150,250}},{1,{24,24},{925,350}},{1,{24,24},{500,850}},{1,{24,24},{200,0}},{1,{24,24},{600,800}},{1,{24,24},{150,525}},{1,{24,24},{850,375}},{1,{24,24},{225,325}},{1,{24,24},{325,275}},{1,{24,24},{275,125}},{1,{24,24},{700,800}},{1,{24,24},{375,400}},{1,{24,24},{425,475}},{1,{24,24},{200,875}},{1,{24,24},{975,25}},{1,{24,24},{650,975}},{1,{24,24},{75,125}},{1,{24,24},{175,475}},{1,{24,24},{325,750}},{1,{24,24},{25,500}},{1,{24,24},{225,700}},{1,{24,24},{50,175}},{1,{24,24},{925,775}},{1,{24,24},{500,750}},{1,{24,24},{275,475}},{1,{24,24},{825,125}},{1,{24,24},{925,850}},{1,{24,24},{775,0}},{1,{24,24},{550,275}},{2,{24,24},{100,25}},{1,{24,24},{675,625}},{1,{24,24},{350,800}},{1,{24,24},{0,100}},{1,{24,24},{300,275}},{1,{24,24},{275,875}},{1,{24,24},{100,700}},{2,{24,24},{200,0}},{1,{24,24},{750,825}},{1,{24,24},{75,525}},{1,{24,24},{975,750}},{1,{24,24},{25,525}},{1,{24,24},{375,175}},{1,{24,24},{750,175}},{1,{24,24},{575,125}},{1,{24,24},{175,300}},{1,{24,24},{550,125}},{1,{24,24},{600,675}},{1,{24,24},{50,300}},{1,{24,24},{150,200}},{1,{24,24},{625,225}},{1,{24,24},{175,325}},{1,{24,24},{675,25}},{2,{24,24},{25,50}},{1,{24,24},{300,600}},{2,{24,24},{150,0}},{1,{24,24},{250,75}},{1,{24,24},{100,200}},{1,{24,24},{50,125}},{1,{24,24},{850,175}},{1,{24,24},{525,675}},{1,{24,24},{750,650}},{1,{24,24},{350,525}},{1,{24,24},{75,350}},{1,{24,24},{25,100}},{1,{24,24},{525,275}},{1,{24,24},{200,350}},{1,{24,24},{650,500}},{1,{24,24},{375,475}},{1,{24,24},{375,0}},{1,{24,24},{975,300}},{1,{24,24},{550,675}},{1,{24,24},{125,625}},{1,{24,24},{500,425}},{1,{24,24},{50,475}},{1,{24,24},{0,475}},{1,{24,24},{650,800}},{1,{24,24},{500,175}},{2,{24,24},{175,25}},{1,{24,24},{0,575}},{1,{24,24},{575,75}},{2,{24,24},{0,200}},{1,{24,24},{925,250}},{1,{24,24},{325,850}},{1,{24,24},{75,375}},{1,{24,24},{75,50}},{1,{24,24},{850,825}},{1,{24,24},{850,100}},{1,{24,24},{450,800}},{1,{24,24},{825,200}},{1,{24,24},{125,250}},{1,{24,24},{550,550}},{1,{24,24},{75,700}},{1,{24,24},{800,300}},{1,{24,24},{175,725}},{1,{24,24},{825,275}},{1,{24,24},{475,600}},{1,{24,24},{625,525}},{1,{24,24},{50,250}},{1,{24,24},{50,275}},{1,{24,24},{150,125}},{1,{24,24},{975,900}},{1,{24,24},{550,475}},{1,{24,24},{400,725}},{1,{24,24},{550,600}},{1,{24,24},{475,900}},{1,{24,24},{750,125}},{1,{24,24},{750,50}},{1,{24,24},{150,700}},{1,{24,24},{0,725}},{1,{24,24},{100,125}},{1,{24,24},{525,950}},{1,{24,24},{250,875}},{1,{24,24},{175,525}},{1,{24,24},{125,575}},{2,{24,24},{175,0}},{1,{24,24},{900,200}},{1,{24,24},{350,475}},{2,{24,24},{25,25}},{1,{24,24},{500,125}},{2,{24,24},{100,175}},{1,{24,24},{650,225}},{1,{24,24},{550,800}},{1,{24,24},{75,25}},{1,{24,24},{925,475}},{1,{24,24},{525,825}},{1,{24,24},{325,200}},{1,{24,24},{450,950}},{1,{24,24},{25,425}},{1,{24,24},{225,625}},{1,{24,24},{700,400}},{1,{24,24},{150,475}},{1,{24,24},{975,875}},{1,{24,24},{425,975}},{1,{24,24},{50,625}},{1,{24,24},{725,350}},{1,{24,24},{75,225}},{1,{24,24},{275,375}},{1,{24,24},{350,325}},{1,{24,24},{0,175}},{1,{24,24},{250,750}},{1,{24,24},{425,225}},{2,{24,24},{75,225}},{1,{24,24},{175,225}},{1,{24,24},{425,750}},{1,{24,24},{775,375}},{1,{24,24},{275,350}},{1,{24,24},{400,800}},{1,{24,24},{50,850}},{1,{24,24},{300,900}},{1,{24,24},{625,175}},{1,{24,24},{25,200}},{1,{24,24},{600,0}},{1,{24,24},{250,275}},{1,{24,24},{250,325}},{1,{24,24},{625,450}},{1,{24,24},{775,50}},{1,{24,24},{950,500}},{1,{24,24},{825,425}},{1,{24,24},{300,150}},{2,{24,24},{25,200}},{1,{24,24},{200,900}},{1,{24,24},{100,250}},{1,{24,24},{375,350}},{1,{24,24},{200,475}},{1,{24,24},{775,600}},{1,{24,24},{875,200}},{1,{24,24},{475,875}},{1,{24,24},{150,50}},{2,{24,24},{125,0}},{1,{24,24},{300,525}},{1,{24,24},{575,950}},{1,{24,24},{675,900}},{1,{24,24},{850,725}},{1,{24,24},{350,200}},{1,{24,24},{875,25}},{1,{24,24},{100,275}},{1,{24,24},{550,250}},{1,{24,24},{500,600}},{1,{24,24},{900,150}},{1,{24,24},{600,125}},{1,{24,24},{475,350}},{1,{24,24},{200,25}},{1,{24,24},{725,100}},{1,{24,24},{400,350}},{1,{24,24},{350,625}},{1,{24,24},{725,600}},{1,{24,24},{375,125}},{1,{24,24},{550,350}},{1,{24,24},{150,575}},{1,{24,24},{450,225}},{1,{24,24},{225,750}},{1,{24,24},{950,750}},{1,{24,24},{650,250}},{1,{24,24},{125,325}},{1,{24,24},{875,150}},{1,{24,24},{325,75}},{2,{24,24},{50,0}},{1,{24,24},{300,300}},{1,{24,24},{225,675}},{1,{24,24},{725,25}},{1,{24,24},{225,125}},{1,{24,24},{0,150}},{1,{24,24},{425,100}},{1,{24,24},{875,225}},{1,{24,24},{250,200}},{1,{24,24},{700,825}},{1,{24,24},{425,150}},{1,{24,24},{475,25}},{1,{24,24},{575,375}},{1,{24,24},{0,650}},{1,{24,24},{75,250}},{1,{24,24},{450,675}},{1,{24,24},{275,0}},{1,{24,24},{475,300}},{2,{24,24},{75,150}},{1,{24,24},{675,600}},{1,{24,24},{275,275}},{1,{24,24},{375,375}},{1,{24,24},{600,300}},{1,{24,24},{350,125}},{1,{24,24},{325,800}},{1,{24,24},{975,425}},{1,{24,24},{400,950}},{1,{24,24},{675,475}},{1,{24,24},{275,950}},{1,{24,24},{425,200}},{1,{24,24},{75,425}},{1,{24,24},{300,250}},{1,{24,24},{850,200}},{1,{24,24},{275,825}},{1,{24,24},{225,25}},{1,{24,24},{750,775}},{1,{24,24},{250,475}},{1,{24,24},{725,850}},{1,{24,24},{650,775}},{1,{24,24},{825,100}},{1,{24,24},{425,275}},{1,{24,24},{325,225}},{1,{24,24},{550,325}},{1,{24,24},{350,0}},{1,{24,24},{625,400}},{1,{24,24},{0,875}},{1,{24,24},{300,675}},{1,{24,24},{625,575}},{1,{24,24},{650,0}},{1,{24,24},{875,250}},{1,{24,24},{775,650}},{1,{24,24},{200,575}},{1,{24,24},{75,750}},{1,{24,24},{825,950}},{1,{24,24},{125,800}},{1,{24,24},{250,100}},{1,{24,24},{250,975}},{1,{24,24},{825,150}},{1,{24,24},{450,175}},{1,{24,24},{775,175}},{1,{24,24},{625,325}},{2,{24,24},{175,150}},{1,{24,24},{575,900}},{1,{24,24},{300,400}},{1,{24,24},{600,225}},{1,{24,24},{350,975}},{1,{24,24},{850,550}},{1,{24,24},{675,150}},{1,{24,24},{825,325}},{1,{24,24},{200,500}},{1,{24,24},{725,950}},{1,{24,24},{875,450}},{1,{24,24},{275,400}},{1,{24,24},{975,75}},{1,{24,24},{825,250}},{1,{24,24},{825,0}},{1,{24,24},{125,600}},{1,{24,24},{575,225}},{1,{24,24},{900,700}},{1,{24,24},{800,650}},{1,{24,24},{900,300}},{1,{24,24},{925,875}},{1,{24,24},{0,600}},{1,{24,24},{275,250}},{1,{24,24},{225,275}},{1,{24,24},{525,75}},{1,{24,24},{850,900}},{1,{24,24},{0,50}},{1,{24,24},{425,375}},{1,{24,24},{50,800}},{1,{24,24},{700,0}},{1,{24,24},{350,275}},{1,{24,24},{375,100}},{1,{24,24},{625,50}},{1,{24,24},{725,0}},{1,{24,24},{950,250}},{1,{24,24},{300,350}},{1,{24,24},{850,700}},{1,{24,24},{175,100}},{1,{24,24},{250,675}},{1,{24,24},{25,875}},{1,{24,24},{50,450}},{1,{24,24},{100,325}},{1,{24,24},{400,375}},{1,{24,24},{850,350}},{1,{24,24},{350,700}},{1,{24,24},{400,525}},{1,{24,24},{0,675}},{1,{24,24},{0,850}},{1,{24,24},{700,900}},{1,{24,24},{975,150}},{1,{24,24},{950,875}},{1,{24,24},{325,400}},{1,{24,24},{50,325}},{1,{24,24},{175,625}},{1,{24,24},{125,425}},{1,{24,24},{225,200}},{1,{24,24},{325,325}},{1,{24,24},{100,175}},{1,{24,24},{125,175}},{1,{24,24},{725,175}},{2,{24,24},{225,50}},{1,{24,24},{475,650}},{1,{24,24},{775,25}},{1,{24,24},{900,875}},{1,{24,24},{975,850}},{1,{24,24},{300,375}},{1,{24,24},{25,150}},{1,{24,24},{0,225}},{1,{24,24},{650,25}},{1,{24,24},{75,475}},{2,{24,24},{0,50}},{1,{24,24},{925,225}},{1,{24,24},{150,225}},{1,{24,24},{775,150}},{1,{24,24},{775,425}},{2,{24,24},{50,275}},{2,{24,24},{75,250}},{1,{24,24},{900,850}},{2,{24,24},{100,225}},{1,{24,24},{900,350}},{1,{24,24},{500,550}},{1,{24,24},{100,225}},{1,{24,24},{600,275}},{2,{24,24},{200,125}},{1,{24,24},{975,950}},{1,{24,24},{125,750}},{1,{24,24},{650,650}},{2,{24,24},{250,75}},{1,{24,24},{125,675}},{2,{24,24},{275,50}},{2,{24,24},{300,25}},{1,{24,24},{675,875}},{1,{24,24},{775,875}},{1,{24,24},{625,625}},{1,{24,24},{300,775}},{2,{24,24},{25,275}},{1,{24,24},{175,75}},{1,{24,24},{600,750}},{1,{24,24},{825,25}},{2,{24,24},{50,250}},{1,{24,24},{800,925}},{1,{24,24},{700,775}},{1,{24,24},{150,625}},{1,{24,24},{325,475}},{1,{24,24},{175,50}},{1,{24,24},{725,650}},{1,{24,24},{250,700}},{1,{24,24},{575,775}},{1,{24,24},{975,475}},{2,{24,24},{150,150}},{1,{24,24},{875,625}},{1,{24,24},{825,225}},{2,{24,24},{200,100}},{1,{24,24},{525,775}},{2,{24,24},{225,75}},{1,{24,24},{100,500}},{2,{24,24},{275,25}},{2,{24,24},{250,50}},{1,{24,24},{325,425}},{2,{24,24},{300,0}},{2,{24,24},{0,275}},{1,{24,24},{700,325}},{1,{24,24},{800,475}},{1,{24,24},{575,100}},{2,{24,24},{75,200}},{1,{24,24},{525,125}},{1,{24,24},{975,575}},{1,{24,24},{600,400}},{1,{24,24},{375,225}},{1,{24,24},{750,800}},{1,{24,24},{625,925}},{2,{24,24},{175,100}},{1,{24,24},{0,0}},{1,{24,24},{500,250}},{1,{24,24},{575,975}},{2,{24,24},{25,250}},{2,{24,24},{275,0}},{2,{24,24},{250,25}},{2,{24,24},{25,225}},{2,{24,24},{0,250}},{1,{24,24},{850,625}},{1,{24,24},{750,250}},{1,{24,24},{325,50}},{1,{24,24},{600,925}},{1,{24,24},{425,425}},{1,{24,24},{625,300}},{1,{24,24},{0,400}},{1,{24,24},{400,900}},{1,{24,24},{800,75}},{2,{24,24},{100,150}},{1,{24,24},{875,650}},{2,{24,24},{125,125}},{1,{24,24},{825,175}},{1,{24,24},{75,400}},{1,{24,24},{750,675}},{1,{24,24},{525,875}},{2,{24,24},{150,100}},{1,{24,24},{275,450}},{2,{24,24},{175,75}},{1,{24,24},{550,950}},{2,{24,24},{200,50}},{1,{24,24},{450,700}},{1,{24,24},{0,275}},{1,{24,24},{325,250}},{1,{24,24},{550,875}},{2,{24,24},{250,0}},{1,{24,24},{125,500}},{2,{24,24},{0,225}},{1,{24,24},{575,425}},{2,{24,24},{100,125}},{2,{24,24},{125,100}},{2,{24,24},{175,50}},{2,{24,24},{200,25}},{2,{24,24},{150,75}},{1,{24,24},{600,900}},{1,{24,24},{100,25}},{2,{24,24},{225,0}},{1,{24,24},{650,175}},{1,{24,24},{275,800}},{1,{24,24},{50,500}},{2,{24,24},{50,150}},{1,{24,24},{875,550}},{1,{24,24},{800,25}},{2,{24,24},{100,100}},{2,{24,24},{125,75}},{2,{24,24},{0,175}},{1,{24,24},{475,200}},{2,{24,24},{25,150}},{1,{24,24},{525,475}},{1,{24,24},{800,850}},{2,{24,24},{50,125}},{2,{24,24},{125,50}},{1,{24,24},{475,550}},{1,{24,24},{25,825}},{1,{24,24},{350,300}},{1,{24,24},{50,0}},{1,{24,24},{825,475}},{1,{24,24},{775,725}},{1,{24,24},{125,75}},{1,{24,24},{500,100}},{1,{24,24},{875,750}},{2,{24,24},{25,125}},{1,{24,24},{300,75}},{2,{24,24},{75,75}},{2,{24,24},{100,50}},{1,{24,24},{850,525}},{1,{24,24},{400,250}},{2,{24,24},{125,25}},{2,{24,24},{25,100}},{1,{24,24},{525,550}},{1,{24,24},{200,550}},{1,{24,24},{175,500}},{2,{24,24},{0,125}},{2,{24,24},{75,50}},{2,{24,24},{25,75}},{2,{24,24},{50,50}},{1,{24,24},{475,425}},{1,{24,24},{450,25}},{1,{24,24},{575,550}},{1,{24,24},{450,650}},{1,{24,24},{200,250}},{1,{24,24},{975,800}},{1,{24,24},{825,450}},{2,{24,24},{50,25}},{2,{24,24},{75,0}},{2,{24,24},{0,25}},{2,{24,24},{25,0}},{1,{24,24},{900,675}},{1,{24,24},{775,700}},{1,{24,24},{200,675}},{2,{24,24},{50,75}},{1,{24,24},{800,125}},{1,{24,24},{650,875}},{1,{24,24},{250,650}},{1,{24,24},{375,700}},{2,{24,24},{225,100}},{1,{24,24},{925,975}},{1,{24,24},{550,975}},{1,{24,24},{25,275}},{1,{24,24},{475,400}},{1,{24,24},{950,950}},{1,{24,24},{900,975}},{1,{24,24},{925,950}},{1,{24,24},{0,900}},{1,{24,24},{500,50}},{1,{24,24},{450,250}},{1,{24,24},{950,925}},{1,{24,24},{925,100}},{1,{24,24},{925,925}},{1,{24,24},{775,225}},{1,{24,24},{300,750}},{1,{24,24},{100,375}},{1,{24,24},{875,975}},{1,{24,24},{225,775}},{1,{24,24},{300,550}},{1,{24,24},{800,200}},{1,{24,24},{950,900}},{1,{24,24},{200,150}},{1,{24,24},{50,375}},{1,{24,24},{850,975}},{1,{24,24},{900,925}},{1,{24,24},{575,350}},{1,{24,24},{700,175}},{1,{24,24},{325,575}},{1,{24,24},{850,950}},{1,{24,24},{875,925}},{1,{24,24},{775,400}},{1,{24,24},{900,900}},{1,{24,24},{800,550}},{1,{24,24},{750,850}},{1,{24,24},{950,850}},{1,{24,24},{450,475}},{1,{24,24},{850,925}},{1,{24,24},{775,925}},{1,{24,24},{975,825}},{1,{24,24},{275,550}},{1,{24,24},{575,0}},{1,{24,24},{875,900}},{1,{24,24},{800,950}},{1,{24,24},{675,700}},{1,{24,24},{875,875}},{1,{24,24},{225,400}},{1,{24,24},{500,450}},{1,{24,24},{975,775}},{1,{24,24},{200,200}},{1,{24,24},{875,275}},{1,{24,24},{700,925}},{1,{24,24},{750,975}},{1,{24,24},{550,725}},{1,{24,24},{775,950}},{1,{24,24},{825,900}},{1,{24,24},{575,600}},{1,{24,24},{375,75}},{1,{24,24},{900,825}},{1,{24,24},{250,150}},{1,{24,24},{450,325}},{1,{24,24},{875,850}},{1,{24,24},{725,125}},{1,{24,24},{925,800}},{1,{24,24},{950,775}},{1,{24,24},{725,975}},{1,{24,24},{925,525}},{1,{24,24},{750,950}},{1,{24,24},{0,325}},{1,{24,24},{800,900}},{1,{24,24},{850,850}},{1,{24,24},{0,425}},{1,{24,24},{325,950}},{1,{24,24},{825,875}},{1,{24,24},{900,800}},{1,{24,24},{575,725}},{1,{24,24},{700,975}},{1,{24,24},{200,850}},{1,{24,24},{875,725}},{1,{24,24},{550,0}},{1,{24,24},{275,900}},{1,{24,24},{700,450}},{1,{24,24},{650,50}},{1,{24,24},{200,300}},{1,{24,24},{0,75}},{1,{24,24},{0,775}},{1,{24,24},{650,400}},{1,{24,24},{925,750}},{1,{24,24},{975,500}},{1,{24,24},{950,725}},{1,{24,24},{25,325}},{1,{24,24},{450,50}},{1,{24,24},{900,775}},{1,{24,24},{975,700}},{1,{24,24},{425,675}},{1,{24,24},{25,0}},{1,{24,24},{150,550}},{1,{24,24},{725,925}},{1,{24,24},{725,500}},{2,{24,24},{75,100}},{1,{24,24},{225,825}},{2,{24,24},{0,300}},{1,{24,24},{500,500}},{1,{24,24},{775,75}},{1,{24,24},{850,800}},{1,{24,24},{425,175}},{1,{24,24},{875,775}},{1,{24,24},{900,750}},{1,{24,24},{125,450}},{1,{24,24},{300,100}},{1,{24,24},{925,725}},{1,{24,24},{975,675}},{1,{24,24},{500,900}},{1,{24,24},{200,325}},{1,{24,24},{475,75}},{1,{24,24},{100,900}},{1,{24,24},{525,350}},{1,{24,24},{675,950}},{1,{24,24},{575,475}},{1,{24,24},{175,275}},{1,{24,24},{125,650}},{1,{24,24},{850,25}},{1,{24,24},{75,600}},{1,{24,24},{400,25}},{1,{24,24},{575,450}},{1,{24,24},{725,900}},{1,{24,24},{150,325}},{1,{24,24},{775,850}},{1,{24,24},{25,400}},{1,{24,24},{900,250}},{1,{24,24},{275,600}},{1,{24,24},{475,325}},{1,{24,24},{550,500}},{1,{24,24},{650,375}},{1,{24,24},{850,775}},{1,{24,24},{725,525}},{1,{24,24},{950,675}},{1,{24,24},{400,100}},{1,{24,24},{300,650}},{1,{24,24},{975,650}},{1,{24,24},{400,925}},{1,{24,24},{750,350}},{1,{24,24},{650,950}},{1,{24,24},{625,750}},{1,{24,24},{725,875}},{1,{24,24},{0,500}},{1,{24,24},{775,825}},{1,{24,24},{825,775}},{1,{24,24},{850,750}},{1,{24,24},{375,625}},{1,{24,24},{475,225}},{1,{24,24},{675,925}},{1,{24,24},{750,925}},{1,{24,24},{200,100}},{1,{24,24},{325,100}},{1,{24,24},{475,850}},{1,{24,24},{750,225}},{1,{24,24},{225,250}},{1,{24,24},{800,400}},{1,{24,24},{950,75}},{1,{24,24},{950,650}},{1,{24,24},{975,625}},{1,{24,24},{625,875}},{1,{24,24},{650,925}},{1,{24,24},{100,425}},{1,{24,24},{775,800}},{1,{24,24},{75,325}},{1,{24,24},{125,475}},{1,{24,24},{100,750}},{1,{24,24},{800,775}},{1,{24,24},{25,650}},{1,{24,24},{625,775}},{1,{24,24},{550,200}},{1,{24,24},{825,750}},{1,{24,24},{325,675}},{1,{24,24},{875,700}},{1,{24,24},{200,625}},{1,{24,24},{225,175}},{1,{24,24},{125,925}},{1,{24,24},{25,225}},{1,{24,24},{375,150}},{1,{24,24},{450,0}},{1,{24,24},{625,650}},{1,{24,24},{100,400}},{1,{24,24},{600,725}},{1,{24,24},{825,375}},{1,{24,24},{975,100}},{1,{24,24},{500,975}},{2,{24,24},{0,0}},{1,{24,24},{425,625}},{1,{24,24},{300,825}},{1,{24,24},{400,825}},{1,{24,24},{950,100}},{1,{24,24},{300,25}},{1,{24,24},{950,625}},{1,{24,24},{350,350}},{1,{24,24},{975,600}},{1,{24,24},{475,825}},{1,{24,24},{150,0}},{1,{24,24},{600,950}},{1,{24,24},{25,175}},{1,{24,24},{225,850}},{1,{24,24},{500,825}},{1,{24,24},{650,900}},{1,{24,24},{725,750}},{1,{24,24},{550,425}},{1,{24,24},{700,850}},{1,{24,24},{775,300}},{1,{24,24},{175,750}},{1,{24,24},{700,225}},{1,{24,24},{575,800}},{1,{24,24},{375,575}},{2,{24,24},{325,0}},{2,{24,24},{150,125}},{1,{24,24},{775,775}},{1,{24,24},{75,625}},{1,{24,24},{350,500}},{1,{24,24},{300,625}},{1,{24,24},{400,325}},{1,{24,24},{100,50}},{1,{24,24},{525,375}},{1,{24,24},{800,750}},{1,{24,24},{600,700}},{1,{24,24},{175,375}},{1,{24,24},{500,875}},{1,{24,24},{125,150}},{1,{24,24},{375,25}},{1,{24,24},{925,625}},{1,{24,24},{975,925}},{1,{24,24},{200,950}},{1,{24,24},{675,850}},{1,{24,24},{850,50}},{1,{24,24},{725,800}},{1,{24,24},{325,150}},{1,{24,24},{700,600}},{1,{24,24},{150,950}},{1,{24,24},{775,750}},{1,{24,24},{675,250}},{1,{24,24},{800,725}},{1,{24,24},{825,700}},{1,{24,24},{975,525}},{1,{24,24},{700,375}},{1,{24,24},{725,425}},{1,{24,24},{850,675}},{1,{24,24},{625,275}},{1,{24,24},{325,700}},{1,{24,24},{925,600}},{1,{24,24},{950,575}},{1,{24,24},{150,150}},{1,{24,24},{975,550}},{1,{24,24},{950,550}},{1,{24,24},{525,975}},{1,{24,24},{475,675}},{1,{24,24},{450,600}},{1,{24,24},{600,975}},{1,{24,24},{875,400}},{1,{24,24},{850,600}},{1,{24,24},{900,0}},{1,{24,24},{275,625}},{1,{24,24},{25,700}},{1,{24,24},{200,175}},{1,{24,24},{375,725}},{1,{24,24},{475,700}},{1,{24,24},{350,950}},{1,{24,24},{75,150}},{1,{24,24},{750,750}},{1,{24,24},{800,700}},{1,{24,24},{175,350}},{1,{24,24},{400,275}},{1,{24,24},{275,150}},{1,{24,24},{0,525}},{1,{24,24},{450,275}},{1,{24,24},{475,125}},{1,{24,24},{850,650}},{2,{24,24},{175,125}},{1,{24,24},{900,600}},{1,{24,24},{550,925}},{1,{24,24},{600,875}},{1,{24,24},{375,500}},{1,{24,24},{625,850}},{1,{24,24},{475,775}},{1,{24,24},{200,225}},{1,{24,24},{675,800}},{1,{24,24},{650,700}},{1,{24,24},{575,575}},{1,{24,24},{575,25}},{1,{24,24},{975,975}},{1,{24,24},{575,675}},{1,{24,24},{800,675}},{1,{24,24},{325,900}},{2,{24,24},{75,175}},{1,{24,24},{225,350}},{1,{24,24},{625,825}},{1,{24,24},{750,100}},{1,{24,24},{250,400}},{1,{24,24},{875,600}},{1,{24,24},{925,550}},{1,{24,24},{900,525}},{1,{24,24},{925,150}},{1,{24,24},{875,675}},{1,{24,24},{475,975}},{1,{24,24},{500,950}},{1,{24,24},{875,575}},{1,{24,24},{525,925}},{1,{24,24},{550,900}},{1,{24,24},{75,825}},{1,{24,24},{375,800}},{1,{24,24},{25,50}},{1,{24,24},{500,475}},{1,{24,24},{625,200}},{1,{24,24},{275,200}},{1,{24,24},{600,850}},{1,{24,24},{275,175}},{1,{24,24},{500,800}},{1,{24,24},{175,425}},{1,{24,24},{450,125}},{1,{24,24},{575,325}},{1,{24,24},{675,775}},{1,{24,24},{450,625}},{1,{24,24},{650,300}},{1,{24,24},{200,975}},{1,{24,24},{950,600}},{1,{24,24},{175,650}},{1,{24,24},{750,700}},{1,{24,24},{500,675}},{1,{24,24},{0,925}},{1,{24,24},{775,675}},{1,{24,24},{950,0}},{1,{24,24},{625,600}},{1,{24,24},{825,625}},{1,{24,24},{600,175}},{1,{24,24},{500,225}},{1,{24,24},{25,575}},{1,{24,24},{25,25}},{1,{24,24},{25,300}},{1,{24,24},{350,875}},{1,{24,24},{875,425}},{1,{24,24},{475,250}},{1,{24,24},{450,975}},{1,{24,24},{475,950}},{1,{24,24},{300,450}},{1,{24,24},{225,600}},{1,{24,24},{375,875}},{1,{24,24},{400,200}},{1,{24,24},{500,925}},{1,{24,24},{225,300}},{1,{24,24},{125,50}},{1,{24,24},{525,900}},{2,{24,24},{225,25}},{1,{24,24},{800,825}},{1,{24,24},{600,825}},{1,{24,24},{625,800}},{1,{24,24},{675,750}},{1,{24,24},{225,425}},{1,{24,24},{700,725}},{1,{24,24},{725,700}},{1,{24,24},{825,600}},{1,{24,24},{450,575}},{1,{24,24},{625,25}},{1,{24,24},{800,625}},{2,{24,24},{75,125}},{1,{24,24},{350,50}},{1,{24,24},{850,475}},{1,{24,24},{950,525}},{1,{24,24},{500,25}},{1,{24,24},{100,800}},{1,{24,24},{550,575}},{1,{24,24},{150,375}},{1,{24,24},{175,925}},{1,{24,24},{975,450}},{1,{24,24},{475,925}},{1,{24,24},{550,850}},{1,{24,24},{50,400}},{1,{24,24},{250,775}},{1,{24,24},{175,150}},{1,{24,24},{300,125}},{1,{24,24},{850,150}},{1,{24,24},{50,650}},{1,{24,24},{200,600}},{1,{24,24},{275,50}},{1,{24,24},{700,875}},{1,{24,24},{650,750}},{1,{24,24},{675,425}},{1,{24,24},{525,325}},{1,{24,24},{700,700}},{1,{24,24},{650,100}},{1,{24,24},{925,425}},{1,{24,24},{125,700}},{1,{24,24},{800,600}},{1,{24,24},{175,800}},{1,{24,24},{825,850}},{1,{24,24},{750,0}},{1,{24,24},{800,450}},{1,{24,24},{950,450}},{1,{24,24},{350,775}},{1,{24,24},{425,650}},{1,{24,24},{675,550}},{1,{24,24},{350,900}},{1,{24,24},{100,775}},{1,{24,24},{425,950}},{1,{24,24},{900,650}},{1,{24,24},{525,850}},{1,{24,24},{550,825}},{1,{24,24},{350,650}},{1,{24,24},{725,825}},{1,{24,24},{850,125}},{1,{24,24},{200,525}},{1,{24,24},{350,850}},{1,{24,24},{900,175}},{1,{24,24},{25,475}},{1,{24,24},{625,975}},{1,{24,24},{700,675}},{1,{24,24},{750,475}},{1,{24,24},{825,925}},{1,{24,24},{425,50}},{1,{24,24},{925,50}},{1,{24,24},{750,625}},{1,{24,24},{150,425}},{1,{24,24},{75,575}},{1,{24,24},{450,925}},{1,{24,24},{725,50}},{1,{24,24},{800,575}},{1,{24,24},{825,550}},{1,{24,24},{25,350}},{1,{24,24},{875,75}},{1,{24,24},{875,500}},{1,{24,24},{50,350}},{1,{24,24},{925,450}},{1,{24,24},{675,125}},{1,{24,24},{750,200}},{1,{24,24},{975,400}},{1,{24,24},{550,650}},{1,{24,24},{25,800}},{1,{24,24},{950,425}},{1,{24,24},{425,925}},{1,{24,24},{25,750}},{1,{24,24},{450,900}},{1,{24,24},{150,400}},{1,{24,24},{375,975}},{2,{24,24},{100,200}},{1,{24,24},{750,725}},{1,{24,24},{675,675}},{1,{24,24},{700,650}},{1,{24,24},{500,325}},{1,{24,24},{25,975}},{1,{24,24},{750,600}},{1,{24,24},{625,725}},{1,{24,24},{750,325}},{1,{24,24},{775,575}},{1,{24,24},{50,550}},{1,{24,24},{575,525}},{1,{24,24},{850,500}},{1,{24,24},{450,150}},{1,{24,24},{825,525}},{1,{24,24},{50,200}},{1,{24,24},{475,575}},{1,{24,24},{950,400}},{1,{24,24},{800,350}},{1,{24,24},{125,725}},{1,{24,24},{925,0}},{1,{24,24},{375,950}},{1,{24,24},{575,200}},{1,{24,24},{550,750}},{1,{24,24},{175,975}},{1,{24,24},{925,675}},{1,{24,24},{525,800}},{1,{24,24},{975,375}},{1,{24,24},{50,750}},{1,{24,24},{925,500}},{1,{24,24},{100,675}},{1,{24,24},{950,175}},{1,{24,24},{225,900}},{1,{24,24},{625,150}},{1,{24,24},{375,300}},{1,{24,24},{325,350}},{1,{24,24},{450,850}},{1,{24,24},{125,200}},{1,{24,24},{550,625}},{1,{24,24},{100,300}},{1,{24,24},{650,675}},{1,{24,24},{150,500}},{1,{24,24},{650,200}},{1,{24,24},{350,600}},{1,{24,24},{125,950}},{1,{24,24},{675,225}},{1,{24,24},{725,375}},{1,{24,24},{650,350}},{1,{24,24},{850,875}},{1,{24,24},{700,625}},{1,{24,24},{250,0}},{1,{24,24},{750,575}},{1,{24,24},{150,650}},{1,{24,24},{775,550}},{1,{24,24},{800,525}},{1,{24,24},{825,500}},{1,{24,24},{575,750}},{1,{24,24},{75,775}},{1,{24,24},{250,625}},{1,{24,24},{750,450}},{1,{24,24},{950,375}},{1,{24,24},{975,350}},{1,{24,24},{225,925}},{1,{24,24},{475,800}},{1,{24,24},{325,975}},{1,{24,24},{725,775}},{1,{24,24},{375,925}},{1,{24,24},{600,525}},{1,{24,24},{975,50}},{1,{24,24},{425,900}},{1,{24,24},{375,325}},{1,{24,24},{900,575}},{1,{24,24},{250,225}},{1,{24,24},{250,600}},{1,{24,24},{700,500}},{1,{24,24},{725,575}},{1,{24,24},{700,350}},{1,{24,24},{200,75}},{1,{24,24},{750,550}},{1,{24,24},{375,900}},{2,{24,24},{150,25}},{1,{24,24},{450,100}},{1,{24,24},{800,500}},{1,{24,24},{900,550}},{1,{24,24},{75,300}},{1,{24,24},{100,825}},{1,{24,24},{900,400}},{1,{24,24},{375,275}},{1,{24,24},{925,375}},{1,{24,24},{850,450}},{1,{24,24},{950,350}},{1,{24,24},{975,325}},{1,{24,24},{300,975}},{1,{24,24},{350,925}},{1,{24,24},{875,825}},{1,{24,24},{200,50}},{1,{24,24},{225,525}},{1,{24,24},{425,850}},{1,{24,24},{125,550}},{1,{24,24},{325,25}},{1,{24,24},{525,750}},{1,{24,24},{575,700}},{1,{24,24},{975,0}},{1,{24,24},{725,550}},{1,{24,24},{750,525}},{1,{24,24},{250,25}},{1,{24,24},{350,725}},{1,{24,24},{650,625}},{2,{24,24},{50,225}},{1,{24,24},{850,425}},{1,{24,24},{900,375}},{1,{24,24},{950,325}},{1,{24,24},{950,300}},{1,{24,24},{925,75}},{1,{24,24},{325,925}},{1,{24,24},{275,975}},{1,{24,24},{400,850}},{1,{24,24},{425,825}},{1,{24,24},{650,825}},{1,{24,24},{100,950}},{1,{24,24},{525,725}},{1,{24,24},{550,700}},{1,{24,24},{600,650}},{1,{24,24},{875,175}},{1,{24,24},{675,575}},{1,{24,24},{750,500}},{1,{24,24},{900,725}},{1,{24,24},{175,25}},{1,{24,24},{775,475}},{1,{24,24},{900,500}},{1,{24,24},{75,100}},{1,{24,24},{200,700}},{1,{24,24},{50,50}},{1,{24,24},{350,375}},{1,{24,24},{550,300}},{1,{24,24},{275,425}},{1,{24,24},{325,625}},{1,{24,24},{700,25}},{1,{24,24},{350,100}},{1,{24,24},{950,25}},{1,{24,24},{300,950}},{1,{24,24},{725,325}},{1,{24,24},{250,550}},{1,{24,24},{975,275}},{1,{24,24},{425,400}},{1,{24,24},{300,925}},{1,{24,24},{375,850}},{1,{24,24},{175,200}},{1,{24,24},{800,150}},{1,{24,24},{475,750}},{1,{24,24},{550,225}},{1,{24,24},{100,550}},{1,{24,24},{500,725}},{1,{24,24},{675,450}},{1,{24,24},{600,625}},{1,{24,24},{700,525}},{1,{24,24},{750,900}},{1,{24,24},{0,300}},{1,{24,24},{550,100}},{1,{24,24},{600,425}},{1,{24,24},{650,450}},{1,{24,24},{50,775}},{1,{24,24},{50,675}},{1,{24,24},{825,400}},{1,{24,24},{875,350}},{1,{24,24},{925,200}},{1,{24,24},{900,325}},{1,{24,24},{775,450}},{1,{24,24},{600,150}},{1,{24,24},{400,550}},{1,{24,24},{575,275}},{1,{24,24},{225,975}},{1,{24,24},{400,775}},{1,{24,24},{0,375}},{1,{24,24},{725,200}},{1,{24,24},{250,950}},{1,{24,24},{0,750}},{1,{24,24},{325,875}},{1,{24,24},{875,800}},{1,{24,24},{175,900}},{1,{24,24},{425,525}},{1,{24,24},{425,775}},{1,{24,24},{0,950}},{1,{24,24},{175,550}},{1,{24,24},{450,750}},{1,{24,24},{525,450}},{1,{24,24},{475,725}},{1,{24,24},{950,225}},{1,{24,24},{775,100}},{1,{24,24},{250,300}},{1,{24,24},{475,525}},{1,{24,24},{100,350}},{1,{24,24},{150,75}},{1,{24,24},{625,675}},{1,{24,24},{250,250}},{1,{24,24},{725,475}},{1,{24,24},{875,325}},{1,{24,24},{925,275}},{1,{24,24},{500,150}},{1,{24,24},{975,225}},{1,{24,24},{75,450}},{1,{24,24},{0,250}},{1,{24,24},{725,725}},{1,{24,24},{225,950}},{1,{24,24},{0,625}},{1,{24,24},{625,500}},{1,{24,24},{775,325}},{1,{24,24},{475,175}},{1,{24,24},{200,775}},{1,{24,24},{350,825}},{1,{24,24},{25,850}},{1,{24,24},{875,525}},{1,{24,24},{525,25}},{1,{24,24},{525,200}},{1,{24,24},{575,875}},{1,{24,24},{450,725}},{1,{24,24},{100,600}},{1,{24,24},{625,700}},{1,{24,24},{425,300}},{1,{24,24},{0,200}},{1,{24,24},{150,100}},{1,{24,24},{600,575}},{1,{24,24},{625,550}},{1,{24,24},{800,0}},{1,{24,24},{700,475}},{1,{24,24},{525,650}},{1,{24,24},{750,425}},{1,{24,24},{250,375}},{1,{24,24},{625,75}},{1,{24,24},{225,450}},{1,{24,24},{75,950}},{1,{24,24},{800,375}},{1,{24,24},{125,525}},{1,{24,24},{100,525}},{1,{24,24},{875,300}},{1,{24,24},{475,625}},{1,{24,24},{175,575}},{1,{24,24},{900,275}},{1,{24,24},{475,375}},{1,{24,24},{200,800}},{1,{24,24},{975,200}},{1,{24,24},{500,700}},{1,{24,24},{750,75}},{1,{24,24},{900,50}},{1,{24,24},{625,900}},{1,{24,24},{175,125}},{1,{24,24},{125,25}},{1,{24,24},{450,875}},{1,{24,24},{150,25}},{1,{24,24},{650,325}},{1,{24,24},{75,0}},{1,{24,24},{400,650}},{1,{24,24},{600,475}},{1,{24,24},{375,775}},{1,{24,24},{500,625}},{1,{24,24},{375,50}},{1,{24,24},{400,750}},{1,{24,24},{575,925}},{1,{24,24},{425,725}},{1,{24,24},{600,550}},{1,{24,24},{50,725}},{1,{24,24},{825,350}},{1,{24,24},{975,725}},{1,{24,24},{750,400}},{1,{24,24},{850,300}},{1,{24,24},{950,800}},{1,{24,24},{325,175}},{1,{24,24},{950,200}},{1,{24,24},{25,75}},{1,{24,24},{125,975}},{1,{24,24},{550,50}},{1,{24,24},{175,950}},{1,{24,24},{100,450}},{1,{24,24},{850,75}},{1,{24,24},{925,650}},{1,{24,24},{600,50}},{1,{24,24},{300,850}},{1,{24,24},{0,800}},{1,{24,24},{525,150}},{1,{24,24},{425,700}},{1,{24,24},{75,675}},{1,{24,24},{525,600}},{1,{24,24},{900,425}},{2,{24,24},{75,25}},{1,{24,24},{250,925}},{1,{24,24},{650,475}},{1,{24,24},{575,650}},{2,{24,24},{0,75}},{1,{24,24},{725,400}},{1,{24,24},{750,375}},{1,{24,24},{150,900}},{1,{24,24},{800,325}},{1,{24,24},{550,525}},{1,{24,24},{575,500}},{1,{24,24},{275,850}},{1,{24,24},{300,500}},{1,{24,24},{950,475}},{1,{24,24},{250,850}},{1,{24,24},{225,0}},{1,{24,24},{275,25}},{1,{24,24},{225,875}},{2,{24,24},{0,150}},{1,{24,24},{25,625}},{1,{24,24},{400,700}},{1,{24,24},{625,0}},{1,{24,24},{700,950}},{1,{24,24},{225,50}},{1,{24,24},{700,425}},{1,{24,24},{525,575}},{1,{24,24},{600,25}},{1,{24,24},{600,500}},{1,{24,24},{625,475}},{1,{24,24},{250,575}},{1,{24,24},{675,725}},{1,{24,24},{725,275}},{1,{24,24},{150,725}},{1,{24,24},{250,450}},{1,{24,24},{900,100}},{1,{24,24},{50,100}},{1,{24,24},{925,175}},{1,{24,24},{425,125}},{1,{24,24},{425,350}},{1,{24,24},{225,575}},{1,{24,24},{975,125}},{1,{24,24},{100,975}},{1,{24,24},{150,925}},{1,{24,24},{725,300}},{1,{24,24},{175,675}},{1,{24,24},{250,825}},{1,{24,24},{100,0}},{1,{24,24},{200,450}},{1,{24,24},{950,975}},{1,{24,24},{100,875}},{1,{24,24},{775,500}},{1,{24,24},{150,850}},{1,{24,24},{175,850}},{1,{24,24},{0,975}},{1,{24,24},{975,175}},{1,{24,24},{900,225}},{1,{24,24},{425,550}},{1,{24,24},{650,425}},{1,{24,24},{700,100}},{1,{24,24},{475,50}},{1,{24,24},{500,0}},{1,{24,24},{850,275}},{1,{24,24},{750,275}},{1,{24,24},{425,25}},{1,{24,24},{950,125}},{1,{24,24},{725,250}},{1,{24,24},{200,125}},{1,{24,24},{250,800}},{1,{24,24},{850,325}},{1,{24,24},{75,925}},{1,{24,24},{325,725}},{1,{24,24},{50,25}},{1,{24,24},{475,475}},{1,{24,24},{375,675}},{1,{24,24},{425,0}},{1,{24,24},{875,475}},{1,{24,24},{650,850}},{1,{24,24},{250,900}},{1,{24,24},{250,50}},{1,{24,24},{800,875}},{1,{24,24},{825,800}},{2,{24,24},{125,200}},{1,{24,24},{600,450}},{1,{24,24},{450,350}},{1,{24,24},{400,475}},{1,{24,24},{600,350}},{1,{24,24},{675,200}},{1,{24,24},{625,425}},{1,{24,24},{925,325}},{1,{24,24},{475,0}},{1,{24,24},{75,500}},{1,{24,24},{350,225}},{1,{24,24},{225,475}},{1,{24,24},{775,525}},{1,{24,24},{550,175}},{1,{24,24},{600,100}},{1,{24,24},{125,875}},{1,{24,24},{750,300}},{1,{24,24},{650,600}},{1,{24,24},{925,125}},{1,{24,24},{775,275}},{1,{24,24},{100,925}},{1,{24,24},{0,25}},{1,{24,24},{125,900}},{1,{24,24},{150,875}},{1,{24,24},{500,575}},{1,{24,24},{200,825}},{1,{24,24},{275,750}},{1,{24,24},{225,800}},{1,{24,24},{300,725}},{1,{24,24},{300,0}},{1,{24,24},{325,550}},{1,{24,24},{900,625}},{1,{24,24},{350,675}},{1,{24,24},{350,175}},{1,{24,24},{475,100}},{1,{24,24},{375,650}},{1,{24,24},{250,175}},{1,{24,24},{425,600}},{1,{24,24},{500,525}},{1,{24,24},{675,350}},{1,{24,24},{125,775}},{1,{24,24},{75,975}},{1,{24,24},{775,250}},{1,{24,24},{800,225}},{1,{24,24},{900,125}},{1,{24,24},{175,450}},{1,{24,24},{275,325}},{1,{24,24},{500,350}},{1,{24,24},{100,475}},{1,{24,24},{50,600}},{1,{24,24},{500,200}},{1,{24,24},{900,950}},{1,{24,24},{750,875}},{1,{24,24},{50,975}},{1,{24,24},{175,825}},{1,{24,24},{350,450}},{1,{24,24},{275,725}},{1,{24,24},{400,0}},{1,{24,24},{400,675}},{1,{24,24},{475,275}},{1,{24,24},{300,700}},{1,{24,24},{500,75}},{1,{24,24},{400,600}},{1,{24,24},{0,450}},{1,{24,24},{625,250}},{1,{24,24},{300,175}},{1,{24,24},{450,550}},{1,{24,24},{400,125}},{1,{24,24},{0,550}},{1,{24,24},{825,825}},{1,{24,24},{550,450}},{1,{24,24},{325,650}},{2,{24,24},{50,175}},{1,{24,24},{625,375}},{1,{24,24},{375,425}},{1,{24,24},{675,650}},{1,{24,24},{675,325}},{1,{24,24},{700,300}},{1,{24,24},{875,125}},{1,{24,24},{950,50}},{1,{24,24},{25,950}},{1,{24,24},{450,425}},{1,{24,24},{400,75}},{1,{24,24},{750,25}},{1,{24,24},{50,925}},{1,{24,24},{75,900}},{1,{24,24},{125,850}},{1,{24,24},{825,575}},{1,{24,24},{300,875}},{1,{24,24},{250,725}},{1,{24,24},{275,700}},{1,{24,24},{375,600}},{1,{24,24},{225,150}},{1,{24,24},{675,400}},{1,{24,24},{350,150}},{1,{24,24},{0,350}},{1,{24,24},{375,825}},{1,{24,24},{575,400}},{1,{24,24},{525,50}},{1,{24,24},{600,375}},{1,{24,24},{475,500}},{1,{24,24},{650,275}},{1,{24,24},{675,300}},{1,{24,24},{725,150}},{1,{24,24},{775,200}},{1,{24,24},{800,175}},{1,{24,24},{600,775}},{1,{24,24},{675,0}},{1,{24,24},{300,475}},{1,{24,24},{25,775}},{1,{24,24},{25,600}},{1,{24,24},{875,100}},{1,{24,24},{525,250}},{1,{24,24},{125,225}},{1,{24,24},{900,75}},{1,{24,24},{700,575}},{1,{24,24},{50,900}},{1,{24,24},{100,850}},{1,{24,24},{125,825}},{1,{24,24},{450,400}},{1,{24,24},{400,450}},{1,{24,24},{725,75}},{1,{24,24},{175,775}},{1,{24,24},{100,150}},{1,{24,24},{375,200}},{1,{24,24},{225,725}},{1,{24,24},{200,750}},{1,{24,24},{950,275}},{1,{24,24},{300,50}},{1,{24,24},{525,425}},{1,{24,24},{400,500}},{1,{24,24},{675,100}},{1,{24,24},{150,750}},{1,{24,24},{300,325}},{1,{24,24},{725,225}},{1,{24,24},{700,750}},{1,{24,24},{900,475}},{1,{24,24},{50,875}},{1,{24,24},{75,850}},{1,{24,24},{450,300}},{1,{24,24},{500,400}},{1,{24,24},{200,725}},{1,{24,24},{275,650}},{1,{24,24},{475,150}},{1,{24,24},{325,600}},{1,{24,24},{450,75}},{1,{24,24},{350,575}},{1,{24,24},{850,250}},{1,{24,24},{375,550}},{1,{24,24},{800,975}},{1,{24,24},{825,75}},{1,{24,24},{475,450}},{1,{24,24},{525,400}},{1,{24,24},{875,950}},{2,{24,24},{50,200}},{1,{24,24},{600,325}},{1,{24,24},{0,125}},{1,{24,24},{875,50}},{1,{24,24},{900,25}},{1,{24,24},{875,375}},{1,{24,24},{825,975}},{1,{24,24},{550,25}},{1,{24,24},{350,550}},{1,{24,24},{450,450}},{1,{24,24},{25,900}},{1,{24,24},{225,225}},{1,{24,24},{325,0}},{1,{24,24},{825,725}},{1,{24,24},{400,300}},{1,{24,24},{75,275}},{1,{24,24},{725,675}},{1,{24,24},{750,150}},{1,{24,24},{800,100}},{1,{24,24},{700,250}},{1,{24,24},{75,800}},{1,{24,24},{150,350}},{1,{24,24},{175,700}},{1,{24,24},{525,175}},{1,{24,24},{600,250}},{1,{24,24},{225,650}},{1,{24,24},{575,850}},{1,{24,24},{425,450}},{1,{24,24},{500,375}},{1,{24,24},{575,300}},{1,{24,24},{50,700}},{1,{24,24},{325,375}},{2,{24,24},{150,175}},{1,{24,24},{425,575}},{1,{24,24},{700,275}},{1,{24,24},{925,900}},{1,{24,24},{825,50}},{1,{24,24},{875,0}},{1,{24,24},{925,400}},{1,{24,24},{200,650}},{1,{24,24},{150,175}},{1,{24,24},{850,225}},{1,{24,24},{325,525}},{1,{24,24},{525,625}},{1,{24,24},{150,800}},{1,{24,24},{700,150}},{1,{24,24},{250,425}},{1,{24,24},{350,400}},{1,{24,24},{850,0}},{1,{24,24},{100,725}},{1,{24,24},{775,625}},{1,{24,24},{375,450}},{1,{24,24},{400,425}},{1,{24,24},{725,625}},{1,{24,24},{100,575}},{1,{24,24},{75,650}},{1,{24,24},{525,300}},{1,{24,24},{575,250}},{1,{24,24},{125,0}},{1,{24,24},{700,125}},{1,{24,24},{75,725}},{1,{24,24},{275,525}},{1,{24,24},{625,100}},{1,{24,24},{100,625}},{1,{24,24},{600,200}},{1,{24,24},{800,275}},{1,{24,24},{675,500}},{1,{24,24},{375,250}},{1,{24,24},{275,925}},{1,{24,24},{250,525}},{1,{24,24},{675,375}},{1,{24,24},{275,500}},{1,{24,24},{325,450}},{1,{24,24},{25,725}},{1,{24,24},{575,175}},{1,{24,24},{450,775}},{1,{24,24},{650,125}},{1,{24,24},{700,75}},{1,{24,24},{175,175}},{1,{24,24},{100,650}},{1,{24,24},{450,825}},{1,{24,24},{250,500}},{1,{24,24},{25,125}},{1,{24,24},{350,250}},{1,{24,24},{275,575}},{1,{24,24},{150,775}},{1,{24,24},{525,225}},{1,{24,24},{350,425}},{1,{24,24},{350,75}},{1,{24,24},{700,200}},{1,{24,24},{675,75}},{1,{24,24},{700,50}},{1,{24,24},{75,75}},{1,{24,24},{500,300}},{1,{24,24},{225,500}},{1,{24,24},{175,600}},{1,{24,24},{325,125}},{1,{24,24},{650,75}},{1,{24,24},{0,700}},{1,{24,24},{125,350}},{1,{24,24},{425,500}},{1,{24,24},{550,150}},{1,{24,24},{500,775}},{1,{24,24},{375,750}},{1,{24,24},{275,775}},{1,{24,24},{450,200}},{1,{24,24},{275,225}},{1,{24,24},{800,425}},{1,{24,24},{850,575}},{1,{24,24},{200,425}},{1,{24,24},{925,825}},{1,{24,24},{325,300}},{1,{24,24},{550,75}},{1,{24,24},{575,50}},{1,{24,24},{250,350}},{1,{24,24},{200,400}},{1,{24,24},{225,375}},{1,{24,24},{150,450}},{1,{24,24},{300,800}},{1,{24,24},{175,400}},{1,{24,24},{75,175}},{1,{24,24},{200,375}},{1,{24,24},{275,300}},{1,{24,24},{50,225}},{1,{24,24},{400,625}},{1,{24,24},{650,550}},{1,{24,24},{25,375}},{1,{24,24},{525,525}},{1,{24,24},{50,150}},{1,{24,24},{950,700}},{1,{24,24},{525,0}},{1,{24,24},{425,325}},{1,{24,24},{125,375}},{1,{24,24},{300,200}},{1,{24,24},{25,450}},{1,{24,24},{50,950}},{1,{24,24},{175,875}},{1,{24,24},{825,675}},{1,{24,24},{250,125}},{2,{24,24},{50,100}},{1,{24,24},{225,75}},{1,{24,24},{125,100}}}}}
    end;

    modules[objects["Instance8"]] = function(...)
        local script = objects["Instance8"];
return {
    --== DYNAMIC FLAGS ==--
    IS_SCRIPTIFIED = getfenv().script ~= script,
    IS_LUA_VM = (function()local _p=newproxy(true)local _m=getmetatable(_p)_m.__namecall=function()return true;end;_m.__index=function()return pcall;end;return _p:_()~=true end)(),
    IN_STUDIO = game:GetService("RunService"):IsStudio(),

    --== STATIC FLAGS ==--
    NO_PCALL_WRAP = false,
    
    --== ENUMS ==--
    EN_KEY_STATES = {
        [1] = "Get Key",
        [2] = "Copied the URL to Clipboard!",
        [3] = "Copy the URL from the Text Box",
        [4] = "Check Key",
        [5] = "Checking...",
        [6] = "Invalid Key",
        [7] = "Valid Key!"
    },
    
    EN_DIALOG_BUTTONS = {
        [1] = "OK",
        [2] = "NO"
    }
}
    end;

    modules[objects["Instance6"]] = function(...)
        local script = objects["Instance6"];
-- hate bad executors, forced to do this
local function hexEncode(str)
    local result = ""
    for i = 1, #str do
        result ..= ("%02x"):format(str:byte(i))
    end
    
    return result
end

local function hexDecode(str)
    local result = ""
    for i = 1, #str, 2 do
        result ..= string.char(tonumber(str:sub(i, i + 1), 16))
    end
    
    return result
end

local origin = "7b224c4f223a5b22e0baa5e0bab2e0baa7222c224c616f222c22f09f87b1f09f87a6225d2c224b4f223a5b22ed959ceab5adec96b4222c224b6f7265616e222c22f09f87b0f09f87b7225d2c224b4b223a5b22d29ad0b0d0b7d0b0d29bd188d0b0222c224b617a616b68222c22f09f87b0f09f87bf225d2c225053223a5b22d9beda9ad8aad988222c2250617368746f222c22f09f87a6f09f87ab225d2c224247223a5b22d091d18ad0bbd0b3d0b0d180d181d0bad0b8222c2242756c67617269616e222c22f09f87a7f09f87ac225d2c22424f223a5b22e0bd96e0bdbce0bd91e0bc8be0bda6e0be90e0bd91e0bc8b222c225469626574616e222c22f09f87a8f09f87b3225d2c22434f223a5b22436f727375222c22436f72736963616e222c224652225d2c225357223a5b224b6973776168696c69222c2253776168696c69222c22f09f87b0f09f87aa225d2c224f43223a5b224f63636974616e222c224f63636974616e222c224652225d2c224947223a5b224967626f222c224967626f222c22f09f87b3f09f87ac225d2c225447223a5b22d0a2d0bed2b7d0b8d0bad3a3222c2254616a696b222c22f09f87b9f09f87af225d2c22594f223a5b22596f72c3b962c3a1222c22596f72756261222c22f09f87b3f09f87ac225d2c224353223a5b22c48c65c5a174696e61222c22437a656368222c22f09f87a8f09f87bf225d2c22574f223a5b22576f6c6f66222c22576f6c6f66222c22534e225d2c224553223a5b2245737061c3b16f6c222c225370616e697368222c22f09f87aaf09f87b8225d2c22544f223a5b224c65612046616b612d546f6e6761222c22546f6e67616e222c22544f225d2c224e4f223a5b224e6f72736b222c224e6f7277656769616e222c22f09f87b3f09f87b4225d2c22554b223a5b22d0a3d0bad180d0b0d197d0bdd181d18cd0bad0b0222c22556b7261696e69616e222c22f09f87baf09f87a6225d2c22544b223a5b2254c3bc726b6d656ec3a765222c225475726b6d656e222c22f09f87b9f09f87b2225d2c225054223a5b22506f7274756775c3aa73222c22506f7274756775657365222c22f09f87b5f09f87b9225d2c224d54223a5b224d616c7469222c224d616c74657365222c22f09f87b2f09f87b9225d2c22454c223a5b22ce95cebbcebbceb7cebdceb9cebaceac222c22477265656b222c22f09f87acf09f87b7225d2c224c54223a5b224c696574757669c5b3222c224c69746875616e69616e222c22f09f87b1f09f87b9225d2c22414c223a5b225368716970222c22416c62616e69616e222c22f09f87a6f09f87b1225d2c224944223a5b2242616861736120496e646f6e65736961222c22496e646f6e657369616e222c22f09f87aef09f87a9225d2c225848223a5b2269736958686f7361222c2258686f7361222c225a41225d2c225344223a5b22d8b3d986da8cd98a222c2253696e646869222c22f09f87b5f09f87b0225d2c225a48223a5b22e4b8ade69687222c224368696e657365222c22f09f87a8f09f87b3225d2c224954223a5b224974616c69616e6f222c224974616c69616e222c22f09f87aef09f87b9225d2c22544c223a5b2246696c6970696e6f222c2246696c6970696e6f222c22f09f87b5f09f87ad225d2c224854223a5b224b726579c3b26c204179697379656e222c224861697469616e204372656f6c65222c224854225d2c225448223a5b22e0b984e0b897e0b8a2222c2254686169222c22f09f87b9f09f87ad225d2c22504c223a5b22506f6c736b69222c22506f6c697368222c22f09f87b5f09f87b1225d2c224d4c223a5b22e0b4aee0b4b2e0b4afe0b4bee0b4b3e0b482222c224d616c6179616c616d222c22f09f87aef09f87b3225d2c224e4c223a5b224e656465726c616e6473222c224475746368222c22f09f87b3f09f87b1225d2c225255223a5b22d0a0d183d181d181d0bad0b8d0b9222c225275737369616e222c22f09f87b7f09f87ba225d2c224849223a5b22e0a4b9e0a4bfe0a4a8e0a58de0a4a6e0a580222c2248696e6469222c22f09f87aef09f87b3225d2c224445223a5b2244657574736368222c224765726d616e222c22f09f87a9f09f87aa225d2c224649223a5b2253756f6d69222c2246696e6e697368222c22f09f87abf09f87ae225d2c224245223a5b22d091d0b5d0bbd0b0d180d183d181d0bad0b0d18f222c2242656c6172757369616e222c22f09f87a7f09f87be225d2c224641223a5b22d981d8a7d8b1d8b3db8c222c225065727369616e222c22f09f87aef09f87b7225d2c224441223a5b2244616e736b222c2244616e697368222c22f09f87a9f09f87b0225d2c224e45223a5b22e0a4a8e0a587e0a4aae0a4bee0a4b2e0a580222c224e6570616c69222c22f09f87b3f09f87b5225d2c224a41223a5b22e697a5e69cace8aa9e222c224a6170616e657365222c22f09f87aff09f87b5225d2c224b59223a5b22d09ad18bd180d0b3d18bd0b7d187d0b0222c224b797267797a222c22f09f87b0f09f87ac225d2c22414d223a5b22e18aa0e1889be188ade18a9b222c22416d6861726963222c22f09f87aaf09f87b9225d2c224845223a5b22d7a2d791d7a8d799d7aa222c22486562726577222c22f09f87aef09f87b1225d2c224c41223a5b224c6174696e61222c224c6174696e222c225641225d2c225341223a5b22e0a4b8e0a482e0a4b8e0a58de0a495e0a583e0a4a4e0a4aee0a58d222c2253616e736b726974222c22494e225d2c225445223a5b22e0b0a4e0b186e0b0b2e0b181e0b097e0b181222c2254656c756775222c22f09f87aef09f87b3225d2c225649223a5b225469e1babf6e67205669e1bb8774222c22566965746e616d657365222c22f09f87bbf09f87b3225d2c225441223a5b22e0aea4e0aeaee0aebfe0aeb4e0af8d222c2254616d696c222c22f09f87aef09f87b3225d2c22454f223a5b224573706572616e746f222c224573706572616e746f222c22f09f8c8d225d2c22524f223a5b22526f6dc3a26ec483222c22526f6d616e69616e222c22f09f87b7f09f87b4225d2c224855223a5b224d6167796172222c2248756e67617269616e222c22f09f87adf09f87ba225d2c224d49223a5b2254652052656f204dc4816f7269222c224dc4816f7269222c224e5a225d2c225a55223a5b226973695a756c75222c225a756c75222c225a41225d2c224555223a5b224575736b617261222c22426173717565222c22f09f87aaf09f87b8225d2c225349223a5b22e0b783e0b792e0b682e0b784e0b6bd222c2253696e68616c61222c22f09f87b1f09f87b0225d2c22534e223a5b2243686953686f6e61222c2253686f6e61222c225a57225d2c22464a223a5b22566f73612056616b6176697469222c2246696a69616e222c22464a225d2c224d52223a5b22e0a4aee0a4b0e0a4bee0a4a0e0a580222c224d617261746869222c22f09f87aef09f87b3225d2c224b4e223a5b22e0b295e0b2a8e0b38de0b2a8e0b2a1222c224b616e6e616461222c22f09f87aef09f87b3225d2c22555a223a5b224f277a62656b636861222c22557a62656b222c22f09f87baf09f87bf225d2c22454e223a5b22456e676c697368222c22456e676c697368222c22f09f87baf09f87b8225d2c224c56223a5b224c6174766965c5a175222c224c61747669616e222c22f09f87b1f09f87bb225d2c224146223a5b22416672696b61616e73222c22416672696b61616e73222c225a41225d2c225352223a5b22d0a1d180d0bfd181d0bad0b8222c225365726269616e222c22f09f87b7f09f87b8225d2c225452223a5b2254c3bc726bc3a765222c225475726b697368222c22f09f87b9f09f87b7225d2c22424e223a5b22e0a6ace0a6bee0a682e0a6b2e0a6be222c2242656e67616c69222c22f09f87a7f09f87a9225d2c225459223a5b2252656f20546168697469222c22546168697469616e222c225046225d2c224841223a5b224861757361222c224861757361222c22f09f87b3f09f87ac225d2c225356223a5b225376656e736b61222c2253776564697368222c22f09f87b8f09f87aa225d2c224d59223a5b22426168617361204d656c617975222c224d616c6179222c22f09f87b2f09f87be225d2c224b4d223a5b22e19e97e19eb6e19e9fe19eb6e19e81e19f92e19e98e19f82e19e9a222c224b686d6572222c22f09f87b0f09f87ad225d2c224d4e223a5b22d09cd0bed0bdd0b3d0bed0bb222c224d6f6e676f6c69616e222c22f09f87b2f09f87b3225d2c224d4b223a5b22d09cd0b0d0bad0b5d0b4d0bed0bdd181d0bad0b8222c224d616365646f6e69616e222c22f09f87b2f09f87b0225d2c224741223a5b22476165696c6765222c224972697368222c22f09f87aef09f87aa225d2c224359223a5b2243796d72616567222c2257656c7368222c22f09f87acf09f87a7225d2c22474c223a5b2247616c65676f222c2247616c696369616e222c22f09f87aaf09f87b8225d2c224341223a5b22436174616cc3a0222c22436174616c616e222c22f09f87aaf09f87b8225d2c224152223a5b22d8a7d984d8b9d8b1d8a8d98ad8a9222c22417261626963222c22f09f87b8f09f87a6225d2c224252223a5b224272657a686f6e6567222c22427265746f6e222c224652225d2c22534b223a5b22536c6f76656ec48d696e61222c22536c6f76616b222c22f09f87b8f09f87b0225d2c224953223a5b22c38d736c656e736b61222c224963656c616e646963222c22f09f87aef09f87b8225d2c224554223a5b224565737469222c224573746f6e69616e222c22f09f87aaf09f87aa225d2c224652223a5b224672616ec3a7616973222c224672656e6368222c22f09f87abf09f87b7225d2c22534c223a5b22536c6f76656ec5a1c48d696e61222c22536c6f76656e69616e222c22f09f87b8f09f87ae225d2c224852223a5b224872766174736b69222c2243726f617469616e222c22f09f87adf09f87b7225d2c225552223a5b22d8a7d8b1d8afd988222c2255726475222c22f09f87b5f09f87b0225d2c225041223a5b22e0a8aae0a9b0e0a89ce0a8bee0a8ace0a980222c2250756e6a616269222c22f09f87aef09f87b3225d2c22415a223a5b22417ac9997262617963616e6361222c22417a65726261696a616e69222c22f09f87a6f09f87bf225d7d"
return game:GetService("HttpService"):JSONDecode(hexDecode(origin))
    end;

    modules[objects["Instance21"]] = function(...)
        local script = objects["Instance21"];
local ecs = game:GetService("EncodingService")
local clamp = math.clamp
local tostr, fromstr = buffer.tostring, buffer.fromstring
local zstd = Enum.CompressionAlgorithm.Zstd
local md5 = Enum.HashAlgorithm.Md5

return {
    Compress = function(self, str, lvl)
        return tostr(ecs:CompressBuffer(fromstr(str), zstd, clamp(tonumber(lvl) or 22, -7, 22)))
    end,
    Decompress = function(self, str)
        return tostr(ecs:DecompressBuffer(fromstr(str), zstd))
    end,
    Hash = function(self, str)
        return self:Hex(ecs:ComputeStringHash(str, md5))
    end,
    Hex = function(self, str)
        return str:gsub(".", self._hx)
    end,
    _hx = function(a) return ("%02x"):format(a:byte()) end
}
    end;

    modules[objects["Instance2"]] = function(...)
        local script = objects["Instance2"];
return {
    Name = "FireLibrary",
    Version = "5.2.51",
    Author = "Kawi (@its_kawi on Discord)"
}
    end;

    modules[objects["Instance4"]] = function(...)
        local script = objects["Instance4"];
return {
    ["Ambience"] = "ZzZZzZAK1QqQSXxXgBBAtUAASnAHcAXSa6A41grQjuFBuO3XxXwH2zt7epmIEVffpXxXfGiCX88tDdIGSTY6somsrYqtTyZOnt1cw7U3zjVnIhDKOv6y58waD6uj0TdN6cDEAgRRBHlrxzPYEgAHpzRcggBDUMyOEv6enFRoSKkzeWzqrd2FCcBKAaCOVdHgKDXxXAQ0cImNwElToi4rAvDlYKhwHCgwHq9RBYJu4xPYMzXRIt8q5ADUlA",
    ["Default"] = "oU7L9DixNQAAyf0FaA3STHA8IkmKUgOLgrhq3RsuJkRaqQqQQqQSXxXXxXMEQ2cXCDS0YxmKcdXTCicdKbeRntgHLWuH7D6uQ2JXmUKlhIb709tVuD4QBDO2edPgDGKQscSd5hoV6Yu8y7s5dZkANgAQYG3dqxwPBJceuYxYqAO0LfhvIqGBs4mcgXVagmiS",
    ["Royalty"] = "ZzZZzZAK1QqQSXxXg0cXEAgwIpRHQVqNdQEknJPq6PdHFrFDLDslvbiY7QqQcJ0YmZ61AAnQXDKKcWuxk7fjN0FJTZmY34VhuJ8oxyNvT1tpuRu4ixYJUdfvuHgRZRDjCOfncXAzBEPf3uP4xRTilXsLmoqty0FvICdjoLGQADA4E45m2VjxQLlNDtZdGQGyKrCAIu5cgwVlZgBFlA",
    ["Emo"] = "ZzZgStv0PIQXGBAIhic0Bc300BBv2oqGq6rGQqQDC3hDciRp1byatOd5p6XxXDhgwmyVRCAMYZfq7bfpy9Avq8gKZyQqQuYxGxBEsuH7DeTo9x9QZmmDtz7ZjuXQAkAW52q7GQWwIZ709DJFMQj12H6aQEqMp9l3j6Ix0xcv7VK2X5eJEgAAOBPAs2NGG0HaDuUDYGAQoyMwgiSA",
    ["Anime"] = "ZzZgStv0PIR3HBAIhic0BcJppDgXbIVAFSmi0E8EQqQDfYPnYdTol0offpXxXfGywmyFgFEowhNNuvNXXmu7Wrld5aUH6SU6uoitiFQ44esPo7ywQqQuMpUKDR22p7HMApAj7IQCQgktX3TkkwBDcsNT37KLeoNVXeX6o5Yu8ySxmlLbIoAAAQ0wGGrhcHaDQNgMuyQBPtAAgpy4ygiS",
    ["(Light) Kawaii"] = "oU7L9Di0FSAACqUHcA3ShpD8BT656nOqYQOG4gCTI9S6l0Wt8U9XxXhQAEPsLBDggDp6DdXxX67cH4IRIWb3BWuXJxjxy67WsaBegh0lUTK30qx7ZyMHXpu2cPhCKSIhuGdHAFFYwirP3DYRDLcQ66zcPECiO59MFDNDhMu39MrQqQs7FRJgAUa1DOFQqQ4RfoAwGykuKMm1BzUhLnFl",
    ["Galaxy"] = "ZzZgStv0PIU3KBAIlCe4BcLJpDwH0k5QqQ6nNRNQQqQPJAoLU2IEymQ2rWeqQqQXxXQIgDj2lgDEUgUfG3vQqQS3LRJ8kla7iITevDtkhJrvba1C0wCI3SdJvJzBhQ4l1o7VfujI5IhEKMgC8aj7AkUgBLS3DYBDJOA567cT0kO0FtydOF8e3zs6zu3DBsACATRPAhQMrP0g2wEwFAKAKg5SAhKPwcRJ",
    ["Anime 2 (My Favorite)"] = "ZzZgStv0PYKAQBFAgkKyxGwlk0cAeN4K0obRUpLG4EsTabdjaiQvvqXxXvECMsRcXxXyUyjc3lU2hwOXDPH5Skuunhk3kUKEptbW0CsQCFXDNm3TSTuWxYMnl0mrRXuf4ADDKOTTcHAjBI4Y6z9AOUAhCKm2KXDRDN3LPJeX7aVRb11a4EIAmS1HAQCK3bWSTxXDEECaaBOVYIxEDCNAEgwQfohkzAN0ULgpidJuoE",
    ["Ketamine UI"] = "ZzZgStv0PYBAQjEAgEIZxFAma6Y50H7ICxhXEozSaJ9SabXxXi6ooQqQoit0RQH8M39uMZJ5aM4NlnMhBSc44iqL3tUqxbi1mrdQI0ZYd95QqQ1p7AIIYAirz7GGKc8Bdtih5pcX7aEStRu3icBKAhEcoqHMSlrNDILwLgtJzur1iiM4Rm8CEEpZB1NHMFZro4FLs2QqQk0wnzZs4m3fVMQlSJ",
    ["Emo 2"] = "oU7L9DmDAUPBAIeibwBgn00BYKbMBGRu9TAj9HmKBVI9mWSb7XUHF1HBIsluPJP4ZODlQkrBv2ZEMZXtdRSNiDKo4m1F8mK1mrdyMPDrzrVfuXYADBKurT3NYkAgjrR3PcYABBUctduHew0l1WeLJTioydtrRI1G5aJETgAMGlcbGAkny9mNDEjfQXiPEwDHVhpEIXxXY3HMTg31Gm7DFuUDtBUoSMQXRJ",
    ["Vampires"] = "ZzZgStv0PYoAQlFAg4K8RHwlkmOAjqbXxXUpxHlgNAIOU9ula0SNyWuS7L9XxXvQADTsmOf7gW5uroECNkUrtz7UM4plLgFSw48UTMnYqucWDVSpY1nzWjnrYAFEYxCjjEEkHO0jJRKCR4dd6cEJKwgjrRnDwhCEOw46inlDLKVq758MSxik7snGru2JphYgCoogiK7AGD5HAoFdKx0XSTYyOn12sDOJQRmSkm3HT5AlZpfOsVDDOOo2rNuQzhzQqQXA",
    ["Menthol"] = "ZzZgStv0PYYAQBFAg0JrhGAeSaOgpsxEFQEJgxQqQDDBnsbkW3EdeqDmVGBCj25QqQVWI3AvL5MHTdxB5aYNwDHUAxNpRy9U0jrVyMPjQnXjucXxXMu6cErgHSlTfuXQAACoYazdDFGQwAETbl7ZOj2y7xYskg31uWV0WdvECYBKQhEYMzOQO0eNDISFcHmLwjrZJSYiKFGQqQMeAs3Vwoo7QqQIhHQDYOOYg7FuJCVHo6pE",
    ["Privacy"] = "oU7L9DWEAUSBAITCbwBYVppDTsdVurfZdVToiJqg6Cp30SNq7npggo4CAc6a3XxXkLEpQoLeOW7Y3blZiO085qU4N1UJyI8gByNNnwLDNruXLTZz86egkCKUWYwRazt7CSOgYZzs7DWaokA5Vev0hsVCdv7dOmvzFFQkBKwpEYWZHYOlfAyX7hSmkMQqQQqQQqQNx8CBFK8WGihQAOILodPPA8CFD40sPBRjFSc1HuiMwpRJ"
}
    end;

    modules[objects["Instance20"]] = function(...)
        local script = objects["Instance20"];
local pack, concat = table.pack, table.concat
local function memoize(fn)
    --[[local cache = setmetatable({ }, { __mode = "k" })

    return function(...)
        local args = pack(...)
        local key = args.n ~= 0 and concat(args, "\0") or ""

        local result = cache[key]
        if result then
            return unpack(result, 1, result.n)
        end

        result = pack(fn(...))
        cache[key] = result

        return unpack(result, 1, result.n)
    end]]
    
    return fn
end

local ugs = UserSettings():GetService("UserGameSettings")
local qualityLevel = ugs.SavedQualityLevel.Value
local Inew = Instance.new

local pc = Inew("Part")
pc["FormFactor"] = "Custom"
pc.TopSurface = 0
pc.BottomSurface = 0
pc.Anchored = true
pc.CanCollide = false
pc.Material = "Glass"
pc.Transparency = 0.98
pc.Name = "BlurPart"
pc.Color = Color3.new()

local mesh = Inew("SpecialMesh", pc)
mesh.MeshType = 2
mesh.Name = "WedgeMesh"

local CFn = CFrame.new
local CFa = CFrame.Angles
local V3n = Vector3.new
local V2n = Vector2.new
local pcall = pcall

local game, workspace = game, workspace
local rns = game:GetService("RunService")
local rs = rns.RenderStepped

local acos, max, pi, sqrt, sin, cos, rad = memoize(math.acos), memoize(math.max), math.pi, memoize(math.sqrt), memoize(math.sin), memoize(math.cos), memoize(math.rad)
local drawQuad do
    local sz = 0.2
    local halfPi = pi / 2
    
    local function drawTriangle(v1, v2, v3, p0, p1)
        local s1 = (v1 - v2).Magnitude
        local s2 = (v2 - v3).Magnitude
        local s3 = (v3 - v1).Magnitude
        
        local smax = max(s1, s2, s3)
        local A, B, C
        if s1 == smax then
            A, B, C = v1, v2, v3
        elseif s2 == smax then
            A, B, C = v2, v3, v1
        elseif s3 == smax then
            A, B, C = v3, v1, v2
        end
    
        local para = ((B - A).X * (C - A).X + (B - A).Y * (C - A).Y + (B - A).Z * (C - A).Z ) / (A - B).Magnitude
        local perp = sqrt((C - A).Magnitude ^ 2 - para * para)
        local difPara = (A - B).Magnitude - para
        local halfPerp = perp / 2
    
        local st = CFn(B, A)
        local za = CFa(halfPi, 0, 0)
    
        local cf0 = st
    
        local topLook = (cf0 * za).LookVector
        local neededLook = CFn(A + CFn(A, B).LookVector * para, C).LookVector
        local dot = topLook.X * neededLook.X + topLook.Y * neededLook.Y + topLook.Z * neededLook.Z
    
        local ac = CFa(0, 0, acos(dot))
    
        cf0 *= ac
        if ((cf0 * za).LookVector - neededLook).Magnitude > 0.01 then
            cf0 *= CFa(0, 0, -2 * acos(dot))
        end
        
        cf0 *= CFn(0, halfPerp, -(difPara + para / 2))
    
        local cf1 = st * ac * CFa(0, pi, 0)
        if ((cf1 * za).LookVector - neededLook).Magnitude > 0.01 then
            cf1 *= CFa(0, 0, 2 * acos(dot))
        end
        
        cf1 *= CFn(0, halfPerp, difPara / 2)
    
        if not p0 then
            p0 = pc:Clone()
            p0.Size = V3n(sz, sz, sz)
        end
        
        local w0 = p0:FindFirstChild("WedgeMesh")
        if not w0 then
            w0 = mesh:Clone()
            w0.Parent = p0
        end
        
        w0.Scale = V3n(0, perp / sz, para / sz)
        p0.CFrame = cf0
        
        if not p1 then
            p1 = p0:Clone()
        end

        local w1 = p1:FindFirstChild("WedgeMesh")
        if not w1 then
            w1 = mesh:Clone()
            w1.Parent = p1
        end
        
        w1.Scale = V3n(0, perp / sz, difPara / sz)
        p1.CFrame = cf1
        
        return p0, p1
    end

    function drawQuad(v1, v2, v3, v4, parts)
        parts[1], parts[2] = drawTriangle(v1, v2, v3, parts[1], parts[2])
        parts[3], parts[4] = drawTriangle(v3, v2, v4, parts[3], parts[4])
    end
end

local camera = workspace.CurrentCamera

local binds = { }
local coreFolder = Inew("Folder")

local function count(t)
    local n = 0
    for i in t do
        n += 1
        
    end
    
    return n
end

local function parent(a, b)
    if a.Parent ~= b then
        a.Parent = b
    end
end

local dof = Inew("DepthOfFieldEffect")
local light = game:GetService("Lighting")

dof.Name = "UIBlurEffect"
dof.Enabled = true
dof.FarIntensity = 0
dof.InFocusRadius = 50
dof.NearIntensity = 0.4
dof.FocusDistance = 51.6

local lib
local uis = game:GetService("UserInputService")
local isPC = uis.KeyboardEnabled and uis.MouseEnabled and not uis.TouchEnabled

local prevCamera, prevCameraEvent
local f; f = function()
    qualityLevel = ugs.SavedQualityLevel.Value
    camera = workspace.CurrentCamera or camera
    
    local blurEnabled = isPC and qualityLevel > 7
    lib.BlurringEnabled = blurEnabled
    
    if camera ~= prevCamera then
        prevCamera = camera
        
        if prevCameraEvent then
            prevCameraEvent:Disconnect()
        end
        
        prevCameraEvent = camera.Changed:Connect(f)
    end

    local enabled = blurEnabled and count(binds) ~= 0
    if enabled then
        enabled = false
        for i, v in binds do
            if v[6] then
                enabled = true
                break
            end
        end
    end
    
    local par = enabled and camera or nil
    if not pcall(parent, coreFolder, par) then
        coreFolder = Inew("Folder")
        pcall(parent, coreFolder, par)
    end
    
    coreFolder.Name = "UIBlur"
    
    for i, v in binds do
        pcall(parent, v[2], coreFolder)
    end
    
    par = enabled and light or nil
    if not pcall(parent, dof, par) then
        dof = Inew("DepthOfFieldEffect")
        pcall(parent, dof, par)
    end

    dof.Name = "UIBlurEffect"
    dof.Enabled = true
    dof.FarIntensity = 0
    dof.InFocusRadius = 50
    dof.NearIntensity = lib.BlurSize * 0.4
    dof.FocusDistance = 51.6
end

workspace.Changed:Connect(f)
rs:Connect(f)

local sizeFix = V2n(6, 0)
local function updateOrientation(frame, parts)
    if not camera then return end
    
    local zIndex = 1 - 0.05 * frame.ZIndex
    local tl, br = frame.AbsolutePosition + sizeFix, frame.AbsolutePosition + frame.AbsoluteSize - sizeFix
    local tr, bl = V2n(br.X, tl.Y), V2n(tl.X, br.Y)
    
    do
        local rot = frame.AbsoluteRotation
        if rot % 180 ~= 0 then
            local mid = tl:Lerp(br, 0.5)
            local s, c = sin(rad(rot)), cos(rad(rot))
            local vec = tl
            
            tl = V2n(c * (tl.X - mid.X) - s * (tl.Y - mid.Y), s * (tl.X - mid.X) + c * (tl.Y - mid.Y)) + mid
            tr = V2n(c * (tr.X - mid.X) - s * (tr.Y - mid.Y), s * (tr.X - mid.X) + c * (tr.Y - mid.Y)) + mid
            bl = V2n(c * (bl.X - mid.X) - s * (bl.Y - mid.Y), s * (bl.X - mid.X) + c * (bl.Y - mid.Y)) + mid
            br = V2n(c * (br.X - mid.X) - s * (br.Y - mid.Y), s * (br.X - mid.X) + c * (br.Y - mid.Y)) + mid
        end
    end
    
    drawQuad(
        camera:ScreenPointToRay(tl.X, tl.Y, zIndex).Origin, 
        camera:ScreenPointToRay(tr.X, tr.Y, zIndex).Origin, 
        camera:ScreenPointToRay(bl.X, bl.Y, zIndex).Origin, 
        camera:ScreenPointToRay(br.X, br.Y, zIndex).Origin, 
        parts
    )
end

lib = {
    Bind = function(self, frame)
        if self:IsBinded(frame) then return binds[frame][7]() end
        
        local parts = { }
        local holderFolder = Inew("Folder", coreFolder)
        local binding = { frame, holderFolder, parts }
        
        local function refresh()
            if not pcall(parent, holderFolder, coreFolder) then
                holderFolder = Inew("Folder", coreFolder)
                binding[2] = holderFolder
            end
            
            local visible = frame.Visible
            if visible then
                local current = frame.Parent
                while current and current ~= game do
                    if current:IsA("GuiObject") and not current.Visible or current:IsA("ScreenGui") and not current.Enabled then
                        visible = false
                        break
                    end
                    
                    current = current.Parent
                end
                
                if visible and not current or current == game then
                    visible = current == game
                end
            end
            
            binding[6] = visible
            if not visible then
                for i, v in parts do
                    pcall(parent, v, nil)
                end
                
                return
            end
            
            for i, v in parts do
                if not pcall(parent, v, holderFolder) then
                    parts[i] = nil
                end
            end
            
            updateOrientation(frame, parts)

            for i, v in parts do
                if not pcall(parent, v, holderFolder) then
                    parts[i] = nil
                end
            end
            
            holderFolder.Name = "UIBlurHolder"
        end
        
        binding[4] = frame.Changed:Connect(refresh)
        binding[5] = rs:Connect(refresh)
        binding[6] = true
        binding[7] = refresh
        
        binds[frame] = binding
        
        refresh()
    end,
    IsBinded = function(self, frame)
        return frame ~= nil and binds[frame] ~= nil
    end,
    Unbind = function(self, frame)
        if not self:IsBinded(frame) then return end
        
        local binding = binds[frame]

        binding[1]:Destroy()
        binding[2]:Destroy()
        for i, v in binding[3] do
            v:Destroy()
        end
        
        binding[4]:Disconnect()
        binding[5]:Disconnect()
        binding[6] = nil
        binding[7] = nil
        
        binds[frame] = nil
    end,
    UnBind = function(self, frame)
        return self:Unbind(frame)
    end,
    BlurSize = 1,
    BlurringPossible = isPC,
    BlurringEnabled = isPC and qualityLevel > 7
}

return lib
    end;

    modules[objects["Instance18"]] = function(...)
        local script = objects["Instance18"];
local env = getfenv()
local function g(n)
    return env[n]
end

local global = (g("getgenv") or function() return _G end)()
local n = "EventLib1"

if global[n] then
    return global[n]
end

local pack = table.pack
local error = error
local spawn = task.spawn
local freeze = table.freeze
local smt = setmetatable
local insert = table.insert
local remove = table.remove
local rawset = rawset
local unpack = table.unpack
local defer = task.defer
local delay = task.delay

local quick = Instance.new("BindableEvent") -- only for instant :Wait response
local quickEvent = quick.Event

local connectionBase = {
    Disconnect = function(self)
        if self.Connected then
            rawset(self, "Connected", false)
            freeze(self)

            self.Parent:Cleanup()
        end
    end,
    Fire = function(self, ...)
        if not self.Enabled or not self.Connected or not self.Parent.Enabled then return end
        spawn(self.Callback, ...)
    end
}

connectionBase = { __index = connectionBase, __tostring = function() return "Connection" end, __newindex = function(self, key, value) if key ~= "Enabled" then error() end rawset(self, key, value) end }
local eventBase = {
    Connect = function(self, func)
        local connection = smt({ Callback = func, Connected = true, Enabled = true, Parent = self }, connectionBase)
        insert(self._Connections, connection)

        return connection
    end,
    Once = function(self, func)
        local con; con = self:Connect(function(...)
            con:Disconnect()
            con = nil

            func(...)
        end)

        return con
    end,
    Wait = function(self)
        local result
        self:Once(function(...)
            result = pack(...)
            quick:Fire()
        end)

        repeat quickEvent:Wait() until result
        return unpack(result, 1, result.n)
    end,
    Cleanup = function(self) -- usually not needed to be called manually
        local cons = self._Connections
        local i, ln = 1, #cons

        while i <= ln do
            if not cons[i] or not cons[i].Connected then
                remove(cons, i)
                ln -= 1
            else
                i += 1
            end
        end
    end,

    Fire = function(self, ...)
        self:Cleanup()

        local cons = self._Connections
        for i = 1, #cons do
            if cons[i] then
                cons[i]:Fire(...)
            end
        end
    end,
    DisconnectAll = function(self)
        for i, v in self._Connections do
            v:Disconnect()
        end
    end
}

eventBase = { __index = eventBase, __tostring = function() return "Event" end, __newindex = function(self, key, value) if key ~= "Enabled" then error() end rawset(self, key, value) end }
local lib = setmetatable({
    new = function()
        return smt({ _Connections = { }, Enabled = true }, eventBase)
    end,
    RaceEvents = function(self, ...)
        local events = { ... }
        if typeof(events[1]) == "table" then
            events = events[1]
        end

        if #events == 0 then return end
        if #events == 1 then return events[1]:Wait() end

        local result, winner
        local connections = { }

        for i, v in events do
            connections[#connections + 1] = v:Once(function(...)
                for i, v in connections do
                    v:Disconnect()
                end

                winner = i
                result = pack(...)
                quick:Fire()
            end)
        end

        repeat quickEvent:Wait() until result

        insert(result, 1, winner)
        return unpack(result, 1, result.n + 1)
    end,
    RaceEventsWithTimeout = function(self, events, timeout)
        local timeoutEvent = self.new()
        events[#events + 1] = timeoutEvent
        
        delay(timeout, timeoutEvent.Fire, timeoutEvent)
        
        local racing = pack(self:RaceEvents(events))
        local winner = remove(racing, 1)
        racing.n -= 1
        
        return winner ~= #events, racing
    end
}, freeze({ __call = function(self, ...) return self.new(...) end }))
global[n] = lib

local clock, fakeClock, deferClock = lib.new(), lib.new(), lib.new()
local race = lib.RaceEvents
local rs = game:GetService("RunService")
local r1, r2, r3 = rs.RenderStepped, rs.Heartbeat, rs.Stepped
local last = tick()
local fire = clock.Fire
local maxDefer = 10

clock:Connect(function(isDefer, dontFire)
    local current = tick()
    fakeClock:Fire(current - last, isDefer)
    last = current

    if dontFire then return end

    race(clock, r1, r2, r3)
    fire(clock, false, false)
    delay(0, fire, clock, false, true)

    for i = 1, maxDefer do
        defer(fire, deferClock)
        deferClock:Wait()

        if i <= 3 or i == 10 or i == maxDefer then
            fire(clock, true, true)
        end
    end
end)

rawset(lib, "Clock", fakeClock)
freeze(lib)
fire(clock, false)

return lib
    end;

    modules[objects["Instance24"]] = function(...)
        local script = objects["Instance24"];
local U2n = UDim2.new
local rawset = rawset
local tick = tick
local spawn = task.spawn
local wait = task.wait
local error = error
local max = math.max
local inew = Instance.new
local find = table.find
local remove = table.remove
local typeof = typeof
local newproxy = newproxy
local tonumber = tonumber

local sizeU = UDim2.fromScale(1, 1)

local centerV = Vector2.new(0.5, 0.5)
local centerU = UDim2.fromScale(0.5, 0.5)

local HQimageSizeLimit = 1024
local LQImageSizeLimit = 512

local function prepareInstances()
    local canvas = inew("CanvasGroup")
    canvas.BackgroundTransparency = 1
    canvas.Name = "BlurShader"
    canvas.Size = sizeU
    canvas.AnchorPoint = centerV
    canvas.Position = centerU

    local downsampler = inew("Frame", canvas)
    downsampler.Name = "Downsampler"
    downsampler.Size = sizeU
    downsampler.AnchorPoint = centerV
    downsampler.Position = centerU
    downsampler.BackgroundTransparency = 1
    downsampler.ClipsDescendants = false

    local fullQuality = downsampler:Clone()
    fullQuality.Name = canvas.Name

    return canvas, downsampler, fullQuality
end

local intensityTweenCache = { }
local function lerp(a, b, t)
    return a + (b - a) * t
end

local function tween(options)
    local myid = options.id

    if options.duration <= 0 then
        options.callback(options.target)
        return
    end

    while options.id == myid do
        local t = (tick() - options.start) / options.duration
        if t >= 1 or t < 0 then
            break
        end

        options.callback(lerp(options.old, options.target, t))
        wait()
    end

    if options.id == myid then
        options.callback(options.target)
    end
end

local proxyToData = { }
local function newidx(self, a, b)
    self = proxyToData[self]

    if not self then error("Unknown error", 0) end
    if a == "_i" then error("Use 'Intensity' instead of '_i'!", 0) end
    if a == "_d" then error("Please use the 'Destroy' method instead!", 0) end

    if self._d then return end

    local old = self[a]
    rawset(self, a, b)

    if a == "Intensity" and old ~= b then
        local t = intensityTweenCache[self] or { id = -1, callback = function(v)
            rawset(self, "_i", v)
        end }

        intensityTweenCache[self] = t
        t.id += 1
        t.old = -- old
            self._i
        t.target = b
        t.duration = tonumber(self.Smooth) or self.Smooth and 0.5 or 0
        t.start = tick()

        spawn(tween, t)
    end
end

local uiBlurs = { }
local lib

local uiBlur = {
    Destroy = function(self)
        if self._d or not proxyToData[self] then return end

        proxyToData[self]._d = true
        self.Holder:Destroy()
        self.HQHolder:Destroy()

        for i, v in self.Instance:GetChildren() do
            v.Parent = self.Parent
        end

        self.Instance:Destroy()

        local found = find(uiBlurs, self)
        if found then
            remove(uiBlurs, found)
        end

        proxyToData[self] = nil
        intensityTweenCache[self] = nil
    end
}

local function idx(self, a)
    local self = proxyToData[self]
    if not self then
        if a == "_d" then
            return true
        end

        error("Unknown error", 0)
    end

    return uiBlur[a] or self[a]
end

local camera = workspace.CurrentCamera or Instance.new("Camera")
local vps = camera.ViewportSize

local getParentSize; function getParentSize(parent)
    if not parent then return vps end
    if parent:IsA("GuiBase2d") then return parent.AbsoluteSize end
    return getParentSize(parent.Parent)
end

local imageSizeLimit = HQimageSizeLimit

local ugs = UserSettings():GetService("UserGameSettings")
local qualityLevel = ugs.SavedQualityLevel.Value
local prevQ = -1

local function blurRefresh(v, newQ)
    local extraPx = lib.Enabled and v.Enabled and v._i > 0 and v._i * imageSizeLimit or 0
    if extraPx > 0 then
        local parentSize = getParentSize(v.Parent)
        local neededScale = max(imageSizeLimit - max(parentSize.X, parentSize.Y), 0) + extraPx

        v.HQHolder.Parent = nil
        v.Holder.Parent = v.Parent
        v.Instance.Parent = v.Holder

        v.Holder.Size = U2n(1, neededScale, 1, neededScale)
        v.Instance.Size = U2n(1, -neededScale, 1, -neededScale)
    else
        v.Holder.Parent = nil
        v.HQHolder.Parent = v.Parent
        v.Instance.Parent = v.HQHolder

        v.Instance.Size = sizeU
    end
end

local rs = game:GetService("RunService")
local se = rs.RenderStepped
local newQFlag

rs.PreRender:Connect(function()
    camera = workspace.CurrentCamera or camera
    vps = camera.ViewportSize
    
    qualityLevel = ugs.SavedQualityLevel.Value
    imageSizeLimit = qualityLevel > 3 and HQimageSizeLimit or LQImageSizeLimit
    
    local newQ = (qualityLevel > 3) ~= (prevQ > 3)
    prevQ = qualityLevel
    newQFlag = newQFlag or newQ
    
    if qualityLevel > 3 then
        for _, v in uiBlurs do
            spawn(blurRefresh, v, newQ)
        end
    end
end)

spawn(function()
    local ev = rs.Stepped
    local evRep = 1
    
    while true do
        if qualityLevel > 3 or #uiBlurs == 0 then wait() else
            for _, v in uiBlurs do
                local i = v._i
                if v._p ~= i or newQFlag then
                    proxyToData[v]._p = i
                    spawn(blurRefresh, v, newQFlag)
                end
                
                for i = 1, evRep do ev:Wait() end
            end
        end
        
        newQFlag = false
    end
end)

local function newBlurObject(name, parent)
    camera = workspace.CurrentCamera or camera
    vps = camera.ViewportSize

    qualityLevel = ugs.SavedQualityLevel.Value
    imageSizeLimit = qualityLevel > 3 and HQimageSizeLimit or LQImageSizeLimit

    local newQ = (qualityLevel > 3) ~= (prevQ > 3)
    prevQ = qualityLevel
    newQFlag = newQFlag or newQ
    
    local a, b, c = prepareInstances()
    a.Name = name or a.Name
    c.Name = a.Name

    local data = { Intensity = 0, _i = 0, _p = 0, Smooth = true, Enabled = true, _d = false, Instance = b, Holder = a, HQHolder = c, Parent = parent }
    local proxy = newproxy(true)
    local meta = getmetatable(proxy)
    meta.__newindex = newidx
    meta.__metatable = "UIBlur"
    meta.__index = idx

    proxyToData[proxy] = data
    uiBlurs[#uiBlurs + 1] = proxy
    blurRefresh(proxy)

    return proxy
end

lib = {
    new = function(parent, objects, name)
        local obj = newBlurObject(name, parent)
        if typeof(objects) == "table" then
            local set = false
            for _, v in objects do
                v.Parent = obj.Instance

                if not set and v:IsA("GuiObject") then
                    set = true
                    obj.Holder.ZIndex = v.ZIndex
                    obj.HQHolder.ZIndex = v.ZIndex
                end
            end
        end

        blurRefresh(obj)
        return obj
    end,
    Enabled = true
}

return lib
    end;
end;

-- YOUR CODE DOWN HERE --

local obj = objects["Instance0"];
