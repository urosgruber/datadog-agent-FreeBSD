# $FreeBSD$

PORTNAME=	dd-agent
PORTVERSION=	5.5.2
CATEGORIES=	sysutils
PKGNAMEPREFIX=	${PYTHON_PKGNAMEPREFIX}

MAINTAINER=	uros@gruber.si
COMMENT=	Data Dog agent

LICENSE=        BSD4CLAUSE
LICENSE_FILE=   ${WRKSRC}/LICENSE

RUN_DEPENDS=    ${PYTHON_PKGNAMEPREFIX}boto>0:${PORTSDIR}/devel/py-boto \
		${PYTHON_PKGNAMEPREFIX}ntplib>0:${PORTSDIR}/net/py-ntplib \
		${PYTHON_PKGNAMEPREFIX}yaml>0:${PORTSDIR}/devel/py-yaml \
		${PYTHON_PKGNAMEPREFIX}simplejson>=2.1.1:${PORTSDIR}/devel/py-simplejson \
		${PYTHON_PKGNAMEPREFIX}requests>1:${PORTSDIR}/www/py-requests \
		${PYTHON_PKGNAMEPREFIX}tornado>0:${PORTSDIR}/www/py-tornado \
#		${PYTHON_PKGNAMEPREFIX}py-docker>0:${PORTSDIR}/devel/py-docker \
		${PYTHON_PKGNAMEPREFIX}supervisor>0:${PORTSDIR}/sysutils/py-supervisor

TEST_DEPENDS:=  ${RUN_DEPENDS} \
		${PYTHON_PKGNAMEPREFIX}mock>0:${PORTSDIR}/devel/py-mock \
		${PYTHON_PKGNAMEPREFIX}nose>0:${PORTSDIR}/devel/py-nose

USE_GITHUB=	yes
GH_ACCOUNT=	DataDog

USES=		python
USE_PYTHON=	autoplist distutils

PIDDIR?=	/var/run/${PORTNAME}
LOGDIR?=	/var/log/${PORTNAME}

SUB_FILES=	supervisord.conf
SUB_LIST=	PIDDIR=${PIDDIR} \
		LOGDIR=${LOGDIR} \
		PYTHON_SITELIBDIR=${PYTHON_SITELIBDIR} \
		PYTHON_CMD=${PYTHON_CMD}

PLIST_SUB=	PIDDIR=${PIDDIR} LOGDIR=${LOGDIR}

CONFFILES=	conf.d/*
CHECKFILES=	checks.d/*

PORTDOCS=	README.md CHANGELOG.md CONTRIBUTING.md LICENSE

OPTIONS_DEFINE= DOCS

post-patch:
		@${REINPLACE_CMD} -e 's|/etc/dd-agent|${ETCDIR}|g' ${WRKSRC}/config.py
		@${REINPLACE_CMD} -e 's|datadog.conf|../${PORTNAME}.conf|g' ${WRKSRC}/config.py
		@${REINPLACE_CMD} -e 's|/etc/dd-agent|${ETCDIR}|g' ${WRKSRC}/datadog.conf.example

post-install:
		${MKDIR} ${STAGEDIR}${ETCDIR}/conf.d
		${MKDIR} ${STAGEDIR}${PIDDIR}
		${MKDIR} ${STAGEDIR}${LOGDIR}
		${MKDIR} ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME}/checks.d

		${INSTALL_DATA} ${WRKSRC}/datadog.conf.example ${STAGEDIR}${PREFIX}/etc/${PORTNAME}.conf.sample
		${INSTALL_DATA} ${WRKSRC}/datadog-cert.pem ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME}

		${MKDIR} ${STAGEDIR}${DOCSDIR}

		${INSTALL_DATA} ${WRKDIR}/supervisord.conf ${STAGEDIR}${ETCDIR}

.for i in ${CHECKFILES}
		${INSTALL_DATA} ${WRKSRC}/${i} ${STAGEDIR}${PYTHON_SITELIBDIR}/${PORTNAME}/checks.d
.endfor

.for i in ${CONFFILES}
	        ${INSTALL_DATA} ${WRKSRC}/${i} ${STAGEDIR}${ETCDIR}/conf.d
.endfor

.for i in ${PORTDOCS}
		${INSTALL_DATA} ${WRKSRC}/${i} ${STAGEDIR}${DOCSDIR}
.endfor

regression-test: build
		@cd ${WRKSRC} && ${PYTHON_CMD} ${PYSETUP} test

.include <bsd.port.mk>
