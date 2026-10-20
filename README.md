# Plant-Box-App

This repository contains a small browser-based setup and status page for the
plant-light project. It is a static website: the interface is in `index.html`,
and the plant, plant-type, and growth-stage data are in `plants_database.db`.
There is no application server or package installation step.

## What the website does

- Loads plant names and growth stages from the local SQLite database.
  (Source: https://plantlightdb.com/)
- Lets you enter Wi-Fi, WeatherAPI, location (automatically loaded), time-zone code 
  (initially chosen using location), schedule, and servo movement settings.
- Calculates plant light targets and shows the configuration JSON before it is
  sent.
- Connects to a compatible BLE controller to read current settings and status,
  send configuration, or request an optimization.
- Restores saved controller settings into the form after connecting.
- Displays connection, photoperiod, servo state, and optimization progress,
  including the time since the previous and until the next optimization.

The page is a setup and monitoring interface, not a continuously hosted
application: once the configuration has been sent, the ESP32 runs the control
loop independently.

## How the website works

`index.html` contains the page layout, styling, and JavaScript logic.
On page load, it loads the `sql.js` WebAssembly library from jsDelivr, fetches
`plants_database.db` from the same folder, and reads the `plants`, `types`, and
`stages` tables. The database currently holds the plant profiles and their
DLI ranges. The selected stage supplies a photoperiod where available; a
default stage uses the plant type's photoperiod.

The page applies its stage/type adjustment rules to the database DLI range,
then builds a JSON preview with the selected profile and the entered hardware
and location settings. Location and time zone can be suggested by the
browser, but you can edit them manually. A location permission or lookup
failure does not prevent manual entry.

For the `Mature/Active/Default` stage, which has no stage-specific photoperiod,
the page uses the plant type's photoperiod from the database (or 12 hours if
there is no matching type). Seedling and vegetative stages apply the page's
type-based DLI reductions; other stages use the database DLI range as listed.
The resulting target is a project estimate, not horticultural advice.

The BLE code uses the browser's Web Bluetooth API. It reads the controller's
JSON status, maps that data into the form, writes the configuration as
20-byte chunks, and periodically refreshes status while connected. The
**Optimize Now** action sends a separate manual request. BLE requires a secure
browser context (HTTPS, or `localhost` for local development) and a browser
or compatible BLE-reader integration that supports the page's Bluetooth flow.

## Open the website on a computer

### Local testing

1. Install Python 3 if it is not already available.
2. Open a terminal in this repository's folder (the folder containing
   `index.html` and `plants_database.db`).
3. Start a simple local web server:

   ```text
   py -m http.server 8000
   ```

   If `py` is unavailable, use `python -m http.server 8000`.
4. Open `http://localhost:8000` in a recent version of Chrome or Edge.
   `localhost` is treated as a secure context for local development.
5. To connect to the controller, turn on the computer's Bluetooth, select
   **Connect to ESP32**, and choose `Smart_Plant_Shade` in the browser prompt.

Keep the server terminal running while using the page. Stop it with
**Ctrl+C** when finished. Do not open `index.html` directly as a file; the
database fetch and Bluetooth security requirements need a web origin.

### Hosting

For access beyond the development computer, publish `index.html` and
`plants_database.db` together on a static HTTPS host. The database must remain
at the relative URL `plants_database.db` next to the page. The sql.js library
and its WebAssembly file are loaded from jsDelivr, so initial page setup also
requires internet access. On a computer, use a browser with Web Bluetooth
support and grant Bluetooth permission when prompted.

## Open the website on iOS

The website can be used on an iPhone or iPad, including its BLE setup and
status features, when it is opened through a compatible Bluetooth-reader
extension or app such as **Beacio**. Safari by itself does not provide the
Web Bluetooth connection used by this page.

1. Publish `index.html` and `plants_database.db` together at an HTTPS address;
   the page needs HTTPS for Bluetooth access and for fetching the database.
2. Open that address through Beacio's supported Bluetooth-reader workflow,
   following its current iOS setup instructions. Allow any Bluetooth or
   location permissions it requests.
3. Power the ESP32, enable Bluetooth on the iPhone or iPad, then tap
   **Connect to ESP32** and select `Smart_Plant_Shade` when prompted.
4. Review the saved settings and status. Edit the form and tap
   **Send Configuration to ESP32** to update the controller, or use
   **Optimize Now** to request an immediate scan.

Keep the reader app open while connected. The exact permission prompts and
connection flow depend on the iOS and Beacio versions. If the BLE controls are
unavailable, confirm that the page was opened inside the reader's supported
workflow rather than directly in Safari. This repository does not include a
native iOS app.

## Troubleshooting

- If plant choices do not load, confirm `plants_database.db` is beside
  `index.html`, the page is served over HTTP(S) rather than opened as a file,
  and the device can reach jsDelivr.
- If Bluetooth cannot connect, check that the ESP32 is powered and advertising
  as `Smart_Plant_Shade`, grant the reader/browser's Bluetooth permission, and
  disconnect other clients from the controller before retrying.
- If configuration does not arrive, stay near the ESP32, wait for the transfer
  to finish, and verify the form's JSON preview before sending again.
- If location is unavailable, enter latitude, longitude, and the POSIX time-zone
  rule manually. Location detection is optional for editing the form, but the
  controller needs valid location and time-zone settings for scheduled
  operation.

Wi-Fi credentials and the WeatherAPI key are sent directly to the controller
over BLE and saved there for operation. Use the page only with a trusted
controller and HTTPS host; do not publish real credentials, API keys, or
location details in screenshots or source files.

## How the two repositories connect

The website and the separate `Plant-Light-Controller` firmware communicate
directly over BLE; the website does not require an API server. It discovers
the ESP32 named `Smart_Plant_Shade` and uses the custom service and
characteristic below. Their UUIDs must match the firmware:

- Service: `3ffb09d6-6ba2-4d32-bc92-cbdaf9798ffa`
- Characteristic: `0dddf571-257c-4021-964b-a6fd9212384f`

The website sends plant selection and settings as JSON, including Wi-Fi,
WeatherAPI, location, schedule, and servo timings. It splits writes into
20-byte chunks for BLE. The firmware reassembles and parses the JSON, saves
valid settings, and controls the sensor and shades. On connection and during
status refresh, the website reads the firmware's JSON response to display
saved settings and live controller state. Keep the UUIDs, JSON property names,
and status layout consistent across the two repositories.

## Files and maintenance

- `index.html` — user interface, plant-target calculations, BLE connection,
  configuration, and status display.
- `plants_database.db` — SQLite database read by the page at runtime.
- `resources/plants_database_setup.sql` — SQL source for recreating the plant,
  type, and stage tables and seed data.

If the database is rebuilt or renamed, update the page's database fetch path
and verify that all three tables and the columns used by the page are present.
Do not put personal Wi-Fi passwords or API keys into the database or source
files; enter them through the page when configuring the device.