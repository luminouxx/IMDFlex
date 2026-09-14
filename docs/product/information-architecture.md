# IMDFlex Information Architecture

이 문서는 IMDFlex의 전체 정보 구조를 정의한다. Lo-Fi Prototype, 사용자 흐름, Figma 화면, SwiftUI 구현은 이 문서를 공통 기준으로 사용한다.

## 1. 제품 정의

IMDFlex는 평면도를 실제 지도에 정렬하고, 층별 IMDF Feature와 관계를 작성하며, 문제를 검토·수정한 뒤 `imdf.zip`으로 내보내는 프로젝트 기반 전문 공간 편집기다.

핵심 작업은 다음과 같다.

```text
프로젝트 생성 또는 열기
→ 주소와 장소 설정
→ Venue와 Building 구성
→ Level 생성
→ 층별 평면도 등록·정렬
→ Feature Geometry 작성
→ Category와 속성 입력
→ Feature 관계 연결
→ 오류·경고·미완료 검토
→ 사용자가 직접 수정
→ IMDF ZIP 내보내기
→ 건물 변경 시 프로젝트 다시 열기
```

## 2. 최상위 IA

```text
IMDFlex
├── 프로젝트 홈
│   ├── 최근 프로젝트
│   ├── 전체 프로젝트
│   ├── 새 프로젝트
│   ├── 프로젝트 가져오기
│   └── 도움말·설정
│
├── 프로젝트
│   ├── 프로젝트 개요
│   ├── 장소 구조
│   ├── 층·평면도
│   ├── 편집 작업 공간
│   ├── 문제·진행 상태
│   ├── 기록·버전
│   └── 내보내기
│
└── 전역 지원 기능
    ├── 도움말 검색
    ├── 상황별 정보
    ├── iCloud 상태
    ├── 보안·개인정보
    └── 앱 설정
```

## 3. 프로젝트 홈

### 최근 프로젝트

최근 작업한 프로젝트를 마지막 수정 순으로 보여준다.

프로젝트 항목의 필수 정보:

- 프로젝트 이름
- 건물 주소
- 마지막 수정일
- 오류 수
- 경고 수
- 미완료 수
- 잠금 상태
- 동기화 문제 여부

프로젝트를 열면 마지막으로 작업한 건물, 층, 지도 위치와 편집 맥락으로 복귀한다.

### 전체 프로젝트

- 이름·주소 검색
- 최근 수정일 정렬
- 프로젝트 열기
- 프로젝트 이름 변경
- 잠금 설정
- 프로젝트 패키지 내보내기
- 프로젝트 삭제 또는 보관

삭제는 Lo-Fi에서 반드시 확인·취소·복구 가능 여부를 검토한다.

### 새 프로젝트

시작 방식:

- 평면도 이미지 또는 PDF에서 시작
- 기존 GeoJSON에서 시작
- 기존 IMDF에서 시작
- 독립 프로젝트 패키지 가져오기

주소 검색 후 앱이 프로젝트 이름을 제안하지만 사용자가 수정할 수 있다.

## 4. 프로젝트 데이터 계층

```text
Project
└── Venue
    ├── Address
    ├── Building A
    │   ├── Level B1
    │   │   ├── Floor Plan Overlay
    │   │   └── IMDF Features
    │   ├── Level 1
    │   └── Level 2
    └── Building B
        ├── Level 1
        └── Level 2
```

기본 탐색은 건물별 관리이며, 필요할 때 전체 층 목록을 볼 수 있다.

앱은 다음 관계를 자동으로 추론하지 않는다.

- Level이 속한 Building
- Feature가 속한 Level
- Opening이 연결되는 Unit
- Anchor와 Occupant
- 기타 IMDF reference

사용자가 명시적으로 관계를 지정하고 앱은 유효한 대상만 추천하거나 잘못된 관계를 차단·경고한다.

## 5. 프로젝트 개요

프로젝트를 열었을 때 현재 상태와 다음 작업을 보여준다.

- 프로젝트 이름과 주소
- Venue와 Building 수
- 층별 진행 상태
- 오류·경고·미완료 수
- 마지막 작업 위치로 이동
- 권장 다음 단계
- 개발·검토용 내보내기
- 제출용 내보내기 준비 상태

정보 우선순위:

1. 문제: 오류, 경고, 미완료
2. 단계: 전체 제작 단계
3. 공간: 건물과 층

## 6. 장소 구조

### 주소·지도

- 주소 검색
- 지도 결과 선택
- 장소 위치 확인
- 지도 위치·확대·방향 조정
- 기준 지도 상태 잠금
- 주소 또는 지도 데이터 로딩 실패 처리

주소 검색과 새로운 지도 데이터 로딩에는 네트워크가 필요할 수 있다. 이미 저장된 프로젝트의 핵심 제작 작업은 오프라인에서도 가능해야 한다.

### Venue

- Venue 생성·수정
- 주소 연결
- Venue 범위 확인
- Building 목록 관리

### Building

- Building 추가·수정·삭제
- Building 이름
- Building footprint
- Level 목록
- 전체 Building 전환

한 주소 또는 Venue에 여러 Building이 존재할 수 있다.

## 7. 층과 평면도

### Level

- Level 생성
- 이름과 ordinal 설정
- Building에 수동 연결
- Level 순서 변경
- Level 복제·삭제
- 건물별 목록과 전체 층 목록 전환

### 평면도 등록

- 이미지 또는 PDF 선택
- PDF 페이지 선택
- 층에 연결
- 도면 이름과 상태 확인
- 다른 도면으로 교체
- 도면 제거

### 평면도 정렬

두 가지 방식을 지원한다.

- 손가락 또는 Pointer로 이동·확대·회전
- 지도와 평면도의 동일 지점 2~3개를 지정해 자동 정렬

정렬 도구:

- 이동
- Scale
- Rotation
- Opacity
- 표시·숨김
- 잠금·잠금 해제
- 초기화
- 정렬 완료

도면 교체나 정렬 변경 후 기존 Geometry가 있으면 영향 범위를 알리고 해당 층을 `검토 필요` 상태로 전환한다.

## 8. 편집 작업 공간

편집 작업 공간은 제품의 중심이다.

```text
편집 작업 공간
├── 프로젝트·건물·층 Context
├── 지도 Canvas
│   ├── Apple Maps Context
│   ├── Floor Plan Overlay
│   ├── IMDF Geometry
│   ├── Selection·Vertex·Snap
│   └── Validation 위치 표시
├── Feature 도구
├── Layer·표시 설정
├── Inspector
├── 문제·진행 상태
└── 편집 명령
```

### 지도 Canvas

- 이동·확대·회전
- 지도 상태 잠금
- Feature 선택
- 겹친 Feature 선택
- Geometry 생성·수정
- 문제 위치로 이동
- 선택한 Feature에 맞춰 보기

### 입력 역할

- Apple Pencil: 정밀 작성과 꼭짓점 수정
- Touch: 지도 이동·확대·회전, 선택
- Pointer: 선택, Hover, 정밀 수정
- Keyboard: 도구 전환, 취소, 삭제, Undo/Redo

입력 방식은 달라도 같은 작업 결과를 만들어야 한다.

## 9. Feature 도구

Feature 선택 구조:

- 검색
- 최근 사용
- 장소 유형 기반 추천
- 전체 IMDF 계층

MVP Feature Collection:

- address
- venue
- building
- footprint
- level
- unit
- opening
- amenity
- anchor
- occupant
- detail
- fixture
- geofence
- kiosk
- relationship
- section

### 작성 방식

사용자는 Feature 종류를 먼저 선택하고 지도에 작성한다. 같은 종류는 연속으로 여러 개 작성할 수 있다.

```text
Feature 도구 선택
→ Geometry 작성
→ 최소 정보로 저장
→ 다음 Feature 계속 작성
→ 미입력 속성은 미완료로 표시
→ 나중에 일괄 보완
```

Geometry 작성과 반복 속성을 필요 이상으로 번갈아 입력하게 하지 않는다.

## 10. Inspector

선택한 Feature를 설명하고 수정한다.

### 기본 정보

- Feature 종류
- 이름·Label
- ID
- Category
- 현재 상태

### Category 선택

- 검색
- 최근 사용
- 장소 유형 기반 추천
- 전체 계층
- 짧은 설명
- 대표 예시
- 흔한 실수 한 가지
- 상세 도움말

### 속성

- 필수 속성
- 선택 속성
- 아직 입력하지 않은 속성
- 잘못된 값의 쉬운 설명

### 관계

- 관련 Building
- 관련 Level
- Unit과 Opening
- Unit과 Amenity
- Anchor와 Occupant
- 기타 reference

### Geometry

- 좌표·꼭짓점 정보
- 꼭짓점 추가·삭제
- Geometry 수정
- Snap 설정
- 잠금

## 11. Layer와 표시 설정

- Feature 종류별 표시·숨김
- 현재 단계에 필요한 Feature 자동 표시
- Floor Plan 표시·숨김
- Floor Plan opacity
- 선택하지 않은 Feature 흐리게 보기
- 관계선 표시·숨김
- 문제 위치 표시·숨김

자동 표시는 사용자가 직접 설정을 변경할 수 있어야 한다.

## 12. 문제와 진행 상태

### 문제 중심

- 오류
- 경고
- 미완료

문제 항목의 필수 정보:

- 왜 문제인지 쉬운 설명
- 심각도
- 관련 Feature
- Building과 Level
- 지도에서 문제가 발생한 위치
- 사용자가 해야 할 조치
- 해결 여부

문제를 선택하면 해당 Building, Level, Feature와 지도 위치로 이동한다. 첫 버전에서는 자동 수정하지 않는다.

### 단계 중심

- 현재 단계
- 완료한 단계
- 건너뛴 단계
- 검토가 필요한 단계
- 다음 권장 단계

앱의 권장 순서를 따르되 사용자는 단계와 층을 자유롭게 오갈 수 있다.

### 공간 중심

- Building별 상태
- Level별 상태
- 완료
- 편집 중
- 미시작
- 검토 필요

완료는 잠금이 아니다. 언제든 다시 편집할 수 있으며 변경된 범위가 검토 필요로 전환된다.

## 13. 기록과 버전

- 현재 편집 세션 Undo/Redo
- 앱을 닫은 뒤에도 유지되는 변경 기록
- 내보낼 때마다 프로젝트 버전 생성
- 최근 수정일
- 마지막 작업 위치
- 완료 후 변경된 범위 표시
- 이전 버전 보기·복원

복원 범위와 충돌 처리 방식은 Lo-Fi에서 별도 검증한다.

## 14. 내보내기

### 개발·검토용 ZIP

- 오류·경고·미완료와 관계없이 허용
- 현재 문제 상태를 명확히 표시
- 중간 검토와 외부 테스트용

### 제출용 IMDF ZIP

- 내보내기 전 Preflight
- 오류가 있으면 차단
- 경고만 있으면 확인 후 허용
- 미완료가 제출에 미치는 영향 안내
- 내보내기 버전 저장
- `imdf.zip` 생성

IMDFlex Preflight 통과와 Apple IMDF Validator 통과를 구분한다. 최종 제출 적합성은 실제 Apple Validator 결과로 판단한다.

## 15. 프로젝트 저장·동기화·보안

### 저장

- 기기 로컬 저장
- 사용자의 iCloud 동기화
- 독립 프로젝트 패키지
- 앱 자체 외부 서버로 프로젝트 데이터를 전송하지 않음

### 동기화 문제

사용자의 조치가 필요한 저장·동기화 문제만 시스템 알림으로 알린다. IMDF 오류·경고·미완료는 앱 내부에서만 보여준다.

### 보안

- 프로젝트별 Face ID 잠금
- 최근 앱 화면에서 민감한 내용 숨김
- 프로젝트 목록에서 잠긴 프로젝트 내용 숨김

## 16. 도움말

도움말은 별도 학습 과정을 강제하지 않고 실제 프로젝트 중 필요한 순간에 제공한다.

- 상황별 정보 버튼
- 전체 도움말 검색
- Feature 설명
- Category 예시
- 흔한 실수
- Geometry 작성 안내
- 오류 설명
- 다시 보기

## 17. 전역 상태

화면마다 다음 상태의 필요 여부를 확인한다.

- Loading
- Empty
- Ready
- Editing
- Drawing
- Selected
- Incomplete
- Warning
- Error
- Completed
- Review Required
- Offline
- Syncing
- Sync Conflict
- Locked
- Permission Denied
- Import Failed
- Export Failed

## 18. IA 검증 질문

- 모든 화면에 명확한 진입 경로와 이탈 경로가 있는가?
- 사용자가 현재 Project, Building, Level을 알 수 있는가?
- 단계와 층을 건너뛴 뒤 돌아올 수 있는가?
- 완료 후 변경했을 때 무엇이 다시 검토 대상이 되는가?
- 네트워크 없이 가능한 작업과 불가능한 작업이 구분되는가?
- 잘못된 Feature 관계를 만들거나 수정하는 흐름이 존재하는가?
- 빈 프로젝트, 가져오기 실패, 도면 교체, 동기화 충돌을 복구할 수 있는가?
- 오류에서 실제 지도 위치로 이동할 수 있는가?
- 내보내기 실패 후 수정하고 다시 시도할 수 있는가?
- 프로젝트를 장기간 다시 열었을 때 마지막 맥락을 복원할 수 있는가?

이 질문에 답하지 못하는 부분은 Lo-Fi Prototype의 논리적 구멍으로 기록한다.
