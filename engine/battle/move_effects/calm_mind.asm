BattleCommand_CalmMind:

	ld bc, wPlayerStatLevels
	ldh a, [hBattleTurn]

	inc bc
	inc bc
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise

	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr nc, .cantraise
.raise
	ld a, $1
	ld [wKickCounter], a
	call AnimateCurrentMove
	; call BattleCommand_SwitchTurn
	call BattleCommand_SpecialAttackUp
	call BattleCommand_StatUpMessage
	call ResetMiss
	; call BattleCommand_SwitchTurn
	call BattleCommand_SpecialDefenseUp
	jp   BattleCommand_StatUpMessage

.cantraise
	ld b, ABILITY + 1
	call GetStatName
	call AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jp StdBattleTextbox
