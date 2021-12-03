import dbus

"""
dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2
org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'
"""

class Py3status:
    def spotify_current(self):
        current = "-"
        try:
            data = get_data()
            current = "{} - {}".format(data['artist'], data['title'])
        except:
            pass
        return {
            'full_text': '{}'.format(current),
            'cached_until': self.py3.time_in(1)
        }

def get_data():
    bus = dbus.SessionBus()
    proxy = bus.get_object('org.mpris.MediaPlayer2.spotify', '/org/mpris/MediaPlayer2')
    props_iface = dbus.Interface(proxy, dbus_interface='org.freedesktop.DBus.Properties')
    props = props_iface.GetAll("org.mpris.MediaPlayer2.Player")


    artist = str(props[u'Metadata'][u'xesam:artist'][0])
    title = str(props[u'Metadata'][u'xesam:title'])

    ret = {
        'artist': artist,
        'title': title,
    }
    return ret

def main():
    print(get_data())


if __name__ == "__main__":
    main()
