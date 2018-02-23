% Very simply a function to select which sample to analyse
function out = fileSelection(i)

switch i 
    case 1
        out = 'ee.wav';
    case 2
        out = 'en.wav';
    case 3
        out = 'ew.wav';
    case 4
        out = 'had_f.wav';
    case 5
        out = 'had_f_short.wav';
    case 6
        out = 'had_m.wav';
    case 7
        out = 'head_f.wav';
    case 8
        out = 'head_m.wav';
    case 9
        out = 'heed_f.wav';
    case 10
        out = 'heed_m.wav';
    case 11
        out = 'hid_f.wav';  
    case 12
        out = 'hid_m.wav';
    case 13
        out = 'hod_f.wav';
    case 14
        out = 'hod_m.wav';
    case 15
        out = 'hood_f.wav';
    case 16
        out = 'hood_m.wav';
    case 17
        out = 'hud_f.wav';
    case 18
        out = 'oo.wav';
    case 19
        out = 'ss.wav';
    case 20
        out = 'warm_cloak.wav';
    case 21
        out = 'whod_f.wav';
    case 22
        out = 'whod_m.wav';
end