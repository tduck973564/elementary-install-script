#!/usr/bin/sh

# ElementaryOS Install Script by tduck973564
# Makes life a little bit easier

echo Adding Flathub to Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo Installation of GitHub CLI and setup of Git
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install -y gh
sh -c "gh auth login"
git config --global user.name "tduck973564"
git config --global user.email "tduck973564@gmail.com"

echo Installation of VSCode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code

echo Installation of Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain stable --profile default -y

echo Installation of Python
sudo apt install -y python
pip install --upgrade pip
pip install pylint

echo Installation of TypeScript and JavaScript
sudo apt install -y nodejs npm
sudo npm install -g typescript

echo Installation of C# and .NET
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb
sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-5.0

echo Installation of VSCode extensions
code --install-extension ms-python.python
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension vadimcn.vscode-lldb
code --install-extension icrawl.discord-vscode
code --install-extension matklad.rust-analyzer
code --install-extension serayuzgur.crates
code --install-extension bungcip.better-toml
code --install-extension emilast.LogFileHighlighter
code --install-extension CoenraadS.bracket-pair-colorizer-2
code --install-extension wakatime.vscode-wakatime
code --install-extension michelemelluso.code-beautifier
code --install-extension mrmlnc.vscode-scss
code --install-extension ritwickdey.liveserver
code --install-extension ritwickdey.live-sass
code --install-extension github.vscode-pull-request-github
code --install-extension eamodio.gitlens
code --install-extension ms-dotnettools.csharp

echo Installation of miscellaneous useful apps
sudo apt install -y ffmpeg pavucontrol pulseeffects
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:philip.scott/pantheon-tweaks
sudo apt install -y pantheon-tweaks
sudo flatpak install eddy

echo Installation of codecs
sudo apt install -y ubuntu-restricted-extras

echo Log into accounts on web browser
xdg-open https://accounts.google.com/
xdg-open https://login.microsoftonline.com/
xdg-open https://discord.com/app
xdg-open https://github.com/login

echo Make some folders
mkdir ~/Repositories
mkdir ~/Coding
mkdir ~/Games

echo
echo "When you are finished logging into your accounts, close the browser window."
echo "Your computer screen may start flickering. This is normal."
echo
read -p "Press ENTER to continue." nothing

echo Tweak battery life
sudo apt install -y tlp
sudo systemctl enable tlp
sudo tlp start
sudo apt install -y powertop
sudo powertop --calibrate
sudo powertop --auto-tune
sudo sh -c 'echo -e "[Unit]\nDescription=Powertop tunings\n\n[Service]\nExecStart=/usr/bin/powertop --auto-tune\nRemainAfterExit=true\n\n[Install]\nWantedBy=multi-user.target" > /etc/systemd/system/powertop.service'
sudo systemctl daemon-reload
sudo systemctl enable powertop
