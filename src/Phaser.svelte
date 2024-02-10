<script>
  import { onDestroy } from "svelte";
  import Phaser from "phaser";

  let install_host = String(document.location);

  // This style of building a scene is from the Phase Javascript tutorial
  // class Demo extends Phaser.Scene {
  //   preload() {
  //     this.load.setBaseURL(install_host);
  //     this.load.image("sky", "assets/title-background-large.png");
  //     this.load.image("squirrel", "./assets/cybersquirrel-small.png");
  //     this.load.image("contrail", "./assets/mechanical-particles-b.png");
  //   }

  //   create() {
  //     const background = this.add.image(0, 0, "sky");
  //     background.setPosition(
  //       this.cameras.main.centerX,
  //       this.cameras.main.centerY,
  //     );

  //     const particles = this.add.particles(0, 0, "contrail", {
  //       speed: 100,
  //       scale: { start: 1, end: 0 },
  //       blendMode: "ADD",
  //     });

  //     const squirrel = this.physics.add.sprite(400, 100, "squirrel");

  //     squirrel.setVelocity(100, 200);
  //     squirrel.setBounce(1, 1);
  //     squirrel.setCollideWorldBounds(true);

  //     particles.startFollow(squirrel);
  //   }
  // }

  // This style of making the game is more common in examples
  // https://www.thepolyglotdeveloper.com/2020/09/include-touch-cursor-gesture-events-phaser-game/
  const config = {
    type: Phaser.AUTO,
    width: 500,
    height: 700,
    // scene: Demo,
    scene: {
      init: initScene,
      preload: preLoadScene,
      create: createScene,
      update: updateScene,
    },
    physics: {
      default: "arcade",
      arcade: {
        gravity: { y: 200 },
      },
    },
  };

  const game = new Phaser.Game(config);

  let isClicking = false;
  let squirrel;
  let robot;
  let swipeDirection;

  function initScene() {}

  function preLoadScene() {
    this.load.setBaseURL(install_host);
    this.load.image("sky", "assets/title-background-large.png");
    this.load.image("squirrel", "./assets/cybersquirrel-small.png");
    this.load.image("contrail", "./assets/mechanical-particles-b.png");
    this.load.image("robot", "./assets/cute_robot_bad_guy_2_small.png");
  }

  function createScene() {
    const background = this.add.image(0, 0, "sky");
    background.setPosition(
      this.cameras.main.centerX,
      this.cameras.main.centerY,
    );

    const particles = this.add.particles(0, 0, "contrail", {
      speed: 100,
      scale: { start: 1, end: 0 },
      blendMode: "ADD",
    });

    squirrel = this.physics.add.sprite(400, 100, "squirrel");

    squirrel.setVelocity(100, 200);
    squirrel.setBounce(1, 1);
    squirrel.setCollideWorldBounds(true);

    robot = this.physics.add.sprite(300, 100, "robot");

    robot.setVelocity(100, 200);
    robot.setBounce(1, 1);
    robot.setCollideWorldBounds(true);

    particles.startFollow(squirrel);
  }

  // Mouse clicky variant
  // function updateScene() {
  //   if (!this.input.activePointer.isDown && isClicking == true) {
  //     squirrel.y = this.input.activePointer.position.y;
  //     isClicking = false;
  //   } else if (this.input.activePointer.isDown && isClicking == false) {
  //     isClicking = true;
  //   }

  //   if (Math.abs(squirrel.y - squirrel.getData("position")) <= 10) {
  //     squirrel.y = squirrel.getData("position");
  //   } else if (squirrel.y < squirrel.getData("position")) {
  //     squirrel.y += 5;
  //   } else if (squirrel.y > squirrel.getData("position")) {
  //     squirrel.y -= 5;
  //   }
  // }

  function updateScene() {
    if (!this.input.activePointer.isDown && isClicking == true) {
      if (
        Math.abs(
          this.input.activePointer.upY - this.input.activePointer.downY,
        ) >= 50
      ) {
        if (this.input.activePointer.upY < this.input.activePointer.downY) {
          swipeDirection = "up";
        } else if (
          this.input.activePointer.upY > this.input.activePointer.downY
        ) {
          swipeDirection = "down";
        }
      }
      isClicking = false;
    } else if (this.input.activePointer.isDown && isClicking == false) {
      isClicking = true;
    }

    if (swipeDirection == "down" && squirrel.y < 500) {
      if (Math.abs(squirrel.y - 500) <= 10) {
        squirrel.y = 500;
      } else {
        squirrel.y += 8;
      }
    } else if (swipeDirection == "up" && squirrel.y > 150) {
      if (Math.abs(squirrel.y - 150) <= 10) {
        squirrel.y = 150;
      } else {
        squirrel.y -= 8;
      }
    }
  }
  onDestroy(() => game.destroy(true, true));
</script>

<div class="phasor-container">
  <h2>Cybernetic Squirrel Superhero!</h2>
  <p>{install_host}</p>
</div>

<style>
  .phasor-container {
    background-color: #000000d6;
    /* background-image: url("./assets/cybersquirrel.png"); */
    color: #78b202;
    padding: 1em;
  }
</style>
