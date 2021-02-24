# Elixir HangMan Game

Hangman game project to demonstrate the use of Elixir programming language.

To run the game:

```elixir
mix run -e "HangManGame.start_game()"
```

# Elixir/Erlang installation

In this case, we need the asdf tool (yes, like as the first 4 letters on the keyboard) which is a manager version for Elixir like pyenv for Python or rbenv for Ruby. These are the steps for a MacOS installation using the GIT method over a zsh shell:

```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.zshrc
echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.zshrc
```

We reload the shell, and then we print out the asdf version:

```bash
asdf --version (which must displays something like v0.8.0-c6145d0)
```

If you want to get updates, `run asdf update`.

To do this please read the information about [Compatibility between Elixir and Erlang/OTP](https://github.com/elixir-lang/elixir/blob/master/lib/elixir/pages/compatibility-and-deprecations.md#compatibility-between-elixir-and-erlangotp) which tells you what dependency versions you must install. `asdf` allows you to manage several programming languages so we need to specify which of them we are going to use through plugins:

```bash
asdf plugin-add erlang
asdf plugin-add elixir
asdf plugin list
asdf list-all elixir (To display all elixir versions available)
asdf list-all erlang (To display all erlang versions available)
```

We will use Elixir 1.9 because is the last stable version. Let’s install it via asdf, remember to read the compatibility table mentioned above:

```bash
asdf install erlang 22.3.4.9 (This step take a while)
asdf install elixir 1.9.4
```

Let’s check if the installation was correct:

```bash
asdf list
```

Finally, let’s check our Elixir installed version:

```bash
elixir -v
```
