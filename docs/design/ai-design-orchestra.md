# IMDFlex AI Design Orchestra

이 문서는 `[26_Design_AI] C5 윤영민.pdf`에서 제안한 AI 기반 제품 디자인 흐름을 IMDFlex에 맞게 확장한 운영 설계다.

핵심은 많은 Agent를 동시에 실행하는 것이 아니다. 사용자가 Design Leader로서 방향을 정하고, Orchestrator가 동일한 브리프를 전문 Agent에게 배분하며, 중간 보고와 승인 게이트를 통해 결과를 통제하는 것이다.

사용자용 통합 보고서는 [`ai-design-orchestra-report.html`](./reports/ai-design-orchestra-report.html)을 사용한다. 각 팀은 이 문서의 Handoff Contract 형식으로 결과를 제출하고, Orchestrator가 HTML 보고서의 팀별 영역과 Decision Card로 통합한다.

```text
지휘 브리프
→ Planning & UX Proposal
→ Design Competition
→ UI System & Flow
→ Interactive Prototype
→ Expert Review
→ SwiftUI Implementation
→ IMDF Preflight
→ Apple IMDF Validator
→ Decision Log
```

## 1. 운영 목표

IMDFlex Orchestra는 다음 문제를 해결해야 한다.

- AI가 만든 임의의 화면에 제품 방향이 끌려가지 않게 한다.
- 디자인 초기에 IMDF 규칙과 구현 제약을 함께 검토한다.
- iPad, Apple Pencil, Touch, Pointer, Mac의 차이를 화면 장식이 아닌 작업 흐름으로 다룬다.
- Figma 결과를 SwiftUI와 IMDF 검증까지 추적 가능하게 연결한다.
- 디자인 경험이 적은 사용자도 중요한 판단만 직접 내릴 수 있게 한다.
- 모든 단계에서 완성본을 한 번에 만들지 않고, 되돌리기 비용이 커지기 전에 검토한다.

## 2. 지휘 체계

### Human Design Leader

사용자가 최종 결정권자다.

- 제품 목표와 우선순위를 승인한다.
- 경쟁안 중 방향을 선택하거나 통합 원칙을 결정한다.
- Major 위험의 수정 또는 수용을 결정한다.
- 다음 Phase로 이동할지를 결정한다.

사용자가 색상값, Figma 레이어, Swift API 같은 세부사항을 모두 판단할 필요는 없다. Orchestrator는 전문가 의견의 충돌과 선택의 결과를 쉬운 언어로 요약해야 한다.

### Design Lead / Orchestrator

Codex의 주 Agent가 담당한다.

- 승인된 브리프를 단일 기준 문서로 유지한다.
- 필요한 Phase에만 전문 Agent를 호출한다.
- 모든 Agent에게 같은 목표, 범위, 제약, 평가 기준을 전달한다.
- 결과의 중복, 충돌, 범위 이탈과 검증되지 않은 가정을 표시한다.
- Agent 원문을 그대로 나열하지 않고 통합안을 작성한다.
- 승인 게이트와 재작업 범위를 관리한다.
- 제품 방향을 대신 결정하지 않는다.

## 3. 단계별 전문 Ensemble

모든 Agent를 항상 유지하지 않는다. 각 Phase에 필요한 최소 역할만 구성한다.

| 역할 | 책임 | 대표 산출물 |
|---|---|---|
| Product & Workflow Designer | 사용자 여정, 단계, 정보 구조, 상태 모델 | UX Proposal, Task Flow |
| Spatial Interaction Designer | Geometry 작성, Pencil, Touch, Pointer, Snap | Interaction Spec, State Table |
| Visual System Designer | Calm Cartography, 4pt tokens, Light/Dark | Variables, Styles, Components |
| IMDF Schema Expert | Feature, geometry, category, reference 규칙 | Constraint Matrix, Validation Rules |
| SwiftUI Architect | 구현 가능성, MVVM 경계, 플랫폼 적응 | Component Contract, Implementation Plan |
| Independent Critic / QA | 반례, 사용성, 회귀, 접근성, 범위 이탈 | Blocker/Major/Minor Review |

한 Agent가 결과물을 만들고 동시에 최종 합격 판정을 내려서는 안 된다. 제작자와 독립 Critic을 분리한다.

### 산출물 소유권

각 산출물은 한 Agent만 책임진다. 다른 Agent는 `Reviewer` 또는 `Advisor`로 참여한다. Orchestrator는 충돌을 종합하지만, 근거 없는 평균안이나 모든 제안을 섞은 절충안을 만들지 않는다.

## 3.1 Project Constitution

모든 Agent는 같은 버전의 Project Constitution을 입력으로 받는다.

```text
제품 비전
핵심 사용자와 사용 환경
최우선 품질 기준
현재 MVP와 후속 범위
확정된 사용자 결정
디자인 원칙과 4pt 간격 체계
공식 Source of Truth
현재 Phase와 기대 산출물
완료 조건
변경 금지 사항
열린 질문
```

Constitution은 대화의 기억을 대신하는 운영 원본이다. 결정이 바뀌면 버전을 올리고 변경 사유와 영향 범위를 Decision Log에 남긴다.

## 4. Phase 0 - Conductor Brief

### 목적

병렬 작업 전에 모든 Agent가 공유할 문제와 판단 기준을 고정한다.

### 필수 입력

- 해결할 사용자 문제
- 대상 사용자와 전문성
- 작업 환경과 사용 기기
- 이번 반복의 핵심 시나리오
- MVP와 후속 범위
- 변경할 수 없는 제약
- 성공 기준 3~7개
- 참고 자료와 공식 Source of Truth
- 검증되지 않은 가설

### IMDFlex 현재 기준

- 전문가가 평면도에서 새로운 IMDF를 제작한다.
- iPad가 중심이지만 Mac도 같은 프로젝트 구조를 사용한다.
- 단계는 안내하되 건너뛰고 나중에 경고를 받을 수 있다.
- 문제, 단계, 공간 순서로 상태를 제시한다.
- 사용자가 오류 위치를 확인하고 직접 수정한다.
- 핵심 품질은 정확한 Geometry, 올바른 Feature 관계, 이해 가능한 오류다.
- IMDFlex 사전 검사 통과를 Apple Validator 통과로 표현하지 않는다.

### Gate 0

사용자가 목표, 범위, 핵심 시나리오를 승인해야 Planning으로 이동한다.

## 5. Phase 1 - Planning & UX Proposal

### 실행

공통 브리프를 기준으로 아래 검토를 병렬 진행한다.

- Product Agent: 사용자 여정과 기능 우선순위
- Spatial Agent: 장시간 편집 흐름과 입력 충돌
- IMDF Agent: 규칙, 참조, 오류와 차단 조건
- SwiftUI Agent: MapKit, 플랫폼, 상태 관리 가능성

Orchestrator는 결과를 하나의 UX Proposal로 통합한다.

### 산출물

- 문제 정의와 제품 가치
- 사용자·환경·작업 기간
- MVP와 후속 범위
- 전체 프로젝트 여정
- 단계·층·Feature 상태 모델
- 정상, 빈 상태, 미완료, 오류, 잠금, 동기화 문제
- 기능 우선순위
- 가설·위험 목록

### Gate 1 - UX 승인

다음 항목을 확인한다.

- 인터뷰 내용이 왜곡 없이 반영됐는가?
- 지도 중심 작업이 유지되는가?
- 신규 제작과 기존 프로젝트 수정이 모두 가능한가?
- 검토용 ZIP과 제출용 ZIP의 의미가 분리됐는가?
- 자동 추론과 자동 수정이 MVP에 침범하지 않는가?

## 6. Phase 2 - Design Competition

디자인 경쟁은 색상이나 장식 경쟁이 아니라 작업 구조 경쟁이다. 각 Agent는 같은 브리프와 같은 시나리오를 사용한다.

### 권장 경쟁안

- Guided Canvas: 현재 단계와 다음 행동이 명확한 지도 중심 구조
- Contextual Workspace: 선택한 Feature에 따라 도구와 Inspector가 변하는 구조
- Issue-driven Editor: 오류와 미완료를 중심으로 작업을 순환하는 구조

### 공통 테스트 시나리오

```text
Unit 연속 생성
→ 필수 속성 미완료
→ Opening 연속 배치
→ Unit 관계 연결
→ 오류 발생
→ 쉬운 설명 확인
→ 지도에서 위치 확인
→ 직접 수정
→ 재검사
→ 층 완료
→ 완료된 층 다시 편집
```

### 평가 Rubric

각 항목을 1~5점으로 평가하고 근거를 기록한다. 아래 가중치는 IMDFlex의 도구 완성도 우선순위를 반영한 기본값이다.

1. Geometry 작성의 정확성과 안정성 - 25%
2. Feature, 관계, IMDF 규칙 적합성 - 25%
3. 오류 원인과 위치, 복구의 이해 가능성 - 20%
4. 지도 작업 영역과 장시간 편집 효율 - 15%
5. iPad와 Mac의 일관성 - 5%
6. 구현·확장 가능성 - 5%
7. Calm Cartography 일관성 - 5%

세 안을 바로 섞지 않는다. 먼저 장점, 위험, 실패 조건을 비교한 뒤 통합 원칙을 정한다.

### Gate 2 - 방향 승인

사용자는 한 안을 선택하거나, 기준안을 정하고 다른 안의 특정 요소를 결합하거나, 모두 재작업하도록 결정할 수 있다.

## 7. Phase 3 - UI System & Flow

### 순서

```text
Primitive Tokens
→ Semantic Tokens
→ Typography / Effects
→ Geometry States
→ Core Components
→ Wireframes
→ Detailed Screens
```

기반 정의는 순차로 진행하고, 승인된 기반 위의 독립 화면 탐색과 리뷰는 병렬화할 수 있다.

### 산출물

- 4pt spacing scale
- Light/Dark semantic colors
- Typography, radius, stroke, elevation
- Geometry, vertex, snap, relationship, validation tokens
- Component variants와 상태
- iPad 핵심 화면과 Mac adaptive 화면
- 정상, 작성 중, 선택, 미완료, 오류, 완료 상태
- 화면별 목적, 주요 행동, 진입·종료 조건

### Gate 3A - Foundations 승인

- Calm Cartography가 IMDFlex만의 성격을 갖는가?
- Feature 색상과 검증 색상이 충돌하지 않는가?
- 밝은 지도, 어두운 지도, 평면도에서 Geometry가 읽히는가?
- 4pt 체계와 플랫폼 예외가 구분되는가?

### Gate 3B - Wireframe 승인

- 사용자가 다음 행동과 현재 도구를 알 수 있는가?
- 패널이 지도와 작업 위치를 불필요하게 가리지 않는가?
- 연속 생성이 반복적인 속성 입력으로 중단되지 않는가?
- 오류에서 해당 Geometry로 직접 이동할 수 있는가?

## 8. Phase 4 - Interactive Prototype

승인된 Wireframe과 Component로 핵심 시나리오를 연결한다.

### 산출물

- 클릭 가능한 Figma Prototype
- 상태 전이표
- Pencil, Touch, Pointer, Keyboard 입력 설명
- 실패, 취소, Undo/Redo 흐름
- 테스트 과업과 관찰 질문
- 구현에서 허용되는 차이

### Gate 4 - Prototype 승인

사용자는 화면의 미감보다 실제 과업을 따라가며 판단한다. Blocker는 모두 해결하고, Major는 수정 또는 수용을 명시하며, Minor는 다음 반복으로 이월할 수 있다.

## 9. Phase 5 - Expert Review

리뷰는 병렬로 진행하지만 하나의 보고서로 통합한다.

- Product Review: 단계, 상태, 정보 구조
- Spatial Review: 정밀도, 입력 충돌, 반복 효율
- Visual Review: 대비, 토큰, 밀도, 시각 계층
- IMDF Review: Feature, geometry, reference, validator 표현
- Technical Review: SwiftUI, MapKit, 상태 관리, 테스트 가능성

### Severity

- Blocker: 핵심 과업을 완료할 수 없거나 데이터가 잘못될 수 있음
- Major: 완료 가능하지만 오류, 피로, 오해 가능성이 높음
- Minor: 핵심 과업을 막지 않는 완성도 개선

리뷰 수용 여부에는 `수정`, `수용`, `후속 이관`, `반려` 중 하나의 결정을 남긴다.

## 10. Phase 6 - SwiftUI Implementation

구현은 승인된 Prototype 이후 시작한다.

### Figma에서 코드로 전달할 계약

- 승인된 Figma node URL
- Variables와 Style 이름
- Component와 Variant 정의
- 크기, 간격, 레이아웃 규칙
- 상태 전이와 Prototype 연결
- 플랫폼별 입력 동작
- Light/Dark 표현
- 접근성 label과 최소 조작 영역
- 구현에서 허용되는 차이

### GitHub Flow

1. 승인된 기능에 GitHub Issue를 만든다.
2. 구현 범위를 작은 Issue로 분할한다.
3. Issue 번호와 연결된 Branch를 만든다.
4. SwiftUI, Domain, Data, DesignSystem 경계를 지킨다.
5. 관련 테스트와 Preview를 작성한다.
6. PR에 Figma node와 의도된 차이를 기록한다.
7. 모듈별 검증 결과를 기록한다.

독립 Agent가 같은 파일을 동시에 수정하지 않는다. 병렬 구현은 모듈 또는 파일 소유권이 분리된 경우에만 허용한다.

## 11. Phase 7 - Verification & Apple Validator

### 자동 검증

- Light/Dark와 Dynamic Type
- Component variants와 최소 조작 영역
- ViewModel intent와 상태 전이
- Drawing 생성, 취소, 완료, Undo/Redo
- Geometry 폐합과 자기 교차
- `[longitude, latitude]` 좌표 순서
- Feature ID 유일성
- `building_id`, `level_id`, `unit_id` reference 무결성
- required property와 category 유효성
- GeoJSON collection과 ZIP 구조
- export 후 round-trip
- 관련 모듈 테스트와 iPad/Mac build

### 수동 외부 Gate

```text
자동 테스트
→ IMDFlex Preflight
→ 제출용 imdf.zip
→ Apple IMDF Validator 수동 검사
→ 실패 시 Issue로 환류
→ 수정 및 재검사
```

Apple Validator를 실제로 통과하기 전에는 Apple 제출 준비 완료라고 선언하지 않는다.

## 12. Source of Truth

| 대상 | Source of Truth |
|---|---|
| 제품 목표와 MVP 범위 | 승인된 Product/UX 문서 |
| 시각 토큰, Component, 화면 상태 | 승인된 Figma 파일 |
| SwiftUI API와 실행 동작 | 저장소 코드 |
| 비즈니스 규칙과 상태 | Domain 모듈 |
| IMDF 규격 | Apple 공식 IMDF Schema와 Validator |
| 사전 검사 동작 | 코드와 테스트 |
| Apple 제출 적합성 | Apple IMDF Validator 결과 |

Figma는 IMDF Schema를 정의하지 않고, 코드는 승인 없이 시각 규칙을 독자적으로 변경하지 않는다. 충돌 시 책임 영역의 Source of Truth를 우선하고 변경 기록을 남긴다.

## 13. Agent Handoff Contract

모든 Agent 결과에는 다음 항목이 있어야 한다.

```text
목표
사용한 입력과 버전
확정된 사실
가설과 미확인 사항
제안한 결정
대안과 기각 이유
생성한 산출물과 위치
검증한 항목
Blocker / Major / Minor 위험
다음 Agent에게 필요한 입력
사용자 결정이 필요한 항목
```

`완료`라는 표현은 산출물 존재, 검증 완료, 미해결 Blocker 없음의 세 조건을 모두 만족할 때만 사용한다.

## 14. Human-in-the-loop Report

각 Gate에서 사용자는 다음 형식의 통합 보고서를 받는다.

1. 이번 단계의 목표
2. 만든 결과
3. Agent별 핵심 의견
4. 서로 충돌한 의견
5. Orchestrator의 통합 제안
6. 검증 결과
7. 남은 위험
8. 사용자가 결정할 항목
9. 승인 후 다음 단계

사용자에게 Agent의 긴 원문을 그대로 전달하지 않는다. 다만 판단 근거와 의견 충돌은 숨기지 않는다.

진행 상태는 다음 다섯 가지로 제한한다.

- 완료
- 조건부 완료
- 검증 대기
- 사용자 결정 대기
- 중단

### Decision Card

사용자 결정을 요청할 때는 전문 용어만 던지지 않고 다음 형태로 번역한다.

```text
결정할 것
지금 결정해야 하는 이유
추천안
대안 최대 2개
각 안이 실제 사용 경험에 미치는 영향
나중에 변경 가능한지
응답이 없을 때 적용할 안전한 기본값
```

사용자는 `진행`, `이전 결정 다시 보기`, `다른 대안 비교`, `이 단계 중단`의 네 가지 기본 명령으로 Orchestra를 통제할 수 있어야 한다.

## 14.1 Decision Log

모든 방향 결정은 번호를 부여한다.

| 필드 | 내용 |
|---|---|
| Decision ID | 예: `D-UX-003` |
| Constitution Version | 결정 당시 기준 버전 |
| 결정 | 선택한 방향 |
| 근거 | 사용자 요구, 검증, 평가표 |
| 기각한 대안 | 대안과 기각 이유 |
| 영향 범위 | 문서, Figma, 코드, IMDF 검사 |
| 되돌릴 수 있는 시점 | 재승인이 필요한 Gate |
| 후속 작업 | 담당자와 완료 조건 |

기존 결정을 바꾸려면 `변경 사유 → 영향 범위 → 대안 → 권고안`을 먼저 보고한다.

## 15. 병렬화 규칙

### 병렬 가능

- 경쟁 UX 조사, IMDF 규칙 조사, 코드 감사
- 동일 브리프를 사용한 구조적 디자인 경쟁
- iPad layout과 Mac adaptation 탐색
- 같은 시안에 대한 Product, Spatial, Visual, Technical, IMDF 리뷰
- 파일 소유권이 겹치지 않는 테스트와 구현

### 반드시 순차

- 브리프 승인 후 Planning
- UX Flow 승인 후 Wireframe
- Primitive 후 Semantic Token
- Token 후 Component
- Component 후 Screen
- Prototype 승인 후 SwiftUI 구현
- Domain/reference 검증 후 Export
- 실제 ZIP 생성 후 Apple Validator

## 16. Stop Conditions

다음 상황에서는 Agent가 임의로 진행하지 않고 Orchestrator가 작업을 멈춘다.

- 제품 목표나 MVP 범위를 바꾸는 선택이 필요함
- 두 Source of Truth가 충돌함
- Apple IMDF 규칙을 공식 자료로 확인하지 못함
- 디자인 경쟁안이 구조적으로 구분되지 않음
- 사용자 승인 없이 되돌리기 비용이 큰 작업으로 넘어가야 함
- 동일 파일에 여러 Agent 변경이 충돌함
- Blocker가 남아 있음
- 외부 전송, 새 dependency, 결제 또는 권한 확대가 필요함
- 테스트나 Validator 결과를 재현할 수 없음
- 같은 문제를 두 번 수정했지만 완료 기준을 통과하지 못함
- 새로운 경쟁안이 기존 후보보다 평가표상 유의미하게 낫지 않음

단순히 작업이 어렵거나 시간이 오래 걸린다는 이유로는 멈추지 않는다.

디자인 경쟁은 한 후보가 기준을 충분히 만족하거나, 두 번째 반복에서도 순위가 바뀌지 않거나, 새 후보가 새로운 사용자 문제를 해결하지 않을 때 종료한다.

## 17. Context Drift 방지

- 모든 Agent는 같은 버전의 Conductor Brief를 입력으로 받는다.
- 결정이 바뀌면 Brief 버전을 올리고 변경 이유를 기록한다.
- Agent는 승인된 범위 밖의 아이디어를 본 작업에 몰래 포함하지 않는다.
- 새로운 아이디어는 `Future Candidates`로 분리한다.
- 화면·코드·검증 결과에는 연결된 Brief, Figma node, Issue를 기록한다.
- Phase 재작업은 영향받은 단계까지만 되돌리고 전체 과정을 초기화하지 않는다.

## 18. 실제 시작 구성

첫 번째 Orchestra Run은 다음 범위로 제한한다.

```text
Run: Unit → Opening → Relationship → Error Recovery

Human Design Leader
└── Design Lead / Orchestrator
    ├── Product & Workflow Designer
    ├── Spatial Interaction Designer
    ├── IMDF Schema Expert
    ├── Visual System Designer
    ├── SwiftUI Architect
    └── Independent Critic
```

이번 Run의 종료 조건은 다음과 같다.

- 승인된 Task Flow
- 승인된 Foundations와 핵심 Component
- iPad Prototype
- Mac adaptation 규칙
- Blocker가 없는 Expert Review
- SwiftUI 구현 Issue 분할안
- IMDF 검증 항목과 Apple Validator 수동 Gate 정의

이후 실제 SwiftUI 구현은 별도 구현 Run으로 시작한다.
