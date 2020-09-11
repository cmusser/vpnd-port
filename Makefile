# $FreeBSD$

PORTNAME=	vpnd
PORTVERSION=	1.2.0
CATEGORIES=	security
USE_GITHUB=	yes
GH_ACCOUNT=	cmusser
LIB_DEPENDS=	libsodium.so:security/libsodium

MAINTAINER=	cmusser@sonic.net
COMMENT=	Virtual private network daemon
USE_RC_SUBR=    vpnd

.include <bsd.port.mk>
