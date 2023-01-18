import os, subprocess

def pub():
  subprocess.run(["fvm flutter pub get"], shell=True)

def run(
  target="./lib/main.dart",  
  mode="debug",
  device="",
  verbose=False,
):
  pub()

  options = ["--" + mode]
  if verbose: options.append("--verbose")
  if device: options.append("-d {device}")
  exec = "fvm flutter run -t {target} {' '.join(options)}"

  print(exec)
  os.system(exec)