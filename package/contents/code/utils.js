function diffTime(endTime) {
    const now = Date.now()

    const diff = endTime - now   // 毫秒差
    const totalSec = Math.max(0, Math.floor(diff / 1000))
    const hour = Math.floor(totalSec / 3600)
    const min = Math.floor((totalSec % 3600) / 60)

    return `${formatTen(hour)}:${formatTen(min)}`
}

function percent(startTime, endTime) {
    const now = Date.now()

    const total = endTime - startTime      // 总时长
    const elapsed = now - startTime           // 已过去
    const percent =  Math.min(100, Math.max(0, (elapsed / total) * 100))

    return Number(percent.toFixed(1))
}

function numberToTime(h, m){
    const date = new Date()
    date.setHours(h)
    date.setMinutes(m)

    return date
}

function formatTimeStr(h, m) {
    return `${formatTen(h)}:${formatTen(m)}`
}

function formatTen(v) {
    if (v >= 10) {
        return v
    }
    return `0${v}`
}
