# IMDFlex Lo-Fi Agent Pilot Round 2 보고서

Status: HOLD · Human Pilot 진행 전 보정 필요

작성일: 2026-09-08

검토 범위: Lo-Fi 전체 문서, Agent Pilot Round 1, Human Pilot 진행자·참가자 도구, Apple IMDF validation CSV 1.0.3

## 1. 결론

Round 1에서 해결한 제출 우회, ZIP 유형 혼합, Unit–Opening Relationship 오해와 주요 화면 dead point는 다시 발생하지 않았다. 그러나 Round 2에서 IMDF 의미 S1 5건과 테스트 신뢰도 S1 7건, 예외 과업 coverage S1 3건이 발견됐다.

따라서 현재 Lo-Fi를 논리적으로 완성됐다고 선언하거나 Human Pilot을 시작할 수 없다. 먼저 T1·T3·T4·T5와 Human Pilot 도구를 보정한 뒤 해당 범위만 Agent Pilot Round 2B로 재검사한다.

## 2. 팀별 판정

| 팀 | 판정 | 핵심 결과 |
|---|---|---|
| IMDF 도메인 | HOLD | Opening Unit 경계 조건의 Warning/Violation 해석 오류, 필수 Geometry·Level 검증 누락 |
| 인접 전문도구 사용자 | HOLD | 재검사 실패, 오프라인, 취소·복구가 실행 가능한 과업으로 검증되지 않음 |
| UX Research | HOLD | Figma 편집 링크의 정답 노출, 미래 과업 노출, 채점·시간 기록 결함 |
| Orchestrator | HOLD | 기준 문서의 상태가 서로 다르고 Human Pilot 결과의 신뢰성을 보장할 수 없음 |

## 3. Human Pilot 전 필수 수정

### IMDF 의미와 제품 정책

1. Apple의 `OpeningMustBeCoveredByUnitBoundary`는 Warning이다. Unit 경계 밖 Opening에 대해 저장을 무조건 막지 않고 경고·재배치·유지 판단 경로를 제공한다.
2. T3B 성공 조건에 Opening의 `level_id`와 referenced Level 내부 포함을 추가한다. 이 조건은 Apple validation에서 Violation이다.
3. `AUTHOR-13`의 Invalid Relationship과 Opening 경계 상태를 서로 다른 Screen ID로 분리한다.
4. T1 성공 조건에 Venue Polygon, Building Footprint, 각 Level Polygon을 포함한다.
5. T5에 필수 속성 또는 참조 누락으로 인한 `제출 차단형 미완료` 상태를 추가한다.

### 테스트 도구와 측정

1. 참가자에게 `/design/` 편집 링크 대신 과업별 Present/Prototype 링크를 제공한다.
2. 참가자 화면은 한 번에 한 과업만 보여주고 미래 과업의 제목·상태를 숨긴다.
3. T3B와 T3C의 순서를 분리하거나 독립 초기화해 직전 과업의 정답 학습을 막는다.
4. H1 후 성공의 점수 규칙을 명시한다.
5. 타이머 값을 저장하고 JSON 내보내기에 포함하며 동시에 하나의 타이머만 실행한다.
6. T5에 Preflight와 Apple IMDF Validator의 차이를 묻는 필수 질문·기록란을 추가한다.
7. ZIP 유형 선택 능력과 각 상태의 정책 이해를 별도 과업으로 분리한다.

### 예외 Coverage

1. 같은 오류가 남는 재검사 실패를 독립 과업으로 만든다.
2. 주소 검색 오프라인과 오프라인 편집 가능 범위를 독립 과업으로 만든다.
3. Drawing Draft 이탈, Geometry 수정 취소, ZIP 생성 중 취소를 독립 microtask로 만든다.

## 4. 중요 근거

Apple IMDF validation CSV 1.0.3에서 다음 규칙을 확인했다.

| 규칙 | 심각도 | 제품 반영 |
|---|---|---|
| `OpeningMustHaveLineStringGeometry` | Violation | 저장·완료 차단 |
| `OpeningMustHaveCategory` | Violation | 저장·완료 차단 |
| `OpeningMustReferenceLevel` | Violation | 저장·완료 차단 |
| `OpeningMustBeCoveredByReferencedLevel` | Violation | 저장·완료 차단 |
| `OpeningMustBeCoveredByUnitBoundary` | Warning | 경고 후 수정 또는 유지 판단 |

공식 기준: [Apple Indoor Mapping Data Format](https://register.apple.com/resources/imdf/)

## 5. Round 1에서 해결되어 유지된 항목

- 오류 상태에서 제출용 ZIP으로 우회하는 경로 없음
- 제출용·검토용 ZIP의 확인·진행·완료 상태 분리
- Opening category `pedestrian` 사용
- Unit–Opening 연결을 별도 IMDF Relationship으로 생성하지 않음
- Unit Polygon의 Level 경계 이탈 표현과 Opening 막대 표현 수정
- 재검사 성공 후 남은 문제 목록과 수정 취소 복귀 흐름 연결

## 6. Round 2B Gate

다음 조건을 모두 만족해야 Human Pilot으로 이동한다.

- 위 필수 S1 15건 수정
- T1·T3·T4·T5 및 예외 microtask의 실행 가능한 시작·종료 상태 확인
- 존재하지 않는 목적지 0개, 비활성 필수 행동 0개
- 참가자 화면에서 미래 과업·성공 기준 노출 0개
- IMDF Warning과 Violation의 문구·행동 차이 일치
- 세 팀 재검사에서 S0 0건, S1 0건

## 7. 범위 제한

이번 Agent Pilot은 Lo-Fi의 논리와 테스트 가능성을 검증한다. 실제 Apple IMDF Validator 통과, ZIP 직렬화, Pencil 정밀도, MapKit·iCloud 동작은 구현 Prototype에서 별도로 검증해야 한다.
