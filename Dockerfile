FROM	adoptopenjdk/openjdk12
RUN	apt-get update	\
	&& apt-get install -y	\
		autoconf	\
		automake	\
		cmake	\
		gcc-multilib	\
		git	\
		golang	\
		libaio-dev	\
		libapr1-dev	\
		libtool	\
		libssl-dev	\
		make	\
		ninja-build	\
		tar
ENV	MAVEN_VERSION	3.6.1
RUN	curl -s http://www-us.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar -xz
ENV	PATH		/apache-maven-${MAVEN_VERSION}/bin:${PATH}
WORKDIR	netty
ADD	.	./
RUN	git clone -b netty-tcnative-parent-2.0.25.Final https://github.com/netty/netty-tcnative.git
RUN	mvn install -am -Dmaven.test.skip=true
RUN	mvn test -pl "transport-native-epoll"
