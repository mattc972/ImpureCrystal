BattleCommand_DragonDance:

	ld bc, wPlayerStatLevels
	ldh a, [hBattleTurn]

	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr c, .raise

	inc bc
	inc bc
	ld a, [bc]
	cp MAX_STAT_LEVEL
	jr nc, .cantraise
.raise
	ld a, $1
	ld [wKickCounter], a
	call AnimateCurrentMove
	; call BattleCommand_SwitchTurn
	call BattleCommand_AttackUp
	call BattleCommand_StatUpMessage
	call ResetMiss
	; call BattleCommand_SwitchTurn
	call BattleCommand_SpeedUp
	jp   BattleCommand_StatUpMessage

.cantraise
	ld b, ABILITY + 1
	call GetStatName
	call AnimateFailedMove
	ld hl, WontRiseAnymoreText
	jp StdBattleTextbox
