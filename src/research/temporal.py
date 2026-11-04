"""Order-preserving explicit-offset millisecond dateTime profile for CPM.

Accept only the documented lexical subset, convert to exact UTC milliseconds,
and retain the type/encoding profile in adapter metadata. The finite supported
UTC interval is 1970-01-01 through 2100-12-31. This is not arbitrary XSD dateTime.
"""
from datetime import datetime,timedelta,timezone
import re

UTC=timezone.utc
EPOCH=datetime(1970,1,1,tzinfo=UTC)
LAST=datetime(2100,12,31,23,59,59,999000,tzinfo=UTC)
delta=LAST-EPOCH
MIN_MS=0
MAX_MS=delta.days*86400000+delta.seconds*1000+delta.microseconds//1000
PROFILE='explicit-offset-UTC-milliseconds-1970-2100-v1'
PATTERN=re.compile(r'^([0-9]{4})-([0-9]{2})-([0-9]{2})T([0-9]{2}):([0-9]{2}):([0-9]{2})(?:\.([0-9]{1,3}))?(Z|[+-][0-9]{2}:[0-9]{2})$')

class UnsupportedDateTime(ValueError):pass

def to_milliseconds(value):
    if type(value) is not str:raise UnsupportedDateTime('dateTime must be text')
    match=PATTERN.fullmatch(value)
    if not match:raise UnsupportedDateTime('Require explicit timezone and zero to three fractional second digits')
    yy,mo,dd,hh,mi,ss,fraction,offset=match.groups()
    try:
        if offset=='Z':tz=UTC
        else:
            oh,om=int(offset[1:3]),int(offset[4:6])
            if oh>14 or om>59 or (oh==14 and om):raise UnsupportedDateTime('Timezone outside XSD offset bound')
            minutes=(oh*60+om)*(1 if offset[0]=='+' else -1)
            tz=timezone(timedelta(minutes=minutes))
        instant=datetime(int(yy),int(mo),int(dd),int(hh),int(mi),int(ss),int((fraction or '').ljust(3,'0') or 0)*1000,tzinfo=tz).astimezone(UTC)
    except ValueError as exc:raise UnsupportedDateTime('Unsupported or invalid calendar/time value') from exc
    if not EPOCH<=instant<=LAST:raise UnsupportedDateTime('UTC instant outside supported 1970..2100 interval')
    d=instant-EPOCH
    return d.days*86400000+d.seconds*1000+d.microseconds//1000

def from_milliseconds(value):
    if type(value) is not int or not MIN_MS<=value<=MAX_MS:raise UnsupportedDateTime('Millisecond value outside supported exact integer domain')
    return (EPOCH+timedelta(milliseconds=value)).isoformat(timespec='milliseconds').replace('+00:00','Z')

def domain():return {'type':'int','min':MIN_MS,'max':MAX_MS}
