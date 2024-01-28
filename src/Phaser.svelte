<script>
  import { onDestroy } from "svelte";
  import Phaser from "phaser";

  class Demo extends Phaser.Scene {
    preload() {
      this.load.setBaseURL("http://localhost:1420");
      this.load.image("sky", "assets/title-background-large.png");
      this.load.image("logo", "./assets/cybersquirrel-small.png");
      this.load.image("red", "./assets/mechanical-particles-b.png");
    }

    create() {
      const background = this.add.image(0, 0, "sky");
      background.setPosition(
        this.cameras.main.centerX,
        this.cameras.main.centerY,
      );

      const particles = this.add.particles(0, 0, "red", {
        speed: 100,
        scale: { start: 1, end: 0 },
        blendMode: "ADD",
      });

      const logo = this.physics.add.image(400, 100, "logo");

      logo.setVelocity(100, 200);
      logo.setBounce(1, 1);
      logo.setCollideWorldBounds(true);

      particles.startFollow(logo);
    }
  }

  const config = {
    type: Phaser.AUTO,
    width: 500,
    height: 700,
    scene: Demo,
    physics: {
      default: "arcade",
      arcade: {
        gravity: { y: 200 },
      },
    },
  };

  const game = new Phaser.Game(config);
  onDestroy(() => game.destroy(true, true));
</script>

<div class="phasor-container">
  <h1>Cybernetic Squirrel Superhero!</h1>
</div>

<style>
  .phasor-container {
    background-color: #000000d6;
    /* background-image: url("./assets/cybersquirrel.png"); */
    color: #78b202;
    padding: 1em;
  }
</style>
