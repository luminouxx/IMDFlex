# IMDFlex Lo-Fi Agent Pilot Round 1 보고서

Status: Complete · Human Pilot 준비 완료

작성일: 2026-08-26

Figma: [Lo-Fi Prototype](https://www.figma.com/design/kqT9zmJTq9nOoV43y6hYqS?node-id=51-2)

## 1. 결론

초기 Agent Pilot은 6개 과업 중 독립 성공 예상 1개, 총점 3/12였다. 제출 차단 우회 S0를 포함해 사람에게 테스트할 수 없는 상태였다.

세 차례 수정·재검사 후 세 팀의 최종 예상 점수는 12/12, 잔존 S0·S1은 0건이다. T1~T6의 의도된 경로가 모두 연결됐고, 자동 검사는 존재하지 않는 목적지 0개, 핵심 문제 목록의 비활성 행 0개를 확인했다. 최종 사람 대상 검증은 실제 참가자의 행동으로 별도 확인해야 하며, Agent Pilot 통과를 사용성 검증 완료로 해석하지 않는다.

## 2. 참가 팀

| 팀 | 역할 | 주요 책임 |
|---|---|---|
| IMDF 실무 검증 | Apple IMDF 의미·Category·Geometry 검토 | Opening, Relationship, 차단형 미완료, 공간 Geometry |
| 인접 전문도구 사용자 | 설명 없이 실제 클릭 경로 수행 | 첫 행동, Dead end, 상태 혼합, 복구 가능성 |
| UX Research | 과업과 측정 도구의 타당성 검토 | 답 노출, 시작 상태, 관찰 가능한 성공, 힌트·시간 |
| Orchestrator | 근거 통합·Figma 및 문서 수정·자동 재검사 | 우선순위, Decision 기록, 최종 Gate |

## 3. 초기 기준선

| 과업 | 초기 예상 점수 | 핵심 문제 |
|---|---:|---|
| T1 프로젝트·공간 구조 | 0 | 새 프로젝트에 건물·층이 이미 존재하고 공간 Geometry 작성 없음 |
| T2 평면도 등록·정렬 | 0 | PDF 페이지 선택 화면에 유입 없음 |
| T3 Unit·Opening | 0 | Unit–Opening topology를 IMDF Relationship로 잘못 표현 |
| T4 오류 수정·재검사 | 2 | 주 경로는 가능하나 문제 선택성이 제한됨 |
| T5 내보내기 판단 | 0 | 오류 상태에서 제출용 ZIP 성공으로 우회 가능 |
| T6 도면 교체·검토 | 0 | 재정렬 뒤 Review Required로 돌아오지 않음 |

## 4. S0 수정

1. `EXPORT-02`의 다시 검사는 오류 상태에서 `EXPORT-03 제출 차단`으로만 이동한다.
2. 검토용 ZIP은 확인 → 진행 → 취소 → 완료 전 과정에서 제출용 상태와 분리했다.
3. Opening Category 예시는 공식 값인 `pedestrian`을 사용한다.
4. Opening은 별도 Unit–Opening Relationship을 만들지 않고 Unit 경계 위 LineString 포함 여부로 확인한다.
5. 1층·2층과 ordinal이 뒤바뀌지 않도록 T1 완료 상태를 교정했다.

## 5. 주요 설계 수정

- 새 프로젝트: 빈 건물 목록 → A동 → Venue 경계 → Building Footprint → 빈 층 목록 → 1층·2층과 각 Level 경계 → 전용 평면도 허브
- 평면도: 파일 선택 → PDF 페이지 선택 → 수동 또는 기준점 정렬 → 정렬 결과 → 적용
- Feature: Unit Polygon과 Opening LineString을 별도 작성하고, Opening 경계 오류와 정상 완료를 구분
- 검토: 전체 문제 목록의 Unit·Opening·Amenity 행을 각 원인·수정 방법 화면에 연결
- 내보내기: 오류 차단, 경고 확인, 검토용 ZIP, ZIP 실패를 독립 상태로 테스트
- 도면 교체: 교체 시작 → 영향 확인 → 재정렬 → Review Required → 영향 Feature 상세

## 6. 최종 검증 증거

| 검증 | 결과 |
|---|---|
| T1 주요 행동 16개 목적지 | 모두 일치 |
| T2 PDF 페이지와 정렬 결과 | 연결됨 |
| T3A Unit 저장 후 Feature 선택기 복귀 | 연결됨 |
| T3B Opening 성공 종료 | `AUTHOR-12S`로 연결됨 |
| T3C 경계 밖 후보 | `AUTHOR-13`으로 연결됨 |
| T4 문제 목록 | 3개 행 모두 상세 화면 연결 |
| T5 오류 재검사 우회 | 제거됨 |
| T5 검토용 취소 문맥 | 별도 상태로 분리됨 |
| T6 Review Required 문맥 | 상세 검토까지 유지 |
| 존재하지 않는 Figma 목적지 | 0개 |
| 3개 팀 최종 Gate | 12/12 · S0 0 · S1 0 |

## 7. 결정 기록

- D-LF-011: Opening은 Unit 경계 topology로 확인하며 Unit–Opening Relationship을 생성하지 않는다.
- D-LF-012: Venue, Building Footprint, Level Geometry는 자동 추론하지 않고 직접 지정·확인한다.
- D-LF-013: 내보내기 유형은 선택부터 진행·완료까지 정체성을 유지한다.

공식 의미 검토 기준은 [Apple Indoor Mapping Data Format](https://register.apple.com/resources/imdf/)과 저장소 Domain 모델이다.

## 8. 다음 Gate

다음은 사용자가 옆에서 관찰하는 Human Pilot 1명이다. 첫 세션은 75분으로 진행하고, `12-usability-test-plan.md`의 T1~T6와 `13-usability-observation-sheet.md`를 사용한다. Human Pilot에서 S0 또는 동일 S1이 나오면 5명 테스트로 넘어가지 않고 해당 과업만 다시 수정한다.
