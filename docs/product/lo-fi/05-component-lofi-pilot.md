# Component-Identifiable Lo-Fi Pilot

상태: 기준 화면 2개 검증 후 핵심 8개 화면 전체 확장 완료

작성일: 2026-08-20

Figma: [핵심 화면 Lo-Fi Prototype](https://www.figma.com/design/kqT9zmJTq9nOoV43y6hYqS?node-id=13-2)

## 문제 정의

첫 번째 화면형 Lo-Fi는 텍스트와 기호로 UI 구조를 설명했다. 버튼, 목록, 입력, 지도, Geometry 편집 도구가 실제 화면 요소로 표현되지 않아 사용자가 클릭 가능 영역과 정보 영역을 구분하기 어려웠다. 따라서 화면 구조는 확인할 수 있었지만 실제 조작 방식을 검증하기에는 Fidelity가 부족했다.

## 새 품질 기준

화면을 짧게 보았을 때 설명을 읽지 않아도 다음 요소를 구분할 수 있어야 한다.

- Toolbar와 Navigation Context
- Button과 선택 상태
- List Row와 Visibility Control
- Map Canvas와 Floor-plan Overlay
- IMDF Geometry와 선택 상태
- Drawing Tool과 Vertex Handle
- Inspector Card와 Checklist
- Primary Action

제품 디자인 시스템과 시각 스타일은 아직 확정하지 않는다. 회색조, 1px 경계, 4의 배수 간격을 사용하되 컨트롤의 형태와 상호작용 가능성은 명확히 표현한다.

## 기준 화면

### `EDIT-02` 지도 편집기

- 프로젝트·건물·층·작성 단계가 포함된 Toolbar
- 실제 경계를 가진 층 선택, 검사, 내보내기 Button
- 선택 상태와 개수가 보이는 Feature List Row
- Feature 추가와 Layer Tool Button
- 도로, 블록, 공원으로 구성된 Map Canvas
- Building Footprint와 정렬된 Floor-plan Overlay
- Unit, Hall, Opening Geometry와 선택 상태
- 현재 단계 Progress Card와 선택 Feature Card
- `Feature 추가` Primary Action

### `AUTHOR-02` Polygon 그리기

- 취소와 Draft 저장 Button
- 점 추가, 실행 취소, 다시 실행 Tool Button
- Geometry 상태 Card
- 지도와 정렬된 평면도 위의 닫힌 Polygon
- 5개의 Vertex Handle과 다음 점 Cursor
- 완료 조건 Checklist Row
- 짧은 설명과 흔한 실수 Help Card
- 다시 그리기와 `Polygon 완료` Action

#### Unit Geometry 표현 수정

- Polygon은 Unit 안에 배치되는 별도 도형이 아니라 `Unit 12` 자체의 Geometry로 표현한다.
- 도면의 `Unit 12` 경계는 벽 위치를 맞추기 위한 Boundary Guide로 사용한다.
- Polygon과 네 Vertex를 Boundary Guide의 네 모서리에 정확히 정렬한다.
- 완료된 Polygon에서는 다음 점 Cursor를 제거한다.
- Level 밖으로 벗어나거나 다른 Unit과 겹치는 상태는 완료 차단 조건으로 안내한다.
- 좌표 검증 결과 Boundary와 Polygon은 Canvas 기준 `x: 180`, `y: 372`, `width: 132`, `height: 82`로 일치한다.

#### Opening Geometry 표현 수정

- 벽을 가로지르는 검은 가로 막대 표현을 제거했다.
- `Opening 07`은 Unit 12 오른쪽 공유 경계 위의 세로 `LineString`으로 표현한다.
- 선분 양 끝에 Endpoint Handle을 표시하고 작은 Feature Label을 추가한다.
- `EDIT-02`와 `AUTHOR-02`에서 동일한 위치와 방향을 사용한다.
- 좌표 검증 결과 Opening은 Canvas 기준 `x: 310`, `y: 399`, `width: 4`, `height: 28`이며 중심선 `x: 312`가 Unit 12 오른쪽 경계와 일치한다.
- Opening 전체 길이가 Unit 12 경계의 세로 범위 안에 포함된다.

## 검증 결과

| 항목 | `EDIT-02` | `AUTHOR-02` |
| --- | ---: | ---: |
| 화면 크기 | 1194 × 834 | 1194 × 834 |
| Toolbar | 3개 영역 | 1개 영역 |
| List 또는 Checklist Row | 3 | 2 |
| 명시적 Control | 12 | 8 |
| Map Element | 7 | 7 |
| Geometry 또는 Vertex | 5 | 11 |
| Card | 2 | 3 |
| Primary Action + Prototype 연결 | 1 + 1 | 1 + 1 |

- ASCII Wireframe 문자가 남아 있지 않다.
- 한글 텍스트는 `Noto Sans KR`로 통일했다.
- 텍스트가 화면 밖으로 넘치는 문제는 발견되지 않았다.
- Map Road는 자연스러운 지도 연속성을 위해 Canvas 바깥까지 연장하고 Canvas에서 의도적으로 잘랐다.
- 두 화면 모두 기존 대표 Prototype 흐름을 유지한다.

## 전체 8개 화면 확장

파일럿에서 확인한 UI 문법을 나머지 6개 화면에도 적용했다.

| Screen ID | 식별 가능한 주요 구성요소 |
| --- | --- |
| `HOME-01` | 프로젝트 탐색 Navigation, 검색 Input, 프로젝트 Card, 상태 Badge, 프로젝트 열기 Button |
| `EDIT-01` | 단계 List, 문제·단계·공간 Status Card, 층별 List Row, Progress Bar, 편집 계속 Button |
| `EDIT-02` | Feature List, Layer Control, Map Canvas, Floor-plan Overlay, Geometry, Inspector Card |
| `AUTHOR-01` | Feature 계층 List, 검색 Input, 최근 사용 Chip, 추천 Feature Card, 선택 Button |
| `AUTHOR-02` | Drawing Toolbar, Polygon, Vertex Handle, Checklist, Help Card, 완료 Button |
| `AUTHOR-08` | 선택 Feature Preview, 관계 List, Select·Text·Map-point Control, Help Card, 저장 Button |
| `REVIEW-03` | Issue List, Severity Badge, 문제 위치 Map, 영향 Feature Card, 수정 Button |
| `EXPORT-02` | Export Step List, 검사 Summary Card, Blocking Issue Row, 허용·비활성 ZIP Control |

모든 화면은 하나의 Primary Action과 하나의 Prototype 연결을 유지한다. 대표 흐름은 `HOME-01 → EDIT-01 → EDIT-02 → AUTHOR-01 → AUTHOR-02 → AUTHOR-08 → EXPORT-02 → REVIEW-03 → AUTHOR-08`이다.

## 전체 검증 결과

- 8개 화면 모두 `1194 × 834`이다.
- 총 8개의 Primary Action에 각각 Prototype 연결이 1개 있다.
- 한글 텍스트는 모두 `Noto Sans KR`를 사용한다.
- 설명용 ASCII Wireframe과 리터럴 줄바꿈 문자가 남아 있지 않다.
- Button, Input, List Row, Card, Badge, Map, Geometry, Inspector가 화면 경계로 구분된다.
- `REVIEW-03`의 오류 Geometry는 의도적으로 Level 경계를 벗어난 부분을 보여주며, 정상 작성 화면의 Geometry와 혼동되지 않는다.

## 판단

기존 결과보다 화면 요소의 역할과 클릭 가능 영역을 훨씬 빠르게 식별할 수 있다. 파일럿 기준을 나머지 6개 화면에 적용했으며, 핵심 8개 화면을 같은 최소 품질로 통일했다.

다만 아직 최종 시각 디자인, 제품 디자인 토큰, 실제 지도 데이터, 정교한 아이콘, 접근성 세부 상태를 결정한 것은 아니다. 이 작업은 논리와 사용성을 검증하기 위한 Lo-Fi 단계다.

## 다음 작업

1. 핵심 8개 화면으로 짧은 사용성 테스트를 진행한다.
2. 오프라인, 취소, 잘못된 Geometry, 재검사 실패, 제출 차단, ZIP 생성 실패의 예외 흐름을 추가한다.
3. 확인된 UI 문법을 31개 전체 흐름으로 확장한다.
4. Coverage Matrix로 Happy Path와 예외 경로의 누락을 재검사한다.
