FROM archlinux

RUN pacman -Syyu --needed --noconfirm base-devel binutils sudo zsh \
	&& echo "%builder ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/builder \
	&& sed -e 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' -i /etc/locale.gen \
	&& locale-gen \
	&& echo "LANG=en_US.UTF-8" > /etc/locale.conf \
	&& mkdir -p /home/builder/ \
	&& useradd builder \
	&& chown builder:builder /home/builder

COPY build  /usr/bin/build

WORKDIR /home/builder/
COPY . /home/builder
RUN chown -R builder:builder /home/builder

USER builder

ENTRYPOINT ["/usr/bin/build"]
