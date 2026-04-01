# Project Context

## Purpose
Vats of Eden is a 2D game built with the LÖVE framework (Love2D) in Lua. It is in early development.

## Tech Stack
- Lua (LuaJIT)
- LÖVE 2D framework (love2d.org)
- Target resolution: 1280x720

## Project Conventions

### Code Style
- Lua modules returned as tables (e.g., `local m = {} ... return m`)
- LuaDoc-style annotations (`---@param`, `---@return`) for typed parameters
- Snake_case for variables and functions

### Architecture Patterns
- LÖVE callback pattern: `love.load`, `love.update(dt)`, `love.draw`, `love.keypressed`
- Modules live in `src/`, loaded from `main.lua`

### Testing Strategy
- No automated testing framework in place yet

### Git Workflow
- Feature branches off `develop`; `master` is the main branch

## Domain Context
2D idle/colony management game. Players manage a colony whose production and entropy are governed by a global tick system. Core mechanics include resource production, decay/entropy, and game objects assigned to slots. No assets loaded yet — visual style (pixel art, vector, etc.) is TBD and will inform the asset pipeline.

## Important Constraints
- Must run under LÖVE 2D framework APIs only (no external Lua dependencies)

## External Dependencies
- None
