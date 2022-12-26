package dex;

import dex.systems.Time;
import defold.types.Hash;
import dex.util.types.SpriteSet;
import dex.platformer.hashes.PlatformerAnimations;
import dex.util.DexSignal.DexTypedSignal;


@:enum
abstract SetStateOption(Int)
{
    var None  = 0;

    /**
     * Prevents another animation from playing before this one finishes.
     * Will lock indefinitely for `LOOP` animations.
     */
    var Lock  = 1 << 0;

    /** *      * Set the new animation state immediately, even if the current state is locked.
     */
    var Force = 1 << 1;

    /**
     * If the animation currently playing is locked, set the animation to play after the locked one finishes.
     * Otherwise, the animation is discarded.
     */
    var Queue = 1 << 2;

    /**
     * If set together with `Force`, this option will `Queue` the currently playing animation, to be played after
     * the one it is being overriden by.
     */
    var Restore = 1 << 3;


    @:op(A & B)
    public static inline function bitwiseAnd(a: SetStateOption, b: SetStateOption): Bool
    {
        return cast(a, Int) & cast(b, Int) > 0;
    }


    @:op(A | B)
    public static inline function bitwiseOr(a: SetStateOption, b: SetStateOption): SetStateOption
    {
        return cast(cast(a, Int) | cast(b, Int), SetStateOption);
    }


    @:to
    public inline function toBool(): Bool
    {
        return this > 0;
    }
}


class AnimationState
{
    public var state(default, null): Hash;
    public var sprite(default, null): SpriteSet;
    public var timeInState(get, never): Float;

    public var onStateChange(default, null): DexTypedSignal<(from: Hash, to: Hash) -> Void>;

    var animationLocked: Bool;
    var stateSetTimestamp: Float;
    var nextState: Hash;
    var nextStateOptions: SetStateOption;


    public inline function new(sprite: SpriteSet, initialState: Hash = null)
    {
        this.sprite = sprite;

        onStateChange = new DexTypedSignal();

        reset();

        set(initialState);
    }


    /**
        Update the current animation.

        Does nothing if `state` is null.

        @param state The animation hash to update to.
        @param options Options specifying the behavior for overriding animations.
    **/
    public function set(state: Hash, options: SetStateOption = None)
    {
        if (state == null)
        {
            return;
        }

        var currentState: Hash = this.state;

        if ((options & Force) || (!animationLocked && state != currentState))
        {
            // Override current state and animation.
            sprite.playAnimation(state);

            if ((options & Force) && (options & Restore))
            {
                // Queue the animation that was overriden.
                nextState = currentState;
                nextStateOptions = animationLocked ? Lock : None;
            }

            this.state = state;
            animationLocked = (options & Lock);
            stateSetTimestamp = Time.timestamp;

            onStateChange.dispatch(currentState, state);
        }
        else if (options & Queue)
        {
            // Set the state to play next, after the current animation is done.
            nextState = state;
            nextStateOptions = options;
        }
    }


    public inline function animationDone(animation: Hash)
    {
        animationLocked = false;

        if (nextState != null)
        {
            set(nextState, nextStateOptions);

            nextState = null;
            nextStateOptions = None;
        }
    }


    public inline function reset()
    {
        state = PlatformerAnimations.idle;
        animationLocked = false;
        nextState = null;
        nextStateOptions = None;
        stateSetTimestamp = Time.timestamp;
    }


    public inline function is(state: Hash): Bool
    {
        return this.state == state;
    }


    public inline function isOneOf(states: Array<Hash>): Bool
    {
        return states.indexOf(state) > -1;
    }


    public inline function isInStateFor(state: Hash, time: Float): Bool
    {
        return (this.state == state) && (timeInState >= time);
    }


    inline function get_timeInState(): Float
    {
        return Time.timestamp - stateSetTimestamp;
    }
}
