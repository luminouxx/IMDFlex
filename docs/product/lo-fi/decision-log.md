# Lo-Fi Decision Log

## D-LF-001 - Draft Project 생성 시점

- Status: Approved
- Approved: 2026-08-20
- Decision: Start Method를 선택하고 Project Basics에서 이름을 확인하는 순간 `Draft Project`를 생성한다.
- Behavior:
  - 주소가 없어도 최근 프로젝트에 Draft로 표시한다.
  - Setup 진행 상황을 자동 저장한다.
  - 사용자가 명시적으로 취소할 때 Draft 폐기를 확인한다.
  - 앱 종료 후 Draft Project에서 다시 시작할 수 있다.
- Affects: HOME-01, CREATE-01, CREATE-02, SETUP-01

## D-LF-002 - Drawing Draft 이탈과 복구

- Status: Approved
- Approved: 2026-08-20
- Decision: 비의도적 이탈에서는 Drawing Draft를 보존하고, 의도적으로 Context를 바꿀 때는 확인한다.
- Behavior:
  - 앱 Background·종료 시 Draft를 자동 보존한다.
  - 다음 진입 시 Draft를 복구한다.
  - 도구·Building·Level 전환 시 `계속 그리기` 또는 `초안 버리기`를 선택한다.
  - 유효하지 않은 Geometry를 Feature로 자동 저장하지 않는다.
  - Draft 작성 중 Undo를 지원한다.
- Affects: AUTHOR-02, AUTHOR-03, AUTHOR-04, AUTHOR-05, EDIT-03

## D-LF-003 - 미완료와 제출용 ZIP

- Status: Approved
- Approved: 2026-08-20
- Decision: 미완료를 제출 차단형과 Workflow 경고형으로 분리한다.
- Types:
  - Submission-blocking Incomplete: IMDF 필수 속성·관계가 없어 제출용 ZIP을 차단한다.
  - Workflow Incomplete: 유효한 IMDF이지만 앱의 권장 작업이 남아 있으며, 경고 후 제출할 수 있다.
- Development ZIP: 두 종류의 미완료와 관계없이 내보낼 수 있다.
- Affects: REVIEW-01, REVIEW-02, AUTHOR-14, EXPORT-02, EXPORT-03, EXPORT-04, EXPORT-05

## D-LF-004 - Setup 세부 단계 Skip

- Status: Approved
- Approved: 2026-08-25
- Decision: 권장 순서는 유지하되 각 Setup 단계에서 나갈 수 있다.
- Behavior:
  - 건너뛴 필수 정보는 `미완료`로 기록한다.
  - 선행 데이터가 필요한 작업만 차단하고 프로젝트 탐색과 다른 Setup은 허용한다.
  - Project Overview와 Setup Overview에서 다음 미완료 작업을 다시 열 수 있다.
- Affects: SETUP-01~10, EDIT-01, REVIEW-01

## D-LF-005 - Building·Level 삭제와 복구

- Status: Approved
- Approved: 2026-08-25
- Decision: 삭제 전 영향 범위를 보여주고 현재 프로젝트의 복구 버전을 만든 뒤 하위 데이터를 함께 삭제한다.
- Behavior:
  - Building 삭제는 하위 Level·평면도·Feature·관계를 포함한다.
  - Level 삭제는 해당 Level의 평면도·Feature·관계를 포함한다.
  - 기존 내보내기 버전은 변경하지 않는다.
  - 삭제 결과는 Version History에서 프로젝트 전체 단위로 복원할 수 있다.
- Affects: SETUP-07, SETUP-10, HISTORY-01~04

## D-LF-006 - ZIP 생성 중 취소

- Status: Approved
- Approved: 2026-08-25
- Decision: 사용자가 확인하면 ZIP 생성을 중단하고 임시 파일을 삭제한다.
- Behavior:
  - 프로젝트 데이터와 마지막 저장 버전은 유지한다.
  - 완료되지 않은 내보내기 버전은 만들지 않는다.
  - 사용자는 Export Hub로 돌아가 재시도할 수 있다.
- Affects: EXPORT-06, EXPORT-08

## D-LF-007 - 도면 교체 후 Geometry

- Status: Approved
- Approved: 2026-08-25
- Decision: 기존 Geometry를 지도 좌표에 고정하고 새 도면에 맞춰 자동 이동하지 않는다.
- Behavior:
  - 새 도면은 다시 정렬한다.
  - 해당 Level을 `검토 필요`로 전환한다.
  - Geometry·Opening 경계·관계를 확인한 후 재검사한다.
- Affects: FLOOR-07, FLOOR-08, REVIEW-11

## D-LF-008 - 프로젝트 버전 복원

- Status: Approved
- Approved: 2026-08-25
- Decision: MVP 복원 단위는 프로젝트 전체다.
- Behavior:
  - 복원 전 현재 상태를 복구 버전으로 저장한다.
  - 복원 결과도 새로운 버전으로 기록한다.
  - Building·Level 부분 복원은 후속 기능으로 둔다.
- Affects: HISTORY-01~04

## D-LF-009 - iCloud 충돌

- Status: Approved
- Approved: 2026-08-25
- Decision: 자동 병합하거나 한 버전을 덮어쓰지 않고 두 버전을 모두 보존한다.
- Behavior:
  - 사용자가 계속 사용할 버전을 선택한다.
  - 선택하지 않은 버전은 독립 프로젝트 복사본으로 저장한다.
  - 해결을 미루면 동기화만 멈추고 로컬 편집은 보존한다.
- Affects: SYSTEM-02, SYSTEM-03

## D-LF-010 - 기존 IMDF Import

- Status: Approved
- Approved: 2026-08-25
- Decision: 편집 가능한 데이터, 보존 가능한 미지원 데이터, 가져올 수 없는 데이터를 구분한다.
- Behavior:
  - 지원하는 유효 데이터는 편집 가능한 Domain 모델로 가져온다.
  - 유효하지만 UI가 지원하지 않는 필드는 원본 값으로 보존하고 경고한다.
  - Schema가 손상됐거나 읽을 수 없는 파일은 가져오지 않으며 원본 파일을 변경하지 않는다.
  - Import Review에서 누락과 보존 항목을 프로젝트 생성 전에 보여준다.
- Affects: CREATE-03, CREATE-04, CREATE-05

## D-LF-011 - Opening과 Unit의 연결 의미

- Status: Approved by IMDF schema verification
- Decision: Opening은 별도의 Unit–Opening `relationship` Feature를 생성해 연결하지 않는다. Opening LineString이 Unit 경계에 포함되는지를 Geometry·topology 규칙으로 확인한다.
- UX consequence: 작성 흐름은 `Opening 그리기 → 속성 → Unit 경계 확인`이며, `Relationship` 선택기라는 표현을 사용하지 않는다.
- Verification owner: Domain schema tests, Preflight, Apple IMDF Validator 확인

## D-LF-012 - Setup 공간 Geometry 작성

- Status: Approved for Lo-Fi
- Decision: 자동 추론으로 완료 처리하지 않고 Venue 경계, Building Footprint, Level 경계를 사용자가 지도에서 직접 지정·확인한다.
- UX consequence: Venue 정보, Building 정보, Level 정보 저장 뒤 각각 Geometry 확인 화면을 거친다. 유효하지 않은 Polygon은 완료로 저장할 수 없다.
- Verification owner: Geometry domain tests and setup usability test

## D-LF-013 - 내보내기 유형의 흐름 분리

- Status: Approved
- Decision: Apple 제출용 ZIP, 개발·검토용 ZIP, 프로젝트 패키지는 선택부터 진행·완료 결과까지 유형을 유지한다. 한 유형의 성공 화면을 다른 유형이 공유하지 않는다.
- UX consequence: 오류 상태에서 제출용 ZIP은 차단되며, 개발·검토용 ZIP 완료 화면에는 제출 가능 또는 Validator 통과를 암시하는 문구를 표시하지 않는다.
- Verification owner: Export coordinator tests, Preflight tests, task T5
