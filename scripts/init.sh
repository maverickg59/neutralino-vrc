#!/bin/bash

check_neu() {
  if ! command -v neu &> /dev/null; then
    echo "Neutralino CLI (neu) is not installed."
    read -p "Would you like to install it globally? (y/n): " install_neu
    if [[ "$install_neu" =~ ^[Yy]$ ]]; then
      npm install -g @neutralinojs/neu
      if ! command -v neu &> /dev/null; then
        echo "Installation failed. Please install the Neutralino CLI manually and try again."
        exit 1
      else
        echo "Neutralino CLI installed successfully."
      fi
    else
      echo "Neutralino CLI is required to run this application. Exiting..."
      exit 1
    fi
  else
    echo "Neutralino CLI is already installed."
  fi
}

check_neu

echo "Setting up Neutralino app..."

# Navigate to the Vite app directory
cd app

echo "Installing dependencies..."
npm install || { echo "Failed to install dependencies"; exit 1; }

# Go back to the root directory
cd ..

echo "Running Neutralino app in development mode..."
neu run -- --window-enable-inspector || { echo "Neutralino run failed"; exit 1; }
