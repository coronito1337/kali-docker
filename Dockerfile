FROM kalilinux/kali-rolling:latest
RUN apt update && apt upgrade -y && apt install -y && apt full-upgrade -y
# Install basic utilities
RUN apt install openvpn sed wget curl nano python3-pip python3 iputils-ping bc dkms tmux zsh net-tools -y
# Install testing tools
RUN apt install enum4linux metasploit-framework john hydra git stegseek steghide  gobuster sublist3r masscan enum4linux hashcat nmap ncat  -y
RUN mkdir /tools
RUN git clone https://github.com/ticarpi/jwt_tool.git /tools/jwt_tool
RUN cd /tools/jwt_tool ; pip3 install -r requirements.txt ; echo "alias jwt_tool=python3 /tools/jwt_tool/jwt_tool.py"
# Install go and Nuclei
RUN wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz -O /tmp/go1.21.5.linux-amd64.tar.gz
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/go1.21.5.linux-amd64.tar.gz
RUN echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
RUN /usr/local/go/bin/go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
# Start terminal customization
RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
RUN wget https://raw.githubusercontent.com/coronito1337/pentester-theme/main/pentest.zsh-theme -O ~/.oh-my-zsh/themes/pentest.zsh-theme
RUN sed -i -e 's/robbyrussell/pentest/g' ~/.zshrc
RUN git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/plugins/zsh-syntax-highlighting
RUN git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.oh-my-zsh/plugins/fast-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/plugins/zsh-completions
RUN sed -i -e 's/plugins=(git)/plugins=(tmux git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-completions)/g' ~/.zshrc
RUN echo 'set-option -g default-shell "/usr/bin/zsh"' > ~/.tmux.conf
RUN echo 'set -g mouse on' >> ~/.tmux.conf
# Change Tmux control to CTRL+q
RUN printf 'set -g prefix C-q\nunbind-key C-b\nbind-key C-q send-prefix' >> ~/.tmux.conf
# Have new tmux windows & splits be on current directory
RUN printf 'bind c new-window -c "#{pane_current_path}"\nbind F1 split-window -h -c "#{pane_current_path}"\nbind F2 split-window -v -c "#{pane_current_path}"'
RUN touch ~/.hushlogin
# Remove terminal bell sound - as per Diogo request :)
RUN sed -i -e 's/# set bell-style none/set bell-style none/g' /etc/inputrc
# Expose commonly necessary ports
EXPOSE 8000:8000
EXPOSE 1337:1337
WORKDIR /root
ENTRYPOINT tmux