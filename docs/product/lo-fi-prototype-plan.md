# IMDFlex Lo-Fi Prototype Plan

## 1. 결정

기존 Calm Cartography Design System과 Hi-Fi Component 작업은 보류한다. Lo-Fi Prototype에서 전체 IA와 작업 논리를 먼저 검증한 뒤 재개한다.

## 2. 성공 조건

1. 시각적으로 예쁜 것은 우선하지 않는다.
2. 화면, 상태, 이동, 실패와 복구 흐름에 논리적 구멍이 없어야 한다.
3. 사용자가 핵심 과업을 따라가며 사용성을 확인할 수 있을 정도의 러프한 디자인이어야 한다.

## 3. Lo-Fi 표현 규칙

- 회색조 중심
- 하나의 강조색만 사용 가능
- 실제 사진·정교한 지도 스타일 불필요
- 실제 텍스트에 가까운 Label 사용
- 아이콘이 없어도 텍스트 Button으로 의미를 전달
- Auto Layout과 Component 완성도는 필수 아님
- 화면마다 목적과 상태를 이름에 기록
- 같은 화면의 상태가 다르면 별도 Frame으로 표현
- 클릭 가능한 핵심 행동만 Prototype 연결

Lo-Fi에서 검토할 것은 색, 그림자, 브랜드 표현이 아니라 다음 항목이다.

```text
현재 위치
현재 상태
가능한 행동
행동의 결과
취소·되돌리기
오류·복구
다음 단계
```

## 4. 한 번에 전체를 만들지 않는 이유

전체 IA를 바로 상세 화면으로 만들면 앞 단계의 구조 변경이 뒤의 모든 화면을 다시 만들게 한다. 먼저 얇은 End-to-End 흐름을 연결하고, 이후 과업 묶음별로 상태와 예외를 채우는 것이 안전하다.

권장 방식:

```text
전체 Happy Path Skeleton
→ 과업별 정상 흐름
→ Skip·Undo·Back
→ 오류·빈 상태·복구
→ 장기 재진입
→ 전체 연결 검증
```

## 5. 작업 단위

각 작업 단위는 다음 네 가지를 함께 만든다.

1. Screen Inventory
2. User Flow
3. 주요 Screen State
4. Logic Checklist

화면만 그리고 Flow 또는 State를 나중으로 미루지 않는다.

## 6. Step 0 - IA Freeze와 Coverage Matrix

### 목적

프로토타입에 포함할 전체 범위를 고정하고 누락을 추적한다.

### 작업

- IA 문서 검토
- 사용자 역할과 핵심 시나리오 확인
- 전체 Screen Inventory 작성
- 전역 상태 목록 작성
- 화면별 상태와 연결 Coverage Matrix 작성
- Lo-Fi Frame 이름 규칙 정의

### Frame 이름 예시

```text
01 Home / Recent / Ready
01 Home / Recent / Empty
02 Create / Address Search / Loading
02 Create / Address Search / Failed
05 Editor / Unit Drawing / Active
07 Review / Issue Detail / Error Selected
```

### 종료 조건

- 모든 IA 항목이 최소 하나의 Screen 또는 Flow에 연결됨
- 모든 핵심 화면의 Loading, Empty, Error 필요 여부가 표시됨
- 미결정 항목이 별도 목록으로 분리됨

## 7. Step 1 - End-to-End Happy Path Skeleton

### 목적

디테일 없이 앱 전체가 처음부터 끝까지 연결되는지 확인한다.

### 범위

```text
프로젝트 홈
→ 새 프로젝트
→ 주소 선택
→ Venue·Building
→ Level
→ 평면도 등록·정렬
→ 편집 작업 공간
→ Unit 작성
→ Opening 작성·관계 연결
→ 문제 확인·수정
→ Preflight
→ imdf.zip 내보내기
→ 프로젝트 홈 복귀
```

### 산출물

- 단계당 대표 화면 1개
- 주요 Next·Back 연결
- 전역 Project·Building·Level Context
- 첫 클릭 가능한 전체 Prototype

### 종료 조건

- 사용자가 한 방향으로 전체 과업을 완료할 수 있음
- 막다른 화면이 없음
- 이전 단계로 돌아갈 수 있음
- 저장되는 시점과 프로젝트 생성 시점이 설명됨

## 8. Step 2 - 프로젝트 홈과 프로젝트 생명주기

### 범위

- 최근 프로젝트
- 전체 프로젝트
- 빈 프로젝트 목록
- 검색 결과 없음
- 잠긴 프로젝트
- 프로젝트 이름 변경
- 프로젝트 패키지 가져오기
- 가져오기 실패
- 삭제·취소·복구 가능성
- 마지막 작업 위치 복귀

### 핵심 질문

- 프로젝트는 언제 생성되고 저장되는가?
- 주소가 아직 없어도 임시 프로젝트가 존재하는가?
- 가져오기와 새 프로젝트의 결과 구조는 같은가?
- 잠긴 프로젝트는 목록에서 무엇을 보여주는가?

### 종료 조건

- 새 프로젝트, 기존 프로젝트, 가져오기 세 진입 경로가 Editor까지 연결됨
- 프로젝트를 나갔다 다시 열어도 작업 맥락을 이해할 수 있음

## 9. Step 3 - 장소·건물·층 구조

### 범위

- 주소 검색·선택
- 주소 검색 실패·오프라인
- Venue 생성·수정
- 단일 Building
- 여러 Building
- Building 추가·삭제
- Level 생성·순서 변경
- Building과 Level 수동 연결
- 전체 층과 건물별 층 전환
- 단계 Skip

### 핵심 질문

- 사용자는 현재 어떤 Building을 편집하는지 아는가?
- 한 주소에 여러 Building이 있을 때 Level을 잘못 연결하지 않는가?
- 주소 검색을 건너뛰고 작업할 수 있는가?
- Building을 삭제할 때 하위 Feature는 어떻게 되는가?

### 종료 조건

- Project → Venue → Building → Level 계층이 화면에서 일관됨
- 계층 변경의 영향과 파괴적 행동이 설명됨

## 10. Step 4 - 평면도 등록·정렬·교체

### 범위

- 이미지 가져오기
- PDF와 페이지 선택
- 여러 층의 도면 등록
- 수동 이동·Scale·Rotation
- 기준점 2~3개 자동 정렬
- Opacity와 표시·숨김
- 정렬 잠금·해제
- 취소·초기화
- 도면 교체
- 기존 Geometry가 있을 때 교체 영향

### 핵심 질문

- 정렬 중 지도 조작과 도면 조작이 구분되는가?
- 정렬을 완료하지 않아도 다음 단계로 갈 수 있는가?
- 도면 교체 후 기존 Geometry를 유지할지 판단할 수 있는가?

### 종료 조건

- 모든 층 도면을 먼저 등록하는 흐름과 층별 재방문 흐름이 모두 가능함
- 정렬 전, 정렬 중, 정렬 완료, 검토 필요 상태가 구분됨

## 11. Step 5 - Editor Shell과 탐색

### 범위

- 지도 Canvas
- Feature 도구
- Layer 표시 설정
- Inspector 열기·닫기
- Building·Level 전환
- 단계 전환
- 문제 Panel
- 지도 상태 잠금
- 선택 해제
- Undo·Redo
- 도움말

### 핵심 질문

- 지도를 가리지 않고 주요 기능에 접근할 수 있는가?
- 사용자가 현재 도구, Feature, Building, Level을 항상 알 수 있는가?
- 패널을 열고 닫아도 작업 위치를 잃지 않는가?
- iPad와 Mac이 같은 개념 구조를 유지하는가?

### 종료 조건

- 어떤 Feature Flow도 Editor 구조를 새로 발명하지 않고 시작할 수 있음
- 전역 탐색과 편집 중 Context가 안정됨

## 12. Step 6 - Feature 작성 기본 문법

### 범위

- Feature 검색
- 최근 사용
- 장소 유형 기반 추천
- 전체 계층
- Polygon 작성
- Line 작성
- Point 작성
- 연속 작성
- Draft 취소·완료
- Geometry 선택·수정·삭제
- Vertex·Snap
- 겹친 Feature 선택
- Locked·Disabled

### 핵심 질문

- Feature 종류를 바꿀 때 현재 Draft는 어떻게 되는가?
- 연속 작성 종료 방법이 명확한가?
- 잘못 그린 Geometry를 언제든 수정할 수 있는가?
- Touch와 Pencil이 충돌하지 않는가?

### 종료 조건

- Polygon, Line, Point의 공통 작성 문법이 정의됨
- Unit 외 다른 Feature도 같은 기본 문법을 재사용할 수 있음

## 13. Step 7 - 핵심 Vertical Slice

### 범위

```text
Unit 연속 생성
→ 최소 정보 저장
→ 미완료 표시
→ Opening 연속 배치
→ Unit 관계 수동 연결
→ 잘못된 관계
→ 오류 발생
→ 문제 설명
→ 지도 위치로 이동
→ 직접 수정
→ 재검사
→ 층 완료
→ 완료 후 다시 편집
```

### 필수 상태

- 도구 선택 전
- Unit 작성 중
- Unit 작성 완료·속성 미완료
- Opening 작성 중
- 관계 대상 선택 중
- 유효하지 않은 관계
- 오류 위치 선택
- 수정 후 해결
- 층 완료
- 완료 후 변경·검토 필요

### 종료 조건

- IMDFlex의 세 가지 핵심 품질을 사용성 테스트할 수 있음
- 자동 수정 없이 사용자가 문제를 찾아 해결할 수 있음
- 완료가 잠금으로 오해되지 않음

## 14. Step 8 - Inspector·Category·관계

### 범위

- 필수·선택 속성
- 미입력 속성
- Category 검색
- 최근 Category
- 장소 유형 기반 추천
- 전체 계층
- 짧은 설명·예시·흔한 실수
- 관계 대상 검색·선택·해제
- 여러 Feature 일괄 보완 가능성
- 저장·취소

### 핵심 질문

- 속성을 입력하지 않아도 Geometry 작성을 계속할 수 있는가?
- 필수 속성과 제출 영향이 이해되는가?
- Category 추천이 자동 결정으로 오해되지 않는가?
- 관계 대상을 지도와 목록에서 모두 찾을 수 있는가?

### 종료 조건

- Geometry 작성 리듬과 속성 보완 흐름이 분리됨
- Feature·Category·관계를 잘못 입력하는 주요 경로가 처리됨

## 15. Step 9 - 문제·진행·완료

### 범위

- 오류·경고·미완료 요약
- 문제 목록과 상세
- 문제 위치로 이동
- 쉬운 설명
- 사용자의 직접 수정
- 해결·미해결·무시 불가 상태
- 단계 진행 상태
- Building·Level 진행 상태
- 단계 Skip과 재진입
- 완료·검토 필요

### 핵심 질문

- 문제 수가 많아도 우선순위를 이해할 수 있는가?
- 문제를 해결한 뒤 다음 문제로 이동할 수 있는가?
- 단계 완료와 공간 완료가 혼동되지 않는가?

### 종료 조건

- 문제 → 위치 → 수정 → 재검사 Loop가 끊기지 않음
- 문제, 단계, 공간의 세 상태 모델이 함께 동작함

## 16. Step 10 - 내보내기와 버전

### 범위

- 개발·검토용 ZIP
- 제출용 ZIP
- Preflight 진행
- 오류로 제출 차단
- 경고 확인 후 제출
- 내보내기 실패·재시도
- 내보내기 버전 생성
- 이전 버전 보기·복원
- Apple Validator 외부 확인 안내

### 핵심 질문

- 두 ZIP의 목적이 명확히 다른가?
- 사용자가 앱의 Preflight를 Apple 승인으로 오해하지 않는가?
- 내보내기 후 프로젝트로 돌아와 수정할 수 있는가?

### 종료 조건

- 오류, 경고, 미완료의 내보내기 정책이 모든 경우에 정의됨
- Export 실패와 Validator 실패의 복귀 경로가 존재함

## 17. Step 11 - 장기 사용·동기화·보안

### 범위

- 앱 종료 후 재진입
- 마지막 작업 위치
- 오프라인 편집
- iCloud 동기화 중
- 동기화 실패·충돌
- 프로젝트 패키지 전달
- Face ID 잠금
- 잠금 실패
- 최근 앱 화면 보호

### 핵심 질문

- 몇 일 뒤 다시 열었을 때 작업 상태를 이해할 수 있는가?
- 오프라인에서 불가능한 행동이 작업을 방해하지 않는가?
- 동기화 문제와 IMDF 문제를 구분할 수 있는가?
- 충돌 시 데이터가 사라지지 않는가?

### 종료 조건

- 사용자의 조치가 필요한 시스템 문제만 외부 알림으로 이어짐
- 장기 프로젝트의 재진입과 데이터 보호 흐름이 연결됨

## 18. Step 12 - 전체 연결과 논리 QA

### 실행

전문 기능별로 화면을 보는 대신 실제 과업 시나리오로 Prototype을 처음부터 끝까지 수행한다.

### 필수 테스트 시나리오

1. 처음 사용자가 평면도에서 제출용 ZIP까지 완료
2. 주소 하나에 Building 두 개와 여러 Level 생성
3. 정렬을 건너뛴 뒤 나중에 복귀
4. 완료된 층의 도면을 교체하고 재검토
5. 잘못된 Opening 관계를 문제 목록에서 찾아 수정
6. 오류가 있는 상태에서 검토용 ZIP 내보내기
7. 경고만 있는 상태에서 제출용 ZIP 내보내기
8. 앱 종료 후 마지막 작업 위치로 복귀
9. 오프라인에서 편집하고 동기화 문제 처리
10. 기존 IMDF를 가져와 수정 후 다시 내보내기

### 논리 QA Checklist

- Orphan Screen 0개
- Dead End 0개
- 정의되지 않은 Back 동작 0개
- 저장 시점이 불명확한 Flow 0개
- 복구할 수 없는 실패 화면 0개
- 출처를 알 수 없는 상태 변화 0개
- Project·Building·Level Context 유실 0개
- 제출 적합성을 과장하는 문구 0개
- 사용자 승인 없이 데이터가 삭제되는 경로 0개

### 종료 조건

- Blocker 0개
- Major는 수정 또는 수용 결정 완료
- 모든 IA 항목이 Prototype에서 추적 가능
- 사용성 테스트 과업과 관찰 질문 준비

## 19. 권장 실제 제작 순서

전체 Step을 그대로 한 번에 진행하지 않는다. 다음 다섯 Milestone으로 묶는다.

### Milestone A - 뼈대

- Step 0 IA Freeze
- Step 1 End-to-End Skeleton
- Step 2 프로젝트 홈

### Milestone B - 공간 설정

- Step 3 장소·건물·층
- Step 4 평면도 등록·정렬

### Milestone C - 핵심 편집

- Step 5 Editor Shell
- Step 6 Feature 작성 문법
- Step 7 Unit-Opening Vertical Slice

### Milestone D - 완성과 전달

- Step 8 Inspector·Category·관계
- Step 9 문제·진행·완료
- Step 10 내보내기·버전

### Milestone E - 현실 조건과 전체 QA

- Step 11 장기 사용·동기화·보안
- Step 12 전체 연결과 논리 QA

각 Milestone 종료 시 사용자에게 다음 형식으로 보고한다.

```text
이번 범위
완성한 Flow와 Screen
정상 경로
Skip·Back·Undo
오류·복구
논리적 구멍
사용성 가설
추천 결정
다음 Milestone
```

## 20. 지금 시작할 작업

첫 작업은 Figma 화면을 많이 그리는 것이 아니라 Milestone A의 두 결과물을 만드는 것이다.

1. 전체 Screen Inventory와 Coverage Matrix
2. 새 프로젝트에서 `imdf.zip`까지 이어지는 얇은 End-to-End Wireflow

이 두 결과를 승인한 뒤 프로젝트 홈의 상태를 상세화한다. 이 순서라면 전체 구조를 먼저 확인하면서도, 한 번에 너무 많은 화면을 제작하는 문제를 피할 수 있다.
