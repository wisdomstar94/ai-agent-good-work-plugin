---
name: code-splitting-skill
description: 코드를 편집할 때 적용하는 파일 · 폴더 분리 기준 스킬입니다.
---

## 용어 정의

### 카테고리 폴더

관심사 하나를 담고 있는 폴더를 `카테고리 폴더` 라고 부릅니다. 아래는 그 예시입니다.

```text
components/ <-- 종류별로 그룹핑한 폴더일 뿐 카테고리 폴더가 아님.
  ㄴ user-form/ <-- 카테고리 폴더임.
    ㄴ index.ts <-- `export * from './user-form'` (import 경로의 .js 확장자 표기 여부는 프로젝트 설정을 따름)
    ㄴ user-form.tsx
hooks/ <-- 종류별로 그룹핑한 폴더일 뿐 카테고리 폴더가 아님.
  ㄴ book-hooks/ <-- 도메인별로 그룹핑한 폴더일 뿐 카테고리 폴더가 아님.
    ㄴ use-book-modify-handler/ <-- 카테고리 폴더임.
      ㄴ index.ts <-- `export * from './use-book-modify-handler'` (import 경로의 .js 확장자 표기 여부는 프로젝트 설정을 따름)
      ㄴ use-book-modify-handler.tsx
```

카테고리 폴더 안에 `_` 로 시작하는 그룹핑 폴더를 두고, 그 밑에 서브 카테고리 폴더를 둘 수 있습니다. 서브 카테고리 폴더도 카테고리 폴더의 한 종류이므로 카테고리 폴더 규칙이 똑같이 적용됩니다. 예시는 `파일 분리 규칙` 항목에 있습니다.

## 한 파일이 200줄을 넘지 않게 하세요

한 파일이 200줄을 넘으면 이 스킬의 `파일 분리 규칙` 에 맞춰 파일을 분리해야 합니다.

## 파일 분리 규칙

관심사별로 서브 카테고리 폴더를 만들어 코드를 분리합니다. 아래는 그 예시입니다.

```text
components/
  ㄴ user-form/
    ㄴ _components/ <-- 서브 카테고리 폴더들을 종류별로 그룹핑한 폴더.
      ㄴ user-basic-info-form/ <-- 서브 카테고리 폴더임.
        ㄴ index.ts
        ㄴ user-basic-info-form.tsx
      ㄴ user-detail-info-form/ <-- 서브 카테고리 폴더임.
        ㄴ index.ts
        ㄴ user-detail-info-form.tsx
    ㄴ index.ts
    ㄴ user-form.tsx
```

- 서브 카테고리 폴더는 이름 앞에 `_`(언더스코어)가 붙는 그룹핑 폴더 밑에 두고, 상위 카테고리 폴더에서만 쓰는 것들을 담습니다. 위 예시에서 `user-basic-info-form/` 과 `user-detail-info-form/` 두 서브 카테고리 폴더는 `user-form.tsx` 에서만 쓰입니다.
- 서브 카테고리 폴더 밑의 파일도 200줄을 넘으면 같은 방식으로 다시 서브 카테고리로 분리합니다.

## 코드는 사용처 가까이에 두세요

200줄 분리와 상관없이, 새로 만드는 코드는 모두 아래 기준으로 위치를 정합니다.

- **사용처** 는 그 코드를 가져다 쓰는 카테고리 폴더 또는 **라우트 폴더**(Next.js app router 의 `page.tsx` · `layout.tsx` 가 있는 폴더 등)입니다.
  - 한 카테고리 폴더 · 라우트 폴더 안의 서브 카테고리 폴더에서 쓰는 것은 같은 사용처로 봅니다.
  - 하위 라우트 폴더(예: `new/` · `[groupId]/`)는 상위 라우트 폴더와 별개의 사용처입니다.
- **사용처가 한 곳인 코드** 는 그 사용처의 `_components/` · `_utils/` · `_hooks/` 등 그룹핑 폴더 밑에 카테고리 폴더로 둡니다.
- **사용처가 두 곳 이상인 코드** 는 `src/components/` · `src/utils/` · `src/hooks/` 같은 공용 폴더에 둡니다.
- 사용처가 늘거나 줄어 기준이 바뀌면, 그 작업에서 코드를 맞는 경로로 옮깁니다.

```text
src/app/(auth-required)/access-policy-groups/
  ㄴ _components/
    ㄴ access-policy-groups-screen/ <-- 이 폴더의 page.tsx 에서만 쓰므로 여기에 둠.
      ㄴ index.ts
      ㄴ access-policy-groups-screen.tsx
  ㄴ [groupId]/
    ㄴ page.tsx
  ㄴ new/
    ㄴ page.tsx
  ㄴ page.tsx
src/components/
  ㄴ access-policy-group-editor/ <-- new/page.tsx 와 [groupId]/page.tsx 두 곳에서 쓰므로 공용 폴더에 둠.
    ㄴ _utils/
      ㄴ convert-policy-tree/ <-- access-policy-group-editor 와 그 서브 카테고리 폴더에서만 쓰므로 사용처는 한 곳임.
    ㄴ index.ts
    ㄴ access-policy-group-editor.tsx
```

## 한 파일에는 그 파일의 주인공 선언 하나만 두세요

파일 이름과 같은 선언(컴포넌트 · 함수 · 훅 · 클래스 등) 하나만 그 파일에 둡니다. 함께 쓰는 다른 모듈 최상위 선언은 종류별 그룹핑 폴더 밑의 카테고리 폴더로 분리합니다. 분리한 선언도 `코드는 사용처 가까이에 두세요` 기준으로 위치를 정합니다.

| 선언 종류 | 그룹핑 폴더 (사용처가 한 곳) | 공용 폴더 (사용처가 두 곳 이상) |
| --- | --- | --- |
| 컴포넌트 | `_components/` | `src/components/` |
| 훅 | `_hooks/` | `src/hooks/` |
| 함수 | `_utils/` | `src/utils/` |
| 클래스 | `_classes/` | `src/classes/` |
| 상수 | `_consts/` | `src/consts/` |
| 타입 · 인터페이스 | `_types/` | `src/types/` |

- 위 표는 예시입니다. 프로젝트에 다른 종류(예: `_services/` · `_validators/`)가 있으면 그 이름을 따르고, 없는 종류는 같은 규칙으로 `_<종류>/` 를 만듭니다.
- 함수의 옵션 · props 처럼 그 파일의 주인공과 짝을 이루는 타입도 `_types/` 로 분리합니다.

```text
share-link-form-modal/
  ㄴ _consts/
    ㄴ toggles/ <-- share-link-form-modal.tsx 에서만 쓰는 상수
      ㄴ index.ts
      ㄴ toggles.ts
  ㄴ _types/
    ㄴ share-link-form-values/ <-- share-link-form-modal.tsx 에서만 쓰는 타입
      ㄴ index.ts
      ㄴ share-link-form-values.ts
  ㄴ _utils/
    ㄴ to-kst-date-boundary/ <-- share-link-form-modal.tsx 에서만 쓰는 함수
      ㄴ index.ts
      ㄴ to-kst-date-boundary.ts
  ㄴ index.ts
  ㄴ share-link-form-modal.tsx <-- ShareLinkFormModal 컴포넌트만 둔다.
```

- 같은 관심사의 선언 여러 개(예: 버튼 variant · size 클래스 이름 상수)는 한 카테고리 폴더에 함께 둘 수 있습니다.
- 라이브러리 패키지처럼 `_` 로 시작하는 폴더를 외부에 공개하지 않는 구조라면, 다른 패키지가 쓰는 선언은 `_<종류>/` 가 아니라 공개되는 `<종류>/` 폴더(예: `consts/` · `types/`)에 둡니다.
- 아래는 분리 대상이 아닙니다.
  - Next.js 의 `metadata` · `config` 처럼 프레임워크가 그 파일에서 export 하도록 요구하는 값
  - router · DB 연결 · React context 처럼 그 파일의 주인공을 만들기 위해 모듈에 하나만 있어야 하는 런타임 객체
  - 마이그레이션처럼 작성 시점의 스냅샷이어야 하는 파일 안의 선언

## 상수 · 타입에서 뽑은 별칭을 만들지 마세요

다른 상수나 타입에서 뽑은 타입 · 값에 이름만 붙여 다시 선언하지 마세요. 사용처에서 직접 씁니다.

```ts
// ❌ 금지
export type PermissionCode = keyof typeof PERMISSION_CODE_REGISTRY;
export const PERMISSION_CODES = Object.keys(PERMISSION_CODE_REGISTRY) as PermissionCode[];
type ToggleKey = (typeof TOGGLES)[number]["key"];
type IpBlock = Extract<EditorBlock, { kind: "IP" }>;
type ParsedQuery = z.infer<typeof querySchema>;

// ✅ 사용처에서 직접 쓴다.
function requirePermission(code: keyof typeof PERMISSION_CODE_REGISTRY) { ... }
const codes = Object.keys(PERMISSION_CODE_REGISTRY) as (keyof typeof PERMISSION_CODE_REGISTRY)[];
function IpRuleBlock(props: { block: Extract<EditorBlock, { kind: "IP" }> }) { ... }
```

- `keyof typeof X`, `(typeof X)[...]`, `Extract` · `Exclude` · `Pick` · `Omit` · `z.infer` 등으로 상수 · 타입 하나를 가공한 결과에 이름을 붙이는 것이 모두 해당합니다.
- `ResBody<S>` 처럼 타입 인자를 받는 범용 유틸 타입, `Omit<A, "x"> & { ... }` 처럼 다른 타입과 합쳐 새 구조를 만드는 타입은 별칭이 아니므로 허용합니다.

## 파일을 만들거나 수정할 때 위치를 확인하세요

- 새 파일을 만들기 전에 사용처를 먼저 정하고, `코드는 사용처 가까이에 두세요` 기준에 맞는 경로에 만듭니다.
- 기존 파일을 수정할 때도 그 파일의 사용처와 위치가 기준에 맞는지 확인합니다.
- 기존 코드베이스의 관례가 이 기준과 어긋나더라도, 그 관례를 따라 새 코드를 만들지 마세요.
- 어긋난 기존 코드를 발견하면 작업 범위를 임의로 넓혀 옮기지 말고, 작업계획서의 `결정 필요` 나 완료 보고에 적어 사용자에게 알립니다.

## 배럴 익스포트는 카테고리 폴더 바로 밑의 index.ts 에서만 허용합니다

아래 예시처럼 그룹핑 폴더나 상위 폴더에서 여러 카테고리 폴더를 모아 배럴 익스포트로 내보내면 안 됩니다.

```text
src/functions/
  ㄴ my-function-1/
    ㄴ _utils/
      ㄴ my-util-1/
        ㄴ index.ts <-- ✅ 카테고리 폴더 자신의 index.ts
        ㄴ my-util-1.ts
      ㄴ my-util-2/
        ㄴ index.ts <-- ✅ 카테고리 폴더 자신의 index.ts
        ㄴ my-util-2.ts
      ㄴ index.ts <-- ❌ 여러 카테고리 폴더를 모아 내보내는 것 금지
    ㄴ index.ts <-- ✅ 카테고리 폴더 자신의 index.ts
    ㄴ my-function-1.ts
  ㄴ my-function-2/...
  ㄴ index.ts <-- ❌ 여러 카테고리 폴더를 모아 내보내는 것 금지
```
