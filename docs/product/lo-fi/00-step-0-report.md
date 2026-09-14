# Step 0 Report - IA Freeze & Coverage Matrix

Status: 완료 · 후속 82개 Screen Family Lo-Fi까지 확장 완료

Approved: 2026-08-20

## 1. 이번 단계의 목표

전체 IA를 Lo-Fi Prototype에서 추적 가능한 화면 목록으로 변환하고, 정상 경로 외 상태·이동·복구가 누락된 지점을 찾는다.

## 2. 완성한 결과

- Screen Family: 82개
- Coverage Matrix에 연결된 Screen Family: 82개
- 첫 End-to-End Skeleton용 P0 Screen: 31개
- 확인한 Coverage: Ready, Loading, Empty, Error, Offline, Back, Cancel, Skip, Retry, Resume, Undo, Impact
- 발견한 논리적 구멍: 10개

산출물:

- `01-screen-inventory.md`
- `02-coverage-matrix.md`

## 3. 구조적 결론

전체 IA는 하나의 거대한 Prototype보다 다음 다섯 묶음으로 제작하는 것이 안전하다.

```text
A. 뼈대와 프로젝트 진입
B. 장소·건물·층·평면도
C. Editor와 Feature 작성
D. 문제 해결·내보내기
E. 재진입·동기화·보안·전체 QA
```

첫 Wireflow는 31개의 Ready 상태만 사용해 전체 Happy Path를 연결한다. 상태와 예외는 Coverage Matrix를 기준으로 이후 단계에서 추가한다.

## 4. 발견한 논리적 구멍

### 첫 Wireflow 전에 결정 완료

1. 프로젝트 생성 시점 - `D-LF-001` 승인
2. Geometry Draft 도중 이탈 - `D-LF-002` 승인
3. 미완료와 제출용 ZIP - `D-LF-003` 승인

### 후속 Milestone에서 결정 완료

4. Setup의 세부 단계별 Skip 정책 - `D-LF-004` 승인
5. Building·Level 삭제와 복구 - `D-LF-005` 승인
6. 내보내기 진행 중 취소 - `D-LF-006` 승인
7. 도면 교체 후 기존 Geometry 처리 - `D-LF-007` 승인
8. 버전 복원 범위 - `D-LF-008` 승인
9. iCloud 충돌 해결 범위 - `D-LF-009` 승인
10. 기존 IMDF Import의 보존·경고·거절 정책 - `D-LF-010` 승인

## 5. Decision Card 1 - 프로젝트 생성 시점

### 결정할 것

사용자가 언제부터 `저장된 프로젝트`를 가지는가?

### 추천안

Start Method를 선택하고 Project Basics에서 이름을 확인하는 순간 `Draft Project`를 생성한다.

- 주소가 없어도 Draft 상태로 최근 프로젝트에 표시
- 입력과 Setup 진행 상황 자동 저장
- 사용자가 명시적으로 취소하면 Draft 폐기 확인
- 앱 종료 후 다시 이어서 작업 가능

### 이유

주소 검색, 파일 가져오기, 평면도 설정 중 앱이 종료되어도 작업을 잃지 않는다. 장시간 프로젝트라는 제품 특성과 맞는다.

### 대안

주소 또는 파일 검증이 끝난 뒤 프로젝트를 생성할 수 있지만, 그 전 과정의 재진입과 저장 규칙이 복잡해진다.

### 권고 Decision ID

`D-LF-001: Project Basics 완료 시 Draft Project 생성`

## 6. Decision Card 2 - Drawing Draft 이탈

### 결정할 것

Polygon 또는 Line을 그리는 도중 다른 화면·층·도구로 이동하면 어떻게 되는가?

### 추천안

- 앱 Background·종료: Draft를 자동 보존하고 다음 진입 시 복구
- 의도적인 도구·층 전환: `계속 그리기` 또는 `초안 버리기`를 선택
- 유효하지 않은 Geometry를 Feature로 자동 저장하지 않음
- 취소 전에는 Undo로 꼭짓점을 되돌릴 수 있음

### 이유

조용히 Draft가 사라지는 데이터 손실과, 불완전 Geometry가 Feature로 남는 문제를 모두 방지한다.

### 권고 Decision ID

`D-LF-002: 비의도적 이탈은 Draft 보존, 의도적 Context 전환은 확인`

## 7. Decision Card 3 - 미완료와 제출용 ZIP

### 결정할 것

`미완료`가 있을 때 제출용 ZIP을 허용하는가?

### 추천안

미완료를 두 종류로 구분한다.

- Submission-blocking Incomplete: IMDF 필수 속성·관계가 없어 제출용 ZIP 차단
- Workflow Incomplete: 앱의 권장 작업이 남았지만 유효한 IMDF인 경우 경고 후 허용 가능

개발·검토용 ZIP은 두 종류와 관계없이 내보낼 수 있다.

### 이유

모든 미완료를 동일하게 차단하면 앱의 작업 Checklist와 실제 IMDF Schema를 혼동한다. 반대로 모두 허용하면 필수 정보가 없는 ZIP을 제출할 수 있다.

### 권고 Decision ID

`D-LF-003: 미완료를 제출 차단형과 Workflow 경고형으로 분리`

## 8. 검증 결과

- Inventory 82개와 Matrix 82개 ID가 정확히 대응함
- Matrix에서 누락된 Screen Family 0개
- Inventory에 없는 추가 Matrix 항목 0개
- 첫 Skeleton용 P0 Screen 31개 확인
- 모든 IA 영역이 하나 이상의 Screen Family에 연결됨

## 9. 후속 검증에서 닫힌 위험

- 82개 Screen Family는 93개 실제 상태 화면으로 확장했다.
- 판단과 데이터 손실 상태만 별도 Frame으로 만들고 단순 선택·Loading은 화면 내부 상태로 제한했다.
- `F`, `I`, `L` 구분은 실제 Wireflow와 대조해 최종 Matrix로 정리했다.
- IMDF Schema와 Apple IMDF Validator의 실제 규칙 검증은 구현 단계의 별도 책임으로 유지한다.

## 10. 당시 다음 단계와 완료 결과

승인된 세 Decision Card를 반영해, 31개 P0 Screen으로 다음 Happy Path를 Wireflow로 그린다.

```text
최근 프로젝트
→ 새 프로젝트
→ 주소·Venue·Building·Level
→ 평면도 등록·정렬
→ Editor
→ Unit 연속 작성
→ Opening 관계 연결
→ 문제 위치 확인·수정
→ 제출용 Preflight
→ Export 성공
```

Wireflow에서는 화면의 시각 완성도를 높이지 않고 다음 항목만 표시했으며, 이 원칙으로 전체 Lo-Fi를 완료했다.

- 화면 제목
- 현재 Project·Building·Level
- 핵심 정보
- Primary Action
- Back·Cancel·Skip
- 다음 Screen ID
- 연결된 Decision ID 또는 구현 단계 검증 책임
