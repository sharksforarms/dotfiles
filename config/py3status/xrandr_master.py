import argparse
import sys
if sys.version_info.major == 2:
    from commands import getoutput
else:
    from subprocess import getoutput

class Py3status:
    def xrandr_master(self):
        brightness = get_brightness()
        brightness = int(brightness*100.0)
        return {
            'full_text': '\U0001F506 {}%'.format(brightness),
            'cached_until': self.py3.time_in(1)
        }

def get_display():
    display = getoutput('xrandr --current | grep " connected" | cut -f1 -d" "')
    return display.strip()

def get_brightness():
    brightness = getoutput('xrandr --current --verbose | grep "Brightness" | cut -f2 -d" "').strip()
    return float(brightness)

def inc_brightness(count):
    brightness = get_brightness()
    display = get_display()

    brightness += count
    brightness = max(min(brightness, 1), 0.1)
    getoutput('xrandr --output {} --brightness {}'.format(display, brightness))

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("inc", type=float, help="float value to increase/decrease by")

    args = parser.parse_args()

    inc_brightness(args.inc)

if __name__ == "__main__":
    main()
