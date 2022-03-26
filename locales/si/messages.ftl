-raw-not-in-call = කථන සංවාදයෙහි නැත.
-raw-not-streaming = Stream වන්නේ නැත.
-error = ❌ | <b>{ $t }</b>
-ok = ✅ | <b>{ $t }</b>
-response = { $e } | <b>{ $t }</b>
-not-in-call = { -error(t: "කථන සංවාදයෙහි නැත.") }
-not-streaming = { -error(t: "Stream වන්නේ නැත.") }
not-in-call = { -not-in-call }
not-streaming = { -not-streaming }
raw-not-in-call = { -raw-not-in-call }
errors = 
    .no-call = { -error(t: "සක්‍රීය කථන සංවාදයක් නොමැත.") }
    .no-video-found = { -error(t: "වීඩියෝව සොයා ගත නොහැක.") }
    .unknown = { -error(t: "කිසියම් දෝෂයක් මතු වී ඇත.") }
    .file-too-big = { -error(t: "මෙම ගොනුව තරමක් විශාලය.") }
    .no-assistant = { -error(t: "මගේ සහකරු මෙහි නොමැත.") }
    .error = { -error(t: "කිසියම් දෝෂයක් මතු වී ඇත:") } { $message }
inputs = 
    .audio-file = ශ්‍රව්‍ය ගොනුව
    .custom = අභිරුචි ආදානය
    .voice-message = හඩ පණිවුඩය
shuffle = 
    .shuffling = { -response(e: "🔀", t: "මිශ්‍ර කරමින් පවතී...") }
    .no-enough-items = { -error(t: "මිශ්‍ර කිරීමට තරම් ප්‍රමාණවත් අයිතම ගණනක් නොමැත.") }
cache = { -response(e: "🗑", t: "කෑෂ් ඉවත් කරන ලදි.") }
now = 🎵 | දැන් stream වන්නේ <b><a href="{ $titleUrl }">{ $title }</a></b> by <b><a href="{ $requesterUrl }">{ $requester }</a></b>...
panel = 
    .text =
        { $nowEmoji } | <b><a href="{ $nowUrl }">{ $now }</a></b>
        ➡️ | <b><a href="{ $nextUrl }">{ $next }</a></b>
    .updated = Updated.
    .nothing-now = කිසිවක් stream වන්නේ නැත.
    .nothing-next = මීළගට කිසිවක් stream වන්නේ නැත.
    .pause =
        { $result ->
            [true] තාවකාලිකව නතර කරනු ලැබේ.
            [false] { -raw-not-streaming }
           *[null] { -raw-not-in-call }
        }
    .resume =
        { $result ->
            [true] නැවත ආරම්භ වනු ලැබේ.
            [false] { -raw-not-streaming }
           *[null] { -raw-not-in-call }
        }
    .skip =
        { $result ->
            [true] මගහරිනු ලැබේ.
            [false] { -raw-not-streaming }
           *[null] { -raw-not-in-call }
        }
    .stop =
        { $result ->
            [true] නවත්වනු ලැබේ.
            [false] { -raw-not-streaming }
           *[null] { -raw-not-in-call }
        }
    .mute =
        { $result ->
            [true] නිශ්ශබ්ද කරනු ලැබේ.
            [false] දැනටමත් නිශ්ශබ්ද කර ඇත.
           *[null] { -raw-not-in-call }
        }
    .unmute =
        { $result ->
            [true] නිශ්ශබ්ද කර තැබීම අවසන් කරනු ලැබේ.
            [false] නිශ්ශබ්ද කර නොමැත.
           *[null] { -raw-not-in-call }
        }
    .shuffling = මිශ්‍ර කරමින් පවතී.
    .volume = හඩ { $amount } දක්වා වෙනස් කරනු ලැබුවා.
    .no-enough-items = මිශ්‍ර කිරීමට තරම් ප්‍රමාණවත් අයිතම ගණනක් නොමැත.
playlist = 
    .queuing = 🎶 | <b>{ $x } අයිතම ලැයිස්තුගත කරමින් පවතී...</b>
    .streaming-queuing = 🎶 | <b>Stream වෙමින් හා { $x } අයිතම ලැයිස්තුගත වෙමින් පවතී...</b>
volume = 
    .set = 🔈 | <b>{ $amount } දක්වා හඩ වෙනස් කරන ලදි.</b>
    .invalid = { -error(t: "0 ත් 200 ත් අතර අංකයක් ලබා දෙන්න.") }
lyrics = 
    .not-found = { -error(t: "ගී පද සොයාගත නොහැක.") }
    .lyrics =
        <b>{ $title }</b> #ගී පද
        
        { $lyrics }
search = 
    .canceled = { -ok(t: "සෙවීම නතර කරනු ලැබුවා.") },
    .no-results-found = { -error(t: "කිසිදු ප්‍රතිඵලයක් හමු වූයේ නැත.") }
    .active = { -error(t: "සක්‍රීය සෙවුමක් ක්‍රියාත්මක වෙමින් පවතී.") }
    .not_active = { -error(t: "සක්‍රීය සෙවුමක් ක්‍රියාත්මක වන්නේ නැත.") }
    .header = <b>🔍 | { $query } සදහා වන ප්‍රතිඵල...</b>
    .no-query = { -response(e: "❔", t: "ඔබට සෙවීමට අවශ්‍ය වන්නේ කුමක්ද?") }
    .footer = <i>Stream කිරීම සදහා ඔබට අවශ්‍ය ප්‍රතිඵලයට අදාල අංකය reply කරන්න. නැතහොත් /cancel ලෙස එවන්න.</i>
    .result =
        { $numberEmoji } <b><a href="{ $url }">{ $title }</a></b>
        { "  " }├ { $durationEmoji } { $duration }
        { "  " }├ 👁 { $views }
        { "  " }├ 📅 { $uploadTime }
        { "  " }└ 👤 { $uploader }
stream = 
    .streaming = { -response(e: "▶️", t: "Stream වෙමින් පවතී...") }
    .queued-at = #️⃣ | <b>ලැයිස්තුවේ { $position } වන ස්ථානයට ඇතුළත් කරන ලදි.</b>
    .no-input = { -response(e: "❔", t: "ඔබට stream කිරීමට අවශ්‍ය වන්නේ කුමක්ද?") }
pause =
    { $result ->
        [true] { -response(e: "⏸", t: "තාවකාලිකව නතර කරනු ලැබේ") }
        [false] { -not-streaming }
       *[null] { -not-in-call }
    }
resume =
    { $result ->
        [true] { -response(e: "▶️", t: "නැවත ආරම්භ වනු ලැබේ.") }
        [false] { -not-streaming }
       *[null] { -not-in-call }
    }
skip =
    { $result ->
        [true] { -response(e: "⏩", t: "මගහරිනු ලැබේ.") }
        [false] { -not-streaming }
       *[null] { -not-in-call }
    }
stop =
    { $result ->
        [true] { -response(e: "⏹", t: "නවත්වනු ලැබේ.") }
        [false] { -not-streaming }
       *[null] { -not-in-call }
    }
mute =
    { $result ->
        [true] { -response(e: "🔇", t: "නිශ්ශබ්ද කරනු ලැබේ.") }
        [false] { -error(t: "දැනටමත් නිශ්ශබ්ද කර ඇත.") }
       *[null] { -not-in-call }
    }
unmute =
    { $result ->
        [true] { -response(e: "🔈", t: "නිශ්ශබ්ද කර තැබීම අවසන් කරනු ලැබේ.") }
        [false] { -error(t: "නිශ්ශබ්ද කර නොමැත.") }
       *[null] { -not-in-call }
    }
loop =
    { $result ->
        [true] { -response(e: "🔁", t: "ලැයිස්තුව නැවත වතාවක් stream වනු ඇත.") }
       *[false] { -response(e: "🔁", t: "ලැයිස්තුව නැවත වතාවක් stream නොවනු ඇත.") }
    }
