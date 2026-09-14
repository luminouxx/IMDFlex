# Lo-Fi Final Coverage Matrix

Status: 완료 · 82개 Screen Family / 93개 상태 화면 검증

검증일: 2026-08-25

## 1. 최종 상태 표현 규칙

| 방식 | 의미 |
|---|---|
| 별도 화면 | 판단, 데이터 손실, 실패 복구처럼 사용자 선택이 필요한 상태 |
| 화면 내부 상태 | 선택, Loading, Empty, Toggle처럼 같은 정보 구조 안에서 변하는 상태 |
| 연결 화면 | 이미 독립 Screen Family로 정의된 상세·복구 화면으로 이동 |

## 2. 영역별 최종 Coverage

| 영역 | ID | 수 | 검증 결과 |
|---|---|---:|---|
| 프로젝트 홈 | HOME-01~05 | 5 | 완료 |
| 생성·가져오기 | CREATE-01~05 | 5 | 완료 |
| 장소·건물·층 | SETUP-01~10 | 10 | 완료 |
| 평면도 | FLOOR-01~09 | 9 | 완료 |
| 프로젝트 개요·Editor | EDIT-01~07 | 7 | 완료 |
| Feature 작성 | AUTHOR-01~14 | 14 | 완료 |
| 문제·진행 | REVIEW-01~11 | 11 | 완료 |
| 내보내기 | EXPORT-01~09 | 9 | 완료 |
| 기록·버전 | HISTORY-01~04 | 4 | 완료 |
| 시스템 | SYSTEM-01~08 | 8 | 완료 |

## 3. 위험 상태 Coverage

| 상태 | 표현 | 복구·다음 행동 | 판정 |
|---|---|---|---|
| Draft Project 취소 | 별도 화면 | 계속 작성 / Draft 폐기 | 닫힘 |
| 주소 검색 오프라인 | 별도 화면 | 오프라인 편집 / 재시도 | 닫힘 |
| 주소·지도 로딩 실패 | 별도 화면 | 다시 검색 / 취소 | 닫힘 |
| 파일 Import 실패 | 별도 화면 | 다시 선택 / 도움말 / 취소 | 닫힘 |
| Drawing Draft 이탈 | 별도 화면 | 계속 그리기 / 초안 버리기 | 닫힘 |
| 잘못된 Geometry | 편집 상태 | 문제 꼭짓점 표시 / 수정 저장 | 닫힘 |
| Geometry 삭제 | 별도 화면 | 영향 확인 / 삭제 / 취소 | 닫힘 |
| 잘못된 관계 | 별도 화면 | 기존 선택 화면 복귀 / 취소 | 닫힘 |
| 재검사 후 다른 문제 | 별도 화면 | 다음 문제 / 전체 문제 | 닫힘 |
| 재검사 후 같은 문제 | 연결 화면 | 기존 문제 위치·설명 / 수정 시작 | 닫힘 |
| 수정 중 취소 | 별도 화면 | 계속 수정 / 변경 버리기 | 닫힘 |
| 앱 내 오류 0 | 별도 화면 | 내보내기 준비 | 닫힘 |
| 제출 차단 | 별도 화면 | 문제로 이동 / 취소 | 닫힘 |
| 경고 포함 제출 | 별도 화면 | 확인 후 진행 / 문제 보기 | 닫힘 |
| 검토용 ZIP | 별도 화면 | 문제 포함 확인 / 생성 | 닫힘 |
| ZIP 생성 취소 | 별도 화면 | 생성 계속 / 취소 확정 | 닫힘 |
| ZIP 생성 실패 | 별도 화면 | 재시도 / 위치 변경 / 취소 | 닫힘 |
| 도면 교체 영향 | 별도 화면 | 교체 / 취소 / 검토 필요 | 닫힘 |
| Building·Level 삭제 | 별도 화면 | 영향 확인 / 복구 버전 / 취소 | 닫힘 |
| 버전 복원 | 3단계 화면 | 상세 / 확인 / 결과 | 닫힘 |
| iCloud 충돌 | 별도 화면 | 두 버전 보존 / 활성 버전 선택 | 닫힘 |
| 프로젝트 잠금 | 별도 화면 | Face ID / 취소 | 닫힘 |
| 개인정보 보호 | 별도 화면 | 잠금 해제 후 복귀 | 닫힘 |

## 3-1. Screen Family 전수 확인 목록

아래 82개 ID는 `01-screen-inventory.md`와 Figma 화면명에서 모두 1:1로 확인했다.

```text
HOME-01 HOME-02 HOME-03 HOME-04 HOME-05
CREATE-01 CREATE-02 CREATE-03 CREATE-04 CREATE-05
SETUP-01 SETUP-02 SETUP-03 SETUP-04 SETUP-05
SETUP-06 SETUP-07 SETUP-08 SETUP-09 SETUP-10
FLOOR-01 FLOOR-02 FLOOR-03 FLOOR-04 FLOOR-05
FLOOR-06 FLOOR-07 FLOOR-08 FLOOR-09
EDIT-01 EDIT-02 EDIT-03 EDIT-04 EDIT-05 EDIT-06 EDIT-07
AUTHOR-01 AUTHOR-02 AUTHOR-03 AUTHOR-04 AUTHOR-05
AUTHOR-06 AUTHOR-07 AUTHOR-08 AUTHOR-09 AUTHOR-10
AUTHOR-11 AUTHOR-12 AUTHOR-13 AUTHOR-14
REVIEW-01 REVIEW-02 REVIEW-03 REVIEW-04 REVIEW-05
REVIEW-06 REVIEW-07 REVIEW-08 REVIEW-09 REVIEW-10 REVIEW-11
EXPORT-01 EXPORT-02 EXPORT-03 EXPORT-04 EXPORT-05
EXPORT-06 EXPORT-07 EXPORT-08 EXPORT-09
HISTORY-01 HISTORY-02 HISTORY-03 HISTORY-04
SYSTEM-01 SYSTEM-02 SYSTEM-03 SYSTEM-04
SYSTEM-05 SYSTEM-06 SYSTEM-07 SYSTEM-08
```

## 4. 상태별 공통 검증

| 상태 | 최종 규칙 |
|---|---|
| Loading | 진행 대상과 취소·대기 가능 여부를 함께 표시 |
| Empty | 빈 이유와 첫 생성 행동을 제공 |
| Error | 쉬운 원인, 위치·대상, 복구 행동을 제공 |
| Offline | 오프라인 가능한 작업과 불가능한 작업을 분리 |
| Back | 편집 Draft가 없으면 즉시 이동, 있으면 보존·폐기 확인 |
| Cancel | 데이터 손실 가능성이 있으면 확인 화면 사용 |
| Skip | 미완료로 기록하고 종속 작업만 차단 |
| Retry | 같은 입력과 맥락을 보존한 채 재시도 |
| Resume | 마지막 프로젝트·위치·필터·Draft 복구 |
| Undo | 현재 편집 세션에서 실행 취소·다시 실행 지원 |
| Impact | 삭제·교체·복원 전에 영향 범위 표시 |

## 5. 자동 검사 결과

| 검사 | 결과 |
|---|---:|
| 기대 Screen Family | 82 |
| 확인 Screen Family | 82 |
| 누락 | 0 |
| 상태 화면 | 93 |
| 화면별 이동 경로 보유 | 93 |
| 이동 경로 없는 화면 | 0 |
| Prototype 연결 | 284 |
| Placeholder | 0 |
| 화면 경계 이탈 | 0 |
| 누락 글꼴 | 0 |

초기 `02-coverage-matrix.md`의 `?`와 GAP 기록은 설계 과정의 이력으로 보존한다. 최종 완료 판단은 이 문서와 `10-lofi-completion-report.md`를 기준으로 한다.
