# Lo-Fi Screen Inventory

Status: 82개 Screen Family Lo-Fi 반영 완료

이 문서는 IMDFlex 전체 IA를 Lo-Fi Prototype에서 추적 가능한 Screen Family로 변환한다. 하나의 Screen Family는 여러 상태 Frame을 가질 수 있다.

## 1. 식별 규칙

```text
[영역]-[순번] / [화면] / [상태]
```

예시:

```text
HOME-01 / Recent Projects / Ready
HOME-01 / Recent Projects / Empty
SETUP-02 / Address Search / Error
EDIT-05 / Geometry Drawing / Active
REVIEW-03 / Issue Detail / Selected
```

영역 Prefix:

| Prefix | 영역 |
|---|---|
| HOME | 프로젝트 홈 |
| CREATE | 프로젝트 생성·가져오기 |
| SETUP | 주소·Venue·Building·Level |
| FLOOR | 평면도 등록·정렬 |
| EDIT | 지도 기반 편집 작업 공간 |
| AUTHOR | Feature·속성·관계 작성 |
| REVIEW | 문제·진행·완료 |
| EXPORT | Preflight·ZIP 내보내기 |
| HISTORY | 기록·버전·복원 |
| SYSTEM | 동기화·보안·도움말·설정 |

## 2. Prototype 우선순위

| 등급 | 의미 |
|---|---|
| P0 | 첫 End-to-End Skeleton에 반드시 포함 |
| P1 | 해당 Milestone의 사용성 검증에 필요 |
| P2 | 전체 논리 QA 전까지 필요 |

## 3. 프로젝트 홈

| ID | Screen Family | 목적 | 주요 진입 | 주요 종료 | 우선순위 |
|---|---|---|---|---|---|
| HOME-01 | Recent Projects | 최근 프로젝트와 상태 확인 | 앱 실행, 프로젝트 종료 | 프로젝트 열기, 전체 목록, 새 프로젝트 | P0 |
| HOME-02 | All Projects | 전체 프로젝트 검색·관리 | HOME-01 | 프로젝트 열기, Project Actions | P1 |
| HOME-03 | Project Search | 이름·주소로 프로젝트 검색 | HOME-01, HOME-02 | 검색 결과 선택, 검색 해제 | P1 |
| HOME-04 | Project Actions | 이름 변경·잠금·패키지·삭제 | 프로젝트 Context Menu | 실행, 취소, 확인 Dialog | P2 |
| HOME-05 | Locked Project Unlock | Face ID로 잠긴 프로젝트 열기 | HOME-01, HOME-02 | 프로젝트 열기, 취소 | P2 |

## 4. 프로젝트 생성·가져오기

| ID | Screen Family | 목적 | 주요 진입 | 주요 종료 | 우선순위 |
|---|---|---|---|---|---|
| CREATE-01 | Start Method | 새 프로젝트 시작 방식 선택 | HOME-01 | 주소에서 시작, 평면도, GeoJSON, IMDF, 패키지 | P0 |
| CREATE-02 | Project Basics | 프로젝트 이름과 임시 정보 확인 | CREATE-01 | Address Search, Setup Overview | P0 |
| CREATE-03 | Source Import | 파일 선택과 Import 진행 | CREATE-01 | Import Review, 실패, 취소 | P1 |
| CREATE-04 | Import Review | 가져온 데이터와 누락 확인 | CREATE-03 | 프로젝트 생성, 수정, 취소 | P1 |
| CREATE-05 | Import Failure | 파일·Schema·권한 오류 설명 | CREATE-03 | 다시 선택, 도움말, 취소 | P1 |

## 5. 주소·Venue·Building·Level

| ID | Screen Family | 목적 | 주요 진입 | 주요 종료 | 우선순위 |
|---|---|---|---|---|---|
| SETUP-01 | Setup Overview | 장소 설정 단계와 누락 확인 | 프로젝트 생성, Project Overview | 주소, Venue, Building, Level 설정 | P0 |
| SETUP-02 | Address Search | 주소 검색과 결과 선택 | CREATE-02, SETUP-01 | Map Confirmation, 스킵, 취소 | P0 |
| SETUP-03 | Map Confirmation | 지도 위치와 검색 결과 확인 | SETUP-02 | 주소 확정, 다시 검색 | P0 |
| SETUP-04 | Venue Detail | Venue 정보와 주소 연결 | SETUP-01, SETUP-03 | 저장, 취소 | P0 |
| SETUP-05 | Building List | Venue 내 Building 관리 | SETUP-01, Venue Context | Building 추가·선택 | P0 |
| SETUP-06 | Building Detail | Building 이름·Footprint 수정 | SETUP-05 | 저장, 삭제, 취소 | P0 |
| SETUP-07 | Building Delete Impact | Building 삭제 영향 확인 | SETUP-06 | 삭제, 취소 | P2 |
| SETUP-08 | Level List | 건물별·전체 Level 관리 | SETUP-01, Editor Context | Level 추가·선택·정렬 | P0 |
| SETUP-09 | Level Detail | Level 이름·ordinal·Building 연결 | SETUP-08 | 저장, 삭제, 취소 | P0 |
| SETUP-10 | Level Delete Impact | Level과 하위 데이터 삭제 영향 확인 | SETUP-09 | 삭제, 취소 | P2 |

## 6. 평면도 등록·정렬

| ID | Screen Family | 목적 | 주요 진입 | 주요 종료 | 우선순위 |
|---|---|---|---|---|---|
| FLOOR-01 | Floor Plan Hub | 모든 층의 도면 상태 확인 | SETUP-01, Project Overview | 도면 추가·정렬·교체 | P0 |
| FLOOR-02 | Floor Plan Import | 이미지·PDF 선택 | FLOOR-01 | PDF Page Select, Alignment, 실패 | P0 |
| FLOOR-03 | PDF Page Select | 사용할 PDF 페이지 선택 | FLOOR-02 | Alignment, 취소 | P1 |
| FLOOR-04 | Manual Alignment | 이동·Scale·Rotation으로 정렬 | FLOOR-02, FLOOR-01 | 정렬 완료, 스킵, 초기화 | P0 |
| FLOOR-05 | Control Point Alignment | 지도와 도면의 기준점 지정 | FLOOR-04 | 자동 정렬 결과, 다시 지정, 취소 | P1 |
| FLOOR-06 | Alignment Result | 자동 정렬 결과 검토 | FLOOR-05 | 적용, 다시 지정, 수동 조정 | P1 |
| FLOOR-07 | Replace Floor Plan | 기존 도면 교체 | FLOOR-01 | 영향 확인, 취소 | P2 |
| FLOOR-08 | Replacement Impact | 기존 Geometry 영향 확인 | FLOOR-07 | 교체·검토 필요, 취소 | P2 |
| FLOOR-09 | Floor Plan Import Failure | 파일·페이지·권한 오류 복구 | FLOOR-02 | 다시 선택, 취소 | P1 |

## 7. 프로젝트 개요와 Editor Shell

| ID | Screen Family | 목적 | 주요 진입 | 주요 종료 | 우선순위 |
|---|---|---|---|---|---|
| EDIT-01 | Project Overview | 문제·단계·공간 상태와 다음 작업 확인 | 프로젝트 열기, Editor 종료 | Editor, Setup, Review, Export | P0 |
| EDIT-02 | Editor Shell | 지도 중심 편집 구조 제공 | EDIT-01, 마지막 작업 복귀 | Feature 작성, Inspector, Review | P0 |
| EDIT-03 | Building & Level Switcher | 현재 공간 Context 전환 | EDIT-02 | 다른 Building·Level 선택 | P1 |
| EDIT-04 | Layer Controls | Feature·도면·관계 표시 제어 | EDIT-02 | 적용, 닫기 | P1 |
| EDIT-05 | Map Lock Controls | 지도 위치·확대·방향 잠금 | EDIT-02 | 잠금, 해제 | P1 |
| EDIT-06 | Overlapping Selection | 겹친 Feature 중 대상 선택 | EDIT-02 | Feature 선택, 취소 | P1 |
| EDIT-07 | Contextual Help | 현재 도구·Feature 도움말 | Editor와 Inspector | 닫기, 전체 도움말 | P2 |

## 8. Feature·Geometry·속성·관계 작성

| ID | Screen Family | 목적 | 주요 진입 | 주요 종료 | 우선순위 |
|---|---|---|---|---|---|
| AUTHOR-01 | Feature Picker | 검색·최근·추천·전체에서 Feature 선택 | EDIT-02 | Drawing Mode, 취소 | P0 |
| AUTHOR-02 | Polygon Drawing | Polygon Feature 작성 | AUTHOR-01 | Draft 완료, 취소, Undo | P0 |
| AUTHOR-03 | Line Drawing | Line Feature 작성 | AUTHOR-01 | Draft 완료, 취소, Undo | P1 |
| AUTHOR-04 | Point Placement | Point Feature 작성 | AUTHOR-01 | 배치 완료, 취소 | P1 |
| AUTHOR-05 | Continuous Authoring | 같은 Feature를 연속 작성 | Geometry 완료 | 다음 작성, 연속 작성 종료 | P0 |
| AUTHOR-06 | Geometry Selection & Edit | 기존 Geometry 수정 | EDIT-02, 문제 위치 | 저장, 취소, 삭제 | P0 |
| AUTHOR-07 | Geometry Delete Confirm | Feature 삭제 영향 확인 | AUTHOR-06 | 삭제, 취소 | P1 |
| AUTHOR-08 | Feature Inspector | 기본 정보·상태·속성 확인 | Feature 선택, Geometry 완료 | 저장, 닫기, Category, Relationship | P0 |
| AUTHOR-09 | Category Picker | Category 검색·추천·설명 | AUTHOR-08 | Category 선택, 취소, 도움말 | P1 |
| AUTHOR-10 | Property Editor | 필수·선택 속성 입력 | AUTHOR-08 | 저장, 취소 | P1 |
| AUTHOR-11 | Relationship Picker | 유효한 관계 대상 검색·선택 | AUTHOR-08 | 관계 저장, 지도에서 선택, 취소 | P0 |
| AUTHOR-12 | Map Relationship Mode | 지도에서 관계 대상 선택 | AUTHOR-11 | 관계 저장, 잘못된 대상, 취소 | P0 |
| AUTHOR-13 | Invalid Relationship | 관계 불가 이유와 복구 안내 | AUTHOR-11, AUTHOR-12 | 다시 선택, 취소 | P0 |
| AUTHOR-14 | Incomplete Feature Review | 나중에 보완할 속성 목록 | AUTHOR-08, Review | 속성 보완, 다음 항목 | P1 |

## 9. 문제·진행·완료

| ID | Screen Family | 목적 | 주요 진입 | 주요 종료 | 우선순위 |
|---|---|---|---|---|---|
| REVIEW-01 | Issue Summary | 오류·경고·미완료 현황 확인 | EDIT-01, EDIT-02 | Issue List, Recheck | P0 |
| REVIEW-02 | Issue List | 심각도·공간·Feature별 문제 탐색 | REVIEW-01 | Issue Detail, Filter | P0 |
| REVIEW-03 | Issue Detail | 쉬운 설명과 조치 확인 | REVIEW-02, 지도 Marker | 지도 위치 이동, 다음 문제 | P0 |
| REVIEW-04 | Issue Location | 해당 Building·Level·Geometry 강조 | REVIEW-03 | 직접 수정, Issue Detail 복귀 | P0 |
| REVIEW-05 | Recheck | 수정 후 Preflight 재검사 | REVIEW-01, REVIEW-04 | 결과, 취소 | P0 |
| REVIEW-06 | Recheck Result | 해결·남은 문제 확인 | REVIEW-05 | 다음 문제, 완료 | P0 |
| REVIEW-07 | Step Progress | 단계별 완료·스킵·검토 필요 | EDIT-01, EDIT-02 | 단계 이동 | P1 |
| REVIEW-08 | Spatial Progress | Building·Level별 상태 확인 | EDIT-01, EDIT-02 | 공간 이동 | P1 |
| REVIEW-09 | Mark Level Complete | 층 완료와 남은 영향 확인 | REVIEW-07, REVIEW-08 | 완료, 취소 | P0 |
| REVIEW-10 | Reopen Completed Level | 완료된 층 다시 편집 | Level Context | Editor, 취소 | P0 |
| REVIEW-11 | Review Required | 완료 후 변경된 범위 안내 | 도면·Geometry·관계 변경 | 검토, 나중에 | P1 |

## 10. 내보내기

| ID | Screen Family | 목적 | 주요 진입 | 주요 종료 | 우선순위 |
|---|---|---|---|---|---|
| EXPORT-01 | Export Hub | 검토용·제출용 내보내기 선택 | EDIT-01, REVIEW | Preflight, 검토용 Export | P0 |
| EXPORT-02 | Submission Preflight | 제출 전 문제 검사 | EXPORT-01 | 차단, 경고 확인, Export | P0 |
| EXPORT-03 | Blocked Export | 오류·미완료로 제출 차단 | EXPORT-02 | 문제로 이동, 취소 | P0 |
| EXPORT-04 | Warning Confirmation | 경고 확인 후 계속할지 결정 | EXPORT-02 | Export, 취소, 문제 확인 | P0 |
| EXPORT-05 | Review ZIP Confirmation | 문제 포함 검토용 ZIP 확인 | EXPORT-01 | Export, 취소 | P1 |
| EXPORT-06 | Export Progress | ZIP 생성 진행 | EXPORT-04, EXPORT-05 | 성공, 실패, 취소 가능성 | P0 |
| EXPORT-07 | Export Success | 파일·버전·다음 행동 확인 | EXPORT-06 | 공유, 파일 저장, 프로젝트 복귀 | P0 |
| EXPORT-08 | Export Failure | 생성·저장·권한 실패 복구 | EXPORT-06 | 재시도, 위치 변경, 취소 | P0 |
| EXPORT-09 | Apple Validator Guidance | 외부 Validator 확인 안내 | EXPORT-07 | 완료, 도움말 | P1 |

## 11. 기록·버전·복원

| ID | Screen Family | 목적 | 주요 진입 | 주요 종료 | 우선순위 |
|---|---|---|---|---|---|
| HISTORY-01 | Version History | 내보내기와 변경 버전 조회 | Project Overview, Export Success | Version Detail | P2 |
| HISTORY-02 | Version Detail | 버전 내용·문제 상태 확인 | HISTORY-01 | 복원, 닫기 | P2 |
| HISTORY-03 | Restore Confirmation | 현재 변경과 복원 영향 확인 | HISTORY-02 | 복원, 취소 | P2 |
| HISTORY-04 | Restore Result | 복원 성공·실패·검토 필요 확인 | HISTORY-03 | 프로젝트 열기, 재시도 | P2 |

## 12. 시스템·동기화·보안·도움말

| ID | Screen Family | 목적 | 주요 진입 | 주요 종료 | 우선순위 |
|---|---|---|---|---|---|
| SYSTEM-01 | Offline State | 오프라인 가능·불가능 행동 설명 | 네트워크 단절 | 계속 편집, 재시도 | P2 |
| SYSTEM-02 | Sync Status | iCloud 저장·동기화 상태 확인 | Project Context, Settings | 닫기, 문제 해결 | P2 |
| SYSTEM-03 | Sync Conflict | 충돌 버전 비교와 데이터 보존 | 동기화 충돌 | 선택·복사·취소 | P2 |
| SYSTEM-04 | Project Lock Settings | Face ID 잠금 설정 | Project Actions, Settings | 적용, 취소 | P2 |
| SYSTEM-05 | Privacy Shield | 최근 앱 화면의 민감 정보 숨김 | 앱 Background | 잠금 해제 후 복귀 | P2 |
| SYSTEM-06 | Help Search | 전체 도움말 검색 | Home, Contextual Help | 도움말 상세, 닫기 | P2 |
| SYSTEM-07 | Help Detail | 규칙·예시·흔한 실수 확인 | Help Search, Info Button | 이전 화면 복귀 | P2 |
| SYSTEM-08 | App Settings | 저장·동기화·개인정보 설정 | HOME-01 | 적용, 닫기 | P2 |

## 13. Inventory Summary

| 영역 | Screen Family 수 |
|---|---:|
| 프로젝트 홈 | 5 |
| 생성·가져오기 | 5 |
| 장소·건물·층 | 10 |
| 평면도 | 9 |
| 프로젝트 개요·Editor | 7 |
| Feature 작성 | 14 |
| 문제·진행 | 11 |
| 내보내기 | 9 |
| 기록·버전 | 4 |
| 시스템 | 8 |
| 합계 | 82 |

82개는 실제 Frame 수가 아니라 Screen Family 수다. 상태 Frame을 모두 상세 제작하기 전에 Coverage Matrix를 통해 Lo-Fi에서 별도 Frame이 필요한 상태와 화면 내부 변화로 충분한 상태를 구분한다.
