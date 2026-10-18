# good-work

## 목차

- [포함된 스킬](#포함된-스킬)
- [Claude Code 에서 설치](#claude-code-에서-설치)
- [Codex 에서 설치](#codex-에서-설치)
- [저장소 구조](#저장소-구조)

에이전트가 일을 잘하도록 돕는 작업 규칙 스킬 모음입니다. **Claude Code** 와 **Codex** 양쪽에서 플러그인으로 설치해 쓸 수 있습니다.

- **플러그인 이름** : `good-work`
- **마켓플레이스 이름** : `ai-agent-good-work`

## 포함된 스킬

| 스킬 | 언제 적용되나 |
| --- | --- |
| `work-skill` | 어떤 작업이든 시작하기 전. 작업계획서 작성 → 컨펌 → 작업 → 완료 보고 |
| `question-skill` | 사용자에게 질문하거나 승인·컨펌을 받을 때. 질문 프롬프트와 추천 선택지 사용 |
| `code-spliting-skill` | 코드를 편집할 때. 카테고리 폴더 · 200줄 기준 분리 · 배럴 익스포트 제한 |
| `code-comment-skill` | 주석을 추가·수정할 때. 주석 지양 · 로컬 PC 종속 내용 금지 |
| `html-writing-skill` | 단일 HTML 파일로 산출물을 낼 때. 규격 · 다이어그램 규칙 |

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
skills/                 # 두 에이전트가 공유하는 스킬 (SKILL.md)
```

- 스킬을 추가하면 `skills/<스킬명>/SKILL.md` 에 `name` · `description` 프론트매터를 넣으면 됩니다. 매니페스트는 고치지 않아도 됩니다.
- 버전을 올릴 때는 `.claude-plugin/plugin.json` · `.claude-plugin/marketplace.json` · `.codex-plugin/plugin.json` 세 곳의 `version` 을 함께 바꿉니다.
