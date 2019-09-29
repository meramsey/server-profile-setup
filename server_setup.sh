#!/bin/bash
## Author: Michael Ramsey
## Objective Set Bash profiles timezone and add public keys
## How to use.
# ./server_setup.sh
# sh server_setup.sh

### Configure

#Define timezone: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
Timezone="America/Detroit"

#GitProvider to fetch public keys (gitlab.com,github.com)
GitProvider="gitlab.com"
GitUsername="mikeramsey"

PUB_KEY="ssh-rsa AAAAB3NzaC1yc2EAAAABIwAABAEAouV8izMKA9UPxOAeo0k1LoxFY3MjPT7uv0fMpgSvNSjK2hRcTAqD4FIFh/YHojnO921zoZii6j2tNK4Km0tvTSKGKn4IhF1JR7AFxzyTWBrD/G0MOhndlNgFdsPFZzw72tY3xmLUIPd9kkCfCH0tcAXxSWgRx2oc6d4Krr0gBAQODdnj6FVH6MrGuffaigXpyXbZ0MtVda+u0y3ffx+sbisUo8XGuZhwMcZumX5qdkxsTB/PLGGtOerSBbWaEhSfLhENxgxpkZW1trwzgTMmtLr4d2WQIwWSAoRTnE5PEQ8voOFP9ZHP07RP95pSWDprfBkY2fi8OIDXKczq6zMsdw2A4FjDWwkTVyD0TH6knUojdM23xv+afzghPOhAJOhd8tW5mBrChec5z9+3RKAQ2auaJ6l+0RdfIN40Xn+Cjnz7sKRTl7xluh/82saJmtVmnDsBx5K8KDNTy88LI9X57xdro1w2EKAKiW27hZqTRrdPWV1PPDg7P/f+lqf3X9uNFAEZtwi9UU8CJMjNp1gp/QekCXq5mQZiu8Cjvj8IYDbv8N86UfO439o7UvKV+wyBBbSMxRE3W7O956Xs2SQV6PCfxHosz11F94mJjsz/6f1tkd9+JKe8j0PtDc8Ed39A/78AxS0Ia+SW+nKNloHa54GxCGS6+S9hWtgHqRG/SrYNVyoX3P9c/eqqSXAOFI+N6pEYh32LEadjEtt7h+cQ7z7BnRXe++LbU+mMA8TkLPG7PFFuRn2JQzGfMC1TlLOcq/UsPXCPGfr0WF1QHKpFxxXD64U0rqEiSHyvNLek32Ibt+WpTwfyPHYqSID0SWeUL9trFQN/iPogJQj4fFO80YoBsQ+OuJ4JeRQwrw9veeSvkpcIy60wMaAorCcsHQPj7aA2eawQZGgLjij5qzrmYVSOSevW+m3Zs3ryh3v1VRHzFFq7UeZk0QknE+0rF/sGJvegEFhDu45PJiSDnttz1KrGEO7r+Fmauhf6nwQqtVAXLfKc2vtSJZTO0JSJELNdI1y4D/yKjh2Zfp3M8P6Bek4CtP2RENlpO9aFN7CXo9dtJZIMddUqgnNrYeLWQA8fJ6uTPErmh7RBrGIbc+OQbEMUcxyYOfCrASUlpO411/iPD30Px0JFIbd3gUhvr6yYKdQoLrKzzxyBY+i1UcEMb0TUKkHWTYavZWemv7z8BNvQi3zbAB5Z+6XQR3kdWr8Z8NYw+gJHLR2OHn9HW76UkaoH9Hyv8UhxLSwMKmYjXTKf+x18yalG5Vhim4dqaBGopr62CGxFQ7ch60AF++FLPKedzcqAP1eMhlP2slllq0OLaTNC4bK5VQG4gfFr7rNBJeyuAnWH7Q9rH87tGXj6uw== mikeramsey-8192"

### Stop Configuring

# Colorize Bash terminal : create your profile http://ezprompt.net/
echo 'export PS1="[\[\e[31m\]\u\[\e[m\]\[\e[33m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\]:\[\e[35m\]\w\[\e[m\]]\\$ "' >> /etc/profile.d/bash_prompt.sh && source /etc/profile.d/bash_prompt.sh;

#Set Timezone in .bashrc
echo "Before: $(date)" && export TZ="/usr/share/zoneinfo/${Timezone}" && echo "export TZ="/usr/share/zoneinfo/${Timezone}"" >> ~/.bashrc && echo "After: $(date)"

#Set Global Timezone forcefully
ln -sf /usr/share/zoneinfo/${Timezone} /etc/localtime

#Add Public Key to server without duplication
#umask 0077 ; mkdir -p ~/.ssh ; grep -q -F \"$PUB_KEY\" ~/.ssh/authorized_keys 2>/dev/null || echo \"$PUB_KEY\" >> ~/.ssh/authorized_keys

#Add Public keys from gitprovider for user to authorized keys
mkdir -p ~/.ssh ; curl https://${GitProvider}/${GitUsername}.keys | tee -a ~/.ssh/authorized_keys

echo 'Completed Configuration'