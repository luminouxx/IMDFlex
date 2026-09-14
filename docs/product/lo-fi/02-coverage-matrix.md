# Lo-Fi Coverage Matrix

Status: 초기 요구 Matrix · 최종 검증은 `10-lofi-completion-report.md`를 기준으로 함

## 1. 표기법

| 표시 | 의미 |
|---|---|
| F | 별도 Lo-Fi Frame 필요 |
| I | 같은 Frame 내부 상태 변화로 표현 |
| L | 다른 Screen Family로 연결되어 있음 |
| ? | 제품 결정 또는 규칙 확인 필요 |
| - | 해당 없음 |

Coverage 열:

- Ready: 정상 사용 상태
- Loading: 대기 상태
- Empty: 데이터가 없는 상태
- Error: 작업 실패 또는 잘못된 데이터
- Offline: 네트워크 없음
- Back: 이전 단계로 이동
- Cancel: 현재 작업 취소
- Skip: 미완료로 남기고 진행
- Retry: 같은 작업 다시 시도
- Resume: 앱 종료·다른 단계 이후 재진입
- Undo: 직전 편집 되돌리기
- Impact: 삭제·교체·변경 영향 확인

## 2. 핵심 End-to-End Coverage

| ID | Ready | Loading | Empty | Error | Offline | Back | Cancel | Skip | Retry | Resume | Undo | Impact |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| HOME-01 | F | I | F | I | I | - | - | - | I | F | - | - |
| CREATE-01 | F | - | - | - | - | L | L | - | - | F | - | - |
| CREATE-02 | F | - | - | I | I | L | L | ? | I | F | - | - |
| SETUP-01 | F | - | I | I | I | L | - | F | I | F | - | I |
| SETUP-02 | F | F | F | F | F | L | L | F | I | F | - | - |
| SETUP-03 | F | F | - | I | F | L | L | F | I | F | - | - |
| SETUP-04 | F | - | F | I | I | L | L | F | I | F | I | I |
| SETUP-05 | F | - | F | I | I | L | - | F | I | F | I | I |
| SETUP-06 | F | - | - | I | I | L | L | F | I | F | I | L |
| SETUP-08 | F | - | F | I | I | L | - | F | I | F | I | I |
| SETUP-09 | F | - | - | I | I | L | L | F | I | F | I | L |
| FLOOR-01 | F | - | F | I | I | L | - | F | I | F | I | I |
| FLOOR-02 | F | F | - | L | I | L | L | F | L | F | - | - |
| FLOOR-04 | F | - | - | I | I | L | L | F | I | F | F | I |
| EDIT-01 | F | F | I | I | I | L | - | L | I | F | - | I |
| EDIT-02 | F | F | I | I | I | L | I | L | I | F | F | I |
| AUTHOR-01 | F | F | F | I | I | L | L | - | I | I | - | - |
| AUTHOR-02 | F | - | - | F | I | L | F | - | I | F | F | I |
| AUTHOR-05 | F | - | - | I | I | L | F | - | I | F | F | I |
| AUTHOR-08 | F | - | I | F | I | L | L | F | I | F | F | I |
| AUTHOR-11 | F | F | F | F | I | L | L | F | I | F | F | I |
| AUTHOR-12 | F | - | F | L | I | L | L | F | L | F | F | I |
| REVIEW-01 | F | F | F | F | I | L | - | - | L | F | - | - |
| REVIEW-02 | F | F | F | F | I | L | - | - | I | F | - | - |
| REVIEW-03 | F | - | - | I | I | L | - | - | I | F | - | - |
| REVIEW-04 | F | F | - | I | I | L | L | - | I | F | F | I |
| REVIEW-05 | F | F | - | F | I | L | L | - | F | ? | - | - |
| REVIEW-09 | F | - | - | F | I | L | L | ? | I | F | - | I |
| REVIEW-10 | F | - | - | I | I | L | L | - | I | F | F | I |
| EXPORT-01 | F | - | I | I | I | L | - | - | I | F | - | - |
| EXPORT-02 | F | F | - | F | I | L | L | - | F | ? | - | - |
| EXPORT-03 | F | - | - | F | I | L | L | - | L | F | - | - |
| EXPORT-04 | F | - | - | I | I | L | L | - | I | F | - | I |
| EXPORT-06 | F | F | - | L | I | ? | ? | - | L | ? | - | I |
| EXPORT-07 | F | - | - | - | I | L | - | - | - | F | - | - |
| EXPORT-08 | F | - | - | F | I | L | L | - | F | F | - | I |

## 3. Project Lifecycle Coverage

| ID | Ready | Loading | Empty | Error | Offline | Back | Cancel | Skip | Retry | Resume | Undo | Impact |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| HOME-02 | F | F | F | I | I | L | - | - | I | F | - | - |
| HOME-03 | F | F | F | I | I | L | L | - | I | F | - | - |
| HOME-04 | F | - | - | F | I | L | L | - | F | F | ? | F |
| HOME-05 | F | F | - | F | ? | L | L | - | F | F | - | - |
| CREATE-03 | F | F | - | L | I | L | L | - | L | ? | - | I |
| CREATE-04 | F | F | F | F | I | L | L | F | I | F | I | I |
| CREATE-05 | F | - | - | F | I | L | L | - | F | ? | - | - |
| HISTORY-01 | F | F | F | I | I | L | - | - | I | F | - | - |
| HISTORY-02 | F | F | - | F | I | L | L | - | I | F | - | L |
| HISTORY-03 | F | - | - | F | I | L | L | - | I | F | - | F |
| HISTORY-04 | F | F | - | F | I | L | - | - | F | F | - | I |

## 4. Spatial Setup Coverage

| ID | Ready | Loading | Empty | Error | Offline | Back | Cancel | Skip | Retry | Resume | Undo | Impact |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| SETUP-07 | F | - | - | F | I | L | L | - | I | F | ? | F |
| SETUP-10 | F | - | - | F | I | L | L | - | I | F | ? | F |
| FLOOR-03 | F | F | F | F | I | L | L | F | F | ? | - | - |
| FLOOR-05 | F | - | F | F | I | L | L | F | F | ? | F | I |
| FLOOR-06 | F | F | - | F | I | L | L | F | F | ? | F | I |
| FLOOR-07 | F | - | - | F | I | L | L | - | F | F | - | L |
| FLOOR-08 | F | F | - | F | I | L | L | - | F | F | ? | F |
| FLOOR-09 | F | - | - | F | I | L | L | F | F | ? | - | - |

## 5. Editor & Authoring Coverage

| ID | Ready | Loading | Empty | Error | Offline | Back | Cancel | Skip | Retry | Resume | Undo | Impact |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| EDIT-03 | F | F | F | I | I | L | L | - | I | F | - | I |
| EDIT-04 | F | - | F | I | I | L | L | - | I | F | I | I |
| EDIT-05 | F | - | - | I | I | L | L | - | I | F | I | I |
| EDIT-06 | F | - | F | I | I | L | L | - | I | I | - | - |
| EDIT-07 | F | F | F | F | I | L | L | - | F | F | - | - |
| AUTHOR-03 | F | - | - | F | I | L | F | - | I | F | F | I |
| AUTHOR-04 | F | - | - | F | I | L | F | - | I | F | F | I |
| AUTHOR-06 | F | F | F | F | I | L | L | - | F | F | F | I |
| AUTHOR-07 | F | - | - | F | I | L | L | - | I | F | F | F |
| AUTHOR-09 | F | F | F | F | I | L | L | F | F | F | I | I |
| AUTHOR-10 | F | - | F | F | I | L | L | F | F | F | F | I |
| AUTHOR-13 | F | - | - | F | I | L | L | F | F | F | F | I |
| AUTHOR-14 | F | F | F | F | I | L | L | F | F | F | F | I |

## 6. Review & Progress Coverage

| ID | Ready | Loading | Empty | Error | Offline | Back | Cancel | Skip | Retry | Resume | Undo | Impact |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| REVIEW-06 | F | F | F | F | I | L | - | - | F | F | - | - |
| REVIEW-07 | F | F | F | I | I | L | - | F | I | F | - | I |
| REVIEW-08 | F | F | F | I | I | L | - | F | I | F | - | I |
| REVIEW-11 | F | - | - | F | I | L | L | F | I | F | - | F |

### REVIEW-06 재검사 결과 Deep Dive

| 상태 | 별도 Frame | 다음 행동 | 보존 규칙 |
|---|---:|---|---|
| 수정 성공·다른 문제 존재 | F | 전체 문제 보기 | 해결된 문제는 성공 배너에만 표시 |
| 전체 문제 목록 | F | 사용자가 문제 선택 | 필터·스크롤·건물/층 펼침·정렬 유지 |
| 같은 오류 존재 | L | 기존 문제 위치 화면으로 이동 | `다시`, `여전히`, `아직` 표현 금지 |
| 문제 수정 취소 | F | 계속 수정 / 변경 사항 버리기 | 버리면 편집 전 Geometry 복원 |
| 앱 내 오류 0 | F | 내보내기 준비 확인 | Apple Validator 확인은 별도 단계 |

## 7. Export & System Coverage

| ID | Ready | Loading | Empty | Error | Offline | Back | Cancel | Skip | Retry | Resume | Undo | Impact |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| EXPORT-05 | F | - | - | I | I | L | L | - | I | F | - | F |
| EXPORT-09 | F | F | F | F | F | L | L | F | F | F | - | - |
| SYSTEM-01 | F | - | - | I | F | L | L | F | F | F | - | I |
| SYSTEM-02 | F | F | F | F | F | L | L | - | F | F | - | I |
| SYSTEM-03 | F | F | - | F | F | L | L | F | F | F | ? | F |
| SYSTEM-04 | F | F | - | F | ? | L | L | F | F | F | F | I |
| SYSTEM-05 | F | F | - | F | F | - | - | - | F | F | - | - |
| SYSTEM-06 | F | F | F | F | I | L | L | - | F | F | - | - |
| SYSTEM-07 | F | F | F | F | I | L | L | - | F | F | - | - |
| SYSTEM-08 | F | F | F | F | I | L | L | - | F | F | F | I |

## 8. Step 0에서 발견한 논리적 구멍

아래 GAP은 초기 분석 기록이다. GAP-01·04·05는 D-LF-001~003, GAP-02·03·06~10은 D-LF-004~010으로 모두 결정되었다. 최종 화면·연결 증거는 `10-lofi-completion-report.md`에 기록한다.

### GAP-01 프로젝트 생성 시점

주소 검색 또는 파일 선택 전에 임시 프로젝트가 생성되는지 미결정이다.

확인해야 할 영향:

- 중간에 앱을 종료했을 때 최근 프로젝트에 나타나는가?
- 이름만 있는 빈 프로젝트를 허용하는가?
- 취소하면 임시 프로젝트가 삭제되는가?

### GAP-02 Setup 단계의 Skip 단위

주소, Venue, Building, Level을 각각 건너뛸 수 있는지 또는 Setup 전체만 건너뛸 수 있는지 미결정이다.

### GAP-03 계층 삭제와 복구

Building 또는 Level 삭제 시 하위 Feature를 함께 삭제할지, 다른 대상으로 이동할지, 복구 가능한 상태로 보관할지 미결정이다.

### GAP-04 Draft 중 Back과 앱 종료

Geometry Draft 작성 중 Back, Feature 전환, 층 전환, 앱 종료 시 Draft를 저장·폐기·복구할지 미결정이다.

### GAP-05 제출용 ZIP과 미완료

오류는 차단하고 경고는 확인 후 허용하기로 했지만, `미완료`가 제출용 ZIP을 차단하는지 명확하지 않다.

### GAP-06 내보내기 진행 중 취소

ZIP 생성 중 취소할 수 있는지, 취소 시 부분 파일을 어떻게 처리하는지 미결정이다.

### GAP-07 도면 교체 후 Geometry 처리

기존 Geometry를 유지하고 검토 필요로 전환하는 방향은 합의됐지만, 자동으로 함께 변환할지 기존 지도 좌표에 고정할지 명시되지 않았다.

### GAP-08 버전 복원 범위

프로젝트 전체만 복원하는지, Building·Level 단위 복원을 지원하는지 미결정이다.

### GAP-09 iCloud 충돌 해결

최신 버전 선택, 두 버전 복사 보존, 수동 병합 중 MVP에서 어떤 방식까지 지원할지 미결정이다.

### GAP-10 기존 IMDF Import 범위

여러 Venue 또는 앱이 아직 지원하지 않는 필드가 포함된 IMDF를 가져올 때 보존·경고·거절 정책이 미결정이다.

## 9. 첫 Wireflow에 포함할 P0 Screen

첫 End-to-End Skeleton은 다음 31개 대표 Screen Family를 사용한다.

```text
HOME-01 Recent Projects
CREATE-01 Start Method
CREATE-02 Project Basics
SETUP-02 Address Search
SETUP-03 Map Confirmation
SETUP-04 Venue Detail
SETUP-05 Building List
SETUP-06 Building Detail
SETUP-08 Level List
SETUP-09 Level Detail
FLOOR-01 Floor Plan Hub
FLOOR-02 Floor Plan Import
FLOOR-04 Manual Alignment
EDIT-01 Project Overview
EDIT-02 Editor Shell
AUTHOR-01 Feature Picker
AUTHOR-02 Polygon Drawing
AUTHOR-05 Continuous Authoring
AUTHOR-08 Feature Inspector
AUTHOR-11 Relationship Picker
AUTHOR-12 Map Relationship Mode
REVIEW-01 Issue Summary
REVIEW-03 Issue Detail
REVIEW-04 Issue Location
AUTHOR-06 Geometry Selection & Edit
REVIEW-05 Recheck
REVIEW-06 Recheck Result
EXPORT-01 Export Hub
EXPORT-02 Submission Preflight
EXPORT-06 Export Progress
EXPORT-07 Export Success
```

첫 Skeleton은 각 화면의 Ready 상태만 얇게 연결했다. `D-LF-001`~`D-LF-003`은 초기 화면에, 이후 승인된 `D-LF-004`~`D-LF-010`은 전체 확장 화면에 반영했다. 이 문단은 초기 제작 순서의 이력이며 최종 상태는 `11-final-coverage-matrix.md`를 기준으로 한다.
