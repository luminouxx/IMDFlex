# IMDFlex

Apple IMDF 스펙을 준수하는 실내 지도 생성기

## 📋 프로젝트 정보

- **Bundle ID**: com.luminoux.imdflex
- **Xcode 버전**: 16.1
- **iOS 배포 타겟**: 18.0
- **Swift 버전**: 6.0

## 🏗️ 모듈 구조

### Core 모듈 (4개)
| 모듈 | 설명 | Bundle ID |
|-----|------|-----------|
| **Domain** | IMDF 도메인 모델, 비즈니스 로직 | `com.luminoux.imdflex.domain` |
| **Data** | Repository, 파일 시스템, 데이터 관리 | `com.luminoux.imdflex.data` |
| **MapEditor** | 맵 에디터 공유 컴포넌트 | `com.luminoux.imdflex.mapeditor` |
| **DesignSystem** | UI 컴포넌트, 디자인 시스템 | `com.luminoux.imdflex.designsystem` |

### Feature 모듈 (10개)
| Feature | 설명 | Bundle ID |
|---------|------|-----------|
| **Venue** | 장소 전체 영역 관리 | `com.luminoux.imdflex.venuefeature` |
| **Building** | 건물 관리 | `com.luminoux.imdflex.buildingfeature` |
| **Footprint** | 건물 외곽선 관리 | `com.luminoux.imdflex.footprintfeature` |
| **Level** | 층 관리 | `com.luminoux.imdflex.levelfeature` |
| **Unit** | 공간(방, 복도) 관리 | `com.luminoux.imdflex.unitfeature` |
| **Opening** | 출입구 관리 | `com.luminoux.imdflex.openingfeature` |
| **Amenity** | 편의시설 관리 | `com.luminoux.imdflex.amenityfeature` |
| **Occupant** | 입주자 관리 | `com.luminoux.imdflex.occupantfeature` |
| **Address** | 주소 관리 | `com.luminoux.imdflex.addressfeature` |
| **Project** | 프로젝트 관리 | `com.luminoux.imdflex.projectfeature` |

### Shared 모듈 (2개)
| 모듈 | 설명 | Bundle ID |
|-----|------|-----------|
| **Extensions** | Swift/SwiftUI Extensions | `com.luminoux.imdflex.extensions` |
| **Utils** | 공통 유틸리티 함수 | `com.luminoux.imdflex.utils` |

## 🚀 시작하기

### 프로젝트 생성
```bash
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

## 📦 의존성 구조

```
App
├── Core
│   ├── Domain
│   ├── Data (→ Domain)
│   ├── MapEditor (→ Domain, DesignSystem)
│   └── DesignSystem
├── Features (→ 모든 Core 모듈)
│   ├── Venue
│   ├── Building
│   ├── Footprint
│   ├── Level
│   ├── Unit
│   ├── Opening
│   ├── Amenity
│   ├── Occupant
│   ├── Address
│   └── Project
└── Shared
    ├── Extensions
    └── Utils
```

## 🛠️ 개발 가이드

### 새 모듈 추가
1. `Projects/` 아래 디렉토리 생성
2. `Project.swift` 파일 작성
3. `Workspace.swift`에 경로 추가
4. `tuist generate` 실행

### 테스트
```bash
# 전체 테스트
tuist test

# 특정 모듈 테스트
tuist test Domain
tuist test VenueFeature
```

## 📄 라이선스

Copyright © 2025 Luminoux. All rights reserved.
