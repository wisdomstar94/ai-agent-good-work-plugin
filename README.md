# good-work

에이전트가 일을 잘하도록 돕는 작업 규칙 스킬 모음입니다. **Claude Code** 와 **Codex** 양쪽에서 플러그인으로 설치해 쓸 수 있습니다.

- **플러그인 이름** : `good-work`
- **마켓플레이스 이름** : `ai-agent-good-work`

## 목차

- [포함된 스킬](#포함된-스킬)
- [자동 로드되는 언어 규칙](#자동-로드되는-언어-규칙)
- [Claude Code 에서 설치](#claude-code-에서-설치)
- [Codex 에서 설치](#codex-에서-설치)
- [저장소 구조](#저장소-구조)

## 포함된 스킬

| 스킬 | 언제 적용되나 |
| --- | --- |
| `korean-language-skill` | 항상. 터미널 응답·질문 프롬프트·모든 산출물을 한국어로 작성 (세션 시작 훅으로 자동 주입) |
| `work-skill` | 어떤 작업이든 시작하기 전. 작업계획서 작성 → 컨펌 → 작업 → 완료 보고 |
| `question-skill` | 사용자에게 질문하거나 승인·컨펌을 받을 때. 질문 프롬프트와 추천 선택지 사용 |
| `code-splitting-skill` | 코드를 편집할 때. 카테고리 폴더 · 200줄 기준 분리 · 배럴 익스포트 제한 |
| `code-comment-skill` | 주석을 추가·수정할 때. 주석 지양 · 로컬 PC 종속 내용 금지 |
| `code-review-skill` | 코드 변경사항을 리뷰할 때. 사이드이펙트 · 낡은 주석 점검 → HTML 리뷰 결과서 |
| `explain-diff-skill` | 코드 변경을 설명할 때. 배경 · 직관 · 코드 · 퀴즈로 구성한 HTML 변경점 설명서 |
| `html-writing-skill` | 단일 HTML 파일로 산출물을 낼 때. 규격 · 다이어그램 규칙 |

## 자동 로드되는 언어 규칙

`skills/korean-language-skill/SKILL.md` 의 본문은 세션이 시작될 때 `hooks/session-start.sh` 가 읽어 에이전트 컨텍스트에 자동으로 넣습니다. 문구를 바꿀 때는 **이 `SKILL.md` 한 곳만** 고치면 됩니다.

- **Claude Code** : 플러그인을 설치하면 별도 설정 없이 동작합니다.
- **Codex** : 새 훅은 처음 한 번 사용자 승인이 필요합니다. 승인 전에는 훅이 실행되지 않고, `korean-language-skill` 스킬만 적용됩니다.
  - 대화형으로 `codex` 를 실행해 `/hooks` 에서 `good-work` 의 `SessionStart` 훅을 신뢰(trust) 처리합니다.
  - 스킬 파일을 고치면 훅 해시가 바뀌어 다시 승인이 필요할 수 있습니다.

## Claude Code 에서 설치

```text
/plugin marketplace add <이 저장소의 로컬 경로 또는 GitHub owner/repo>
/plugin install good-work@ai-agent-good-work
```

## Codex 에서 설치

```bash
codex plugin marketplace add <이 저장소의 로컬 경로 또는 GitHub owner/repo>
codex plugin add good-work@ai-agent-good-work
```

## 저장소 구조

```text
.claude-plugin/
  ㄴ plugin.json        # Claude Code 플러그인 매니페스트
  ㄴ marketplace.json   # Claude Code 마켓플레이스
.codex-plugin/
  ㄴ plugin.json        # Codex 플러그인 매니페스트
.agents/plugins/
  ㄴ marketplace.json   # Codex 마켓플레이스
hooks/
  ㄴ hooks.json         # SessionStart 훅 등록 (두 에이전트 공용)
  ㄴ session-start.sh   # 언어 규칙 스킬 본문을 컨텍스트로 주입
skills/                 # 두 에이전트가 공유하는 스킬 (SKILL.md)
```

- 스킬을 추가할 때는 `skills/<스킬명>/SKILL.md` 에 `name` · `description` 프론트매터를 넣으면 됩니다. 매니페스트는 고치지 않아도 됩니다.
- 버전을 올릴 때는 `.claude-plugin/plugin.json` · `.claude-plugin/marketplace.json` · `.codex-plugin/plugin.json` 세 곳의 `version` 을 함께 바꿉니다.
