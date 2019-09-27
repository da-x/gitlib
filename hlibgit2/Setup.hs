-- Taken from https://github.com/lamdu/bindings-freetype-gl/blob/master/Setup.hs
import Distribution.Verbosity
import Distribution.Simple
import Distribution.Simple.Setup
import Distribution.Simple.Utils
import System.Directory (doesFileExist)

prepareBuild :: Verbosity -> IO ()
prepareBuild verbosity =
    do
        ok <- doesFileExist "libgit2/README.md"
        if ok
            then
                -- Nix and future versions of Stack automatically update the submodules,
                -- so updating them is not necessary.
                -- More-over, they fail if finding a .git folder,
                -- hence avoiding invocations of git is necessary.
                return ()
            else
                -- Stack/cabal based builds currently require updating the submodules
                rawSystemExit verbosity "bash" ["prepare_submodule.sh"]

main =
    defaultMainWithHooks simpleUserHooks
    { preBuild = \args buildFlags ->
        do
            let verbosity = fromFlagOrDefault normal $ buildVerbosity buildFlags
            prepareBuild verbosity
            preBuild simpleUserHooks args buildFlags
    }
