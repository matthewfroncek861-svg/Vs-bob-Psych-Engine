package states.stages;

import states.stages.objects.*;

class Slaught extends BaseStage
{
	var bobmadshake:FlxSprite;
	var bobsound:FlxSound;
	
	override function create()
	{
				defaultCamZoom = 0.9;
				var bg:FlxSprite = new FlxSprite(-100).loadGraphic(Paths.image('bob/scary_sky'));
				bg.updateHitbox();
				bg.active = false;
				bg.antialiasing = true;
				bg.scrollFactor.set(0.1, 0.1);
				add(bg);
				/*var glitchEffect = new FlxGlitchEffect(8,10,0.4,FlxGlitchDirection.HORIZONTAL);
				var glitchSprite = new FlxEffectSprite(bg, [glitchEffect]);
				add(glitchSprite);*/
				
				var ground:FlxSprite = new FlxSprite(-537, -158).loadGraphic(Paths.image('bob/GlitchedGround'));
				ground.updateHitbox();
				ground.active = false;
				ground.antialiasing = true;
				add(ground);

			}
	}

	
	var isbobmad:Bool = true;
	var appearscreen:Bool = true;
	function shakescreen()
	{
		new FlxTimer().start(0.01, function(tmr:FlxTimer)
		{
			Lib.application.window.move(Lib.application.window.x + FlxG.random.int( -10, 10),Lib.application.window.y + FlxG.random.int( -8, 8));
		}, 50);
	}
	function HealthDrain():Void
	{
		FlxG.sound.play(Paths.sound("BoomCloud"), 1);
		boyfriend.playAnim("hit", true);
		FlxG.camera.zoom -= 0.02;
		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			boyfriend.playAnim("idle", true);
		});
		new FlxTimer().start(0.01, function(tmr:FlxTimer)
		{
			health -= 0.005;
		}, 300);
	}
	function resetBobismad():Void
	{
		camHUD.visible = true;
		bobsound.pause();
		bobmadshake.visible = false;
		bobsound.volume = 0;
		isbobmad = true;
	}
	function InvisibleNotes()
	{
		FlxG.sound.play(Paths.sound('Meow'));
		for (note in playerStrums)
			{
				note.visible = false;
			}
		for (note in strumLineNotes)
			{
				note.visible = false;
			}
	}
	function VisibleNotes()
	{
		FlxG.sound.play(Paths.sound('woeM'));
		for (note in playerStrums)
			{
				note.visible = true;
			}
		for (note in strumLineNotes)
			{
				note.visible = true;
			}
	}

	function Bobismad()
	{
		camHUD.visible = false;
		bobmadshake.visible = true;
		bobsound.play();
		bobsound.volume = 1;
		isbobmad = false;
		shakescreen();
		new FlxTimer().start(0.5 , function(tmr:FlxTimer)
		{
			resetBobismad();
		});
	}

	override function stepHit()
	{
		// Code here
	}

	override function beatHit()
	{
		super.beatHit();

		if (generatedMusic)
		{
			notes.sort(FlxSort.byY, FlxSort.DESCENDING);
		}
		if (SONG.notes[Math.floor(curStep / 16)] != null)
		{
			if (SONG.notes[Math.floor(curStep / 16)].changeBPM)
			{
				Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
				FlxG.log.add('CHANGED BPM!');
			}
			// else
			// Conductor.changeBPM(SONG.bpm);

			// Dad doesnt interupt his own notes
			if (SONG.notes[Math.floor(curStep / 16)].mustHitSection)
				dad.dance();
		}
		// FlxG.log.add('change bpm' + SONG.notes[Std.int(curStep / 16)].changeBPM);
		wiggleShit.update(Conductor.crochet);

		// HARDCODING FOR MILF ZOOMS!
		if (curSong.toLowerCase() == 'milf' && curBeat >= 168 && curBeat < 200 && camZooming && FlxG.camera.zoom < 1.35)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}
		
		if (curSong.toLowerCase() == 'onslaught' && curBeat >= 0 && curBeat < 64 && camZooming && FlxG.camera.zoom < 1.35)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}
		else if (curSong.toLowerCase() == 'onslaught' && curBeat >= 96 && curBeat < 224 && camZooming && FlxG.camera.zoom < 1.35)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}
		else if (curSong.toLowerCase() == 'onslaught' && curBeat >= 240 && curBeat < 352 && camZooming && FlxG.camera.zoom < 1.35)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}
		
		if (camZooming && FlxG.camera.zoom < 1.35 && curBeat % 4 == 0)
		{
			FlxG.camera.zoom += 0.015;
			camHUD.zoom += 0.03;
		}

		iconP1.setGraphicSize(Std.int(iconP1.width + 30));
		iconP2.setGraphicSize(Std.int(iconP2.width + 30));

		iconP1.updateHitbox();
		iconP2.updateHitbox();
		if (curBeat == 2 && curSong == 'Ron')
		{
			var bruh:FlxSprite = new FlxSprite();
			bruh.loadGraphic(Paths.image('bob/longbob'));
			bruh.antialiasing = true;
			bruh.active = false;
			bruh.scrollFactor.set();
			bruh.screenCenter();
			add(bruh);
			FlxTween.tween(bruh, {alpha: 0},1, {
				ease: FlxEase.cubeInOut,
				onComplete: function(twn:FlxTween)
				{
					bruh.destroy();
				}
			});
		}
		if (curSong == 'Ron')
		{
			if (curBeat == 7)
			{
				FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut,});
				dad.playAnim('cheer', true);
			}
			else if (curBeat == 119)
			{
				FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut,});
				dad.playAnim('cheer', true);
			}
			else if (curBeat == 215)
			{
				FlxG.camera.follow(dad, LOCKON, 0.04 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
				FlxTween.tween(FlxG.camera, {zoom: 1.5}, 0.4, {ease: FlxEase.expoOut,});
				dad.playAnim('cheer', true);
			}
			else
			{
				FlxG.camera.follow(camFollow, LOCKON, 0.04 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
			}
		}
		if (curBeat % gfSpeed == 0 && curSong == 'run' && !FlxG.save.data.shakingscreen)
		{
			camHUD.shake(0.02, 0.2);
			FlxG.camera.shake(0.005, 0.2);
			//FlxTween.tween(camHUD, {angle: 0},0.5, {ease: FlxEase.elasticOut});
		}
		if (curBeat % gfSpeed == 0)
		{
			gf.dance();
		}

		if (!boyfriend.animation.curAnim.name.startsWith("sing"))
		{
			boyfriend.playAnim('idle');
		}

		if (curBeat % 8 == 7 && curSong == 'Bopeebo')
		{
			boyfriend.playAnim('hey', true);
		}

		if (curBeat % 16 == 15 && SONG.song == 'Tutorial' && dad.curCharacter == 'gf' && curBeat > 16 && curBeat < 48)
			{
				boyfriend.playAnim('hey', true);
				dad.playAnim('cheer', true);
			}
		if (curSong.toLowerCase() == 'onslaught' && curBeat >= 128 && curBeat <= 352 )
		{
			var amount = curBeat/20;
			if (FlxG.random.bool(amount) && appearscreen)
			{
				var randomthing:FlxSprite = new FlxSprite(FlxG.random.int(300, 1077), FlxG.random.int(0, 622));
				FlxG.sound.play(Paths.sound("pop_up"), 1);
				randomthing.loadGraphic(Paths.image('bob/PopUps/popup' + FlxG.random.int(1,11), 'shared'));
				randomthing.updateHitbox();
				randomthing.alpha = 0;
				randomthing.antialiasing = true;
				add(randomthing);
				randomthing.cameras = [camHUD];
				appearscreen = false;
				if (storyDifficulty == 0)
				{
					FlxTween.tween(randomthing, {width: 1, alpha: 0.5}, 0.2, {ease: FlxEase.sineOut});
				}
				else
				{
					FlxTween.tween(randomthing, {width: 1, alpha: 1}, 0.2, {ease: FlxEase.sineOut});
				}
				new FlxTimer().start(1.5 , function(tmr:FlxTimer)
				{
					appearscreen = true;
				});
				new FlxTimer().start(2 , function(tmr:FlxTimer)
				{
					remove(randomthing);
				});
			}
		}
		if (curSong.toLowerCase() == 'little-man' && curBeat == 1397 )
		{
			changeDadCharacter('pizza');
		}
		if (curSong.toLowerCase() == 'little-man' && curBeat == 1497 )
		{
			changeDadCharacter('little-man');
		}
		if (curSong.toLowerCase() == 'little-man' && curBeat == 1844 )
		{
			changeDadCharacter('tankman');
			dad.x -= 124;
			dad.y -= 644;
			dad.y += 268;
			dad.x -= 27;
		}
		if (curSong.toLowerCase() == 'little-man' && curBeat == 1900 )
		{
			spotifyad();
		}
		if (curSong.toLowerCase() == 'trouble' && curBeat == 504 )
		{
			BobIngameTransform();
		}
		if (curSong.toLowerCase() == 'onslaught' && curBeat == 96 )
		{
			InvisibleNotes();
		}
		if (curSong.toLowerCase() == 'onslaught' && curBeat == 128 )
		{
			windowX = Lib.application.window.x;
			windowY = Lib.application.window.y;
			IsNoteSpinning = true;
			VisibleNotes();
		}
		if (curSong.toLowerCase() == 'onslaught' && curBeat == 240 )
		{
			InvisibleNotes();
		}
		if (curSong.toLowerCase() == 'onslaught' && curBeat == 352 )
		{
			IsNoteSpinning = false;
			if (!FlxG.save.data.shakingscreen)
				WindowGoBack();
			VisibleNotes();
		}
		switch (curStage)
		{
			case 'school':
				bgGirls.dance();
			
			case 'hellstage':
				
				if (FlxG.random.bool(10) && isbobmad && curSong.toLowerCase() == 'run' && !FlxG.save.data.jumpscare)
					Bobismad();
				
			case 'mall':
				upperBoppers.animation.play('bop', true);
				bottomBoppers.animation.play('bop', true);
				santa.animation.play('idle', true);

			case 'limo':
				grpLimoDancers.forEach(function(dancer:BackgroundDancer)
				{
					dancer.dance();
				});

				if (FlxG.random.bool(10) && fastCarCanDrive)
					fastCarDrive();
			case "philly":
				if (!trainMoving)
					trainCooldown += 1;

				if (curBeat % 4 == 0)
				{
					phillyCityLights.forEach(function(light:FlxSprite)
					{
						light.visible = false;
					});

					curLight = FlxG.random.int(0, phillyCityLights.length - 1);

					phillyCityLights.members[curLight].visible = true;
					// phillyCityLights.members[curLight].alpha = 1;
				}

				if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
				{
					trainCooldown = FlxG.random.int(-4, 0);
					trainStart();
				}
		}

		if (isHalloween && FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
		{
			lightningStrikeShit();
		}
	}
	function BobIngameTransform()
	{
		//screw you aether i want to fix the ingame cutscene
		dad.playAnim('Transform', true);
		FlxG.sound.play(Paths.sound('bobSpooky'));
		var black:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		black.scrollFactor.set();
		new FlxTimer().start(1.7, function(tmr:FlxTimer)
		{
			add(black);
			FlxG.camera.fade(FlxColor.WHITE, 0.1, true);
		});

	}

	function spotifyad()
		{
			var thx:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('littleman/spotifyad'));
			thx.updateHitbox();
			thx.scrollFactor.set(0, 0);
			thx.antialiasing = true;
			FlxG.camera.fade(FlxColor.BLACK, 1, false, function()
			{
				add(thx);
				FlxG.camera.fade(FlxColor.BLACK, 1, true);
			}, true);
		}
	function WindowGoBack()
		{
			new FlxTimer().start(0.01, function(tmr:FlxTimer)
			{
				var xLerp:Float = FlxMath.lerp(windowX, Lib.application.window.x, 0.95);
				var yLerp:Float = FlxMath.lerp(windowY, Lib.application.window.y, 0.95);
				Lib.application.window.move(Std.int(xLerp),Std.int(yLerp));
			}, 20);
		}
	function changeDadCharacter(id:String)
		{				
			var olddadx = dad.x;
			var olddady = dad.y;
			remove(dad);
			dad = new Character(olddadx, olddady, id);
			add(dad);
			iconP2.animation.play(id);
		}
	override function sectionHit()
	{
		// Code here
	}

	function initDoof()
	{
		var file:String = Paths.txt('run/DumbDialogPhloxMade'); //Checks for vanilla/Senpai dialogue
		#if MODS_ALLOWED
		if (!FileSystem.exists(file))
		#else
		if (!OpenFlAssets.exists(file))
		#end
		{
			file = Paths.txt('run/DumbDialogPhloxMade');
		}

		#if MODS_ALLOWED
		if (!FileSystem.exists(file))
		#else
		if (!OpenFlAssets.exists(file))
		#end
		{
			startCountdown();
			return;
		}

		doof = new DialogueBox(false, CoolUtil.coolTextFile(file));
		doof.cameras = [camHUD];
		doof.scrollFactor.set();
		doof.finishThing = startCountdown;
		doof.nextDialogueThing = PlayState.instance.startNextDialogue;
		doof.skipDialogueThing = PlayState.instance.skipDialogue;
	}
}
