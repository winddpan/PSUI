-- fake Toaster addon so that I can move the toasts location (why isnt this possible using a function in the library?)
SPSToaster = {};

function SPSToaster:SpawnPoint()
    return "BOTTOM";
end

function SPSToaster:SpawnOffsetX()
    return nil;
end

function SPSToaster:SpawnOffsetY()
    return nil;
end

function SPSToaster:TitleColors(urgency)
    return 0.510, 0.773, 1;
end

function SPSToaster:TextColors(urgency)
    return 0.486, 0.518, 0.541;
end

function SPSToaster:BackgroundColors(urgency)
    return 0, 0, 0;
end

function SPSToaster:Duration()
    return 10;
end

function SPSToaster:Opacity()
    return 0.75;
end

function SPSToaster:FloatingIcon()
    return false;
end

function SPSToaster:HideToasts()
    return false;
end

function SPSToaster:HideToastsFromSource(source_addon)
    return false;
end

function SPSToaster:MuteToasts(source_addon)
    return false;
end

function SPSToaster:MuteToastsFromSource(source_addon)
    return false;
end

function SPSToaster:IconSize()
	return 30;
end
