import sys
import gi
import datetime

gi.require_version("Gtk", "4.0")
gi.require_version("Adw", "1")
from gi.repository import Gtk, Gio, Adw


class MainWindow(Gtk.ApplicationWindow):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        folder = Gio.File.new_for_path("/home/David/Pictures/screenshots")
        time = datetime.datetime.now().strftime("%e_%m_%Y-%H_%M_%S")
        f = Gtk.FileFilter.new()
        f.add_mime_type("image/*")

        self.open_dialog = Gtk.FileDialog.new()
        self.open_dialog.set_initial_folder(folder)
        self.open_dialog.set_initial_name(time + ".png")
        self.open_dialog.set_title("Save screenshot")
        self.open_dialog.set_default_filter(f)

        self.open_dialog.save(self, None, self.open_dialog_save_callback)

    def open_dialog_save_callback(self, dialog, result):
        file = dialog.save_finish(result)
        if file is not None:
            data = sys.stdin.buffer.read()
            with open(file.get_path(), "wb") as image:
                image.write(data)
        exit()


class MyApp(Adw.Application):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.connect("activate", self.on_activate)

    def on_activate(self, app):
        self.win = MainWindow(application=app)
        self.win.present()


app = MyApp(application_id="com.example.GtkApplication")
app.run(sys.argv)
