# Ubuntu 20.04 ベースのコンテナ
FROM ubuntu:22.04

# 必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
  bash \
  git \
  python3 \
  python3-pip \
  && rm -rf /var/lib/apt/lists/*

# ユーザー追加+ワークスペース作成
# load arguments from .env and docker-compose.yml
ARG UID GID USERNAME GROUPNAME PASSWORD
ARG HOME=/home/$USERNAME
RUN groupadd -g $GID $GROUPNAME && \
  useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
  echo $USERNAME:$PASSWORD | chpasswd \
  # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
  && apt-get update \
  && apt-get install -y sudo \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
  && chmod 0440 /etc/sudoers.d/$USERNAME
USER $USERNAME
WORKDIR $HOME

# COPY --chown=$USERNAME:$GROUPNAME requirements.txt .
# RUN pip install -r requirements.txt

# デフォルトのシェルを bash に設定
CMD ["/bin/bash"]