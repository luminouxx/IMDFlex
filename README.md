# IMDFlex

Apple IMDF 스펙을 준수하는 실내 지도 생성기

## 📋 프로젝트 정보

- **Bundle ID**: com.luminoux.imdflex
- **iOS 배포 타겟**: 18.0+
- **Swift 버전**: 6.0

## 🏗️ 아키텍처

Clean Architecture 기반 5개 모듈 구조

```
IMDFlex/
├── App/                    # 앱 진입점
│   └── Sources/
│
├── Presentation/           # UI 레이어
│   ├── MapEditor/          # 지도 편집 화면
│   └── ProjectList/        # 프로젝트 목록 화면
│
├── Domain/                 # 비즈니스 로직
│   ├── Entities/           # IMDF 모델 (Venue, Building, Level...)
│   └── UseCases/           # UseCase, Repository 프로토콜
│
├── Data/                   # 데이터 레이어
│   ├── Repositories/       # Repository 구현체
│   └── DataSources/        # 파일 I/O, JSON 파싱
│
└── DesignSystem/           # 공통 UI 컴포넌트
```

## 📦 의존성 구조

```
App
├── Presentation (→ Domain, DesignSystem)
├── Domain
├── Data (→ Domain)
└── DesignSystem
```

## 🚀 시작하기

### 프로젝트 생성
```bash
cd IMDFlex
tuist generate
```

### Xcode에서 열기
```bash
open IMDFlex.xcworkspace
```

### 빌드
```bash
tuist build
```

## 🛠️ 개발 가이드

### IMDF 엔티티

Domain 모듈에 정의된 주요 모델:

| 엔티티 | 설명 |
|--------|------|
| `Venue` | 실내 지도의 최상위 컨테이너 |
| `Building` | 건물 |
| `Level` | 층 |
| `Unit` | 공간 (방, 복도 등) |
| `Opening` | 출입구 |
| `Amenity` | 편의시설 |
| `Occupant` | 입주자 |

### 테스트

```bash
# 전체 테스트
tuist test

# 특정 모듈 테스트
tuist test Domain
tuist test Data
```

## 📄 라이선스

Copyright © 2026 Luminoux. All rights reserved.
