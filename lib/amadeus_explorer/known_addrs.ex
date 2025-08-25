defmodule AmadeusExplorer.KnownAddrs do
  def known_addr(addr) do
    mia = [
      "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"
    ]

    af = [
      "7SCZ6NzKPV27prSAv1CiGLZPHRpqEX9GR3wdCWkW6kstsd2tk5ejeeKKaf1y5hQZhc",
      "5sLrta7CRdnhwdRrtN25dxS8HbUKbcpjprJ1Kxe1pBtfNefz4pPDLH6C8MQLCXb91i",
      "5wrduSMTjRxz5x7JXKxJ3nSehpRHaMZGyAdiRtqkBNBXzNpfxx2KPsxEVAHDV7KFMp",
      "7jqCWJUetJmMhzHUekExpNozBfNbZQgaMNnaZmFfDCSsWS9PLCnrAGAEodnd48ZYik",
      "7fKbfUfW5sErmaa1FZeZ2Kf2xMr5T1u5kx1vppGZ5Zdrx3Q95on84JwsVs7p7DR7tf",
      "5jX2GHtbPnRcQ2EcAAEJNgLQtf3jrxzZVuhES4nTZhjtA8ofEwxH92TZfXspAUHxda",
      "5zN69JJ6nCJcXdfxcHHG1q9fBJnKXDXWqkzMZQ2Y1gmaSvWwezYF1zD7GKUx1zbQoq",
      "7bd4moBphcUfcx1DYkMHhs26V29ibaS87wHbVpaU9zaJvbasKEdnkVHJ5en2QZkpdp",
      "66Q1Cdt9YVaY3Ak5jgwvHTZrQmwZaHtMDszGhPjFn9L6JBqrX75tkCQJfE7URu68sd",
      "7DEimnJFN6fPy8k32MHgg7UBY4iqHHcqbHBWX1i4dMhyiJtNMKPhecADXKeHyTstHh",
      "6uFFKt5CeRMbrjhygrmXqbdyBWCSoNMkkApe6Pxi5FxCNbJcT4ggg8cKD873tANYok",
      "5wi996mL5YemU1xYxsdMjiAq1mVg63NGKwTm8UgYVafFkLP2Rp2tDECmmxWTA3mYST"
    ]

    will_caster = [
      "5qYZD8HVJzXX4UJDCe6gHdAu4or2jWdnkUX1ZLdGxBx3cKj6NkbXNz46CGxMjqyuL1",
      "7SGTxaLStDPbLKnjcXC1fqN3xaGBs4oFEPVa6UVDwt5N63C7US4vf8wP9hB4p9Fdku",
      "6ddsvp1auJ2zWqDwFJdoHvijEsHyXLfS2yFnxmyCBfgU7PsNRoeMgJSRhdforShBk5",
      "7EUorF3cVLhhGMCAfZo2MGC6vZXGQJcXv9gpAve6zeJ8gHWcjpL3GS697aC7gSSHfi",
      "6uCWrNLaMzWjPM9PfieLzTLsGuvHnEKdw3M5WJe7jJMqWDLJp2U24dx6XSoy8aj4B4",
      "5zU13Q4iNrcxYenX5oUU8h7YAzM7XqQAzMe9fHs9dyxf58HMnA4JMX9vC7q5GiGpKa"
    ]

    initials = [
      "6969GaCysicYUFd6JQhxG1QPwRvXdTGtWVCCAEgM6Kq1jcSMX7RySrSFU9WRHWbJyE",
      "5yeMvJCpTGsQT9zVKHen9D9yYpMASDu8bvcUCjFsmwuvxqSeMy4o4SmjPPaHNdtLjN",
      "7bbTbkXuDNHwnNR2h5m8RWA3McqBhhMZ9A9RGeHLwMCgaeJABPe7Wp1JKEddENDwMN",
      "75nvmLJ3EjLVKntGETaQn59DwL9jrxp3cyREhLyP2UvK5cEjWqkVDt84q6EdSL9n2T",
      "5oqdqhQmQYUZAnnUA2Ro5zryKixoL5DSEi8oRH47wpBgzd331Zwa4ZKkoMp8aUCFZN",
      "6Y72peFtiNrWTuzSe8vBXmEbBscYcEAFzfwBXQwpamMhWqKnZScybSRmAG8QP1XhrX",
      "6w1375LPEaiNpELJARXM9wB4JTrhYHxumdivWi2HrAcTr1aJgTxDHPkS59frqXB4rk",
      "6tvbg9aSduPjysrqfRmBseDUWpumS1NF7x8zEX1RYSrKZDTtwkmt6UNuM4fMnj4RiJ",
      "7TjD5MHmTduZBm9TKrmqmPZkfkzKxRBAwsvLTUxLtWEPES8XnDivn3yKbJP4ukr5Jt",
      "6DGXVRincEfrMf1uULtCMARHzBfkqFw5PybgRN9UL6C6mMtt15ikVPQEU2rZCKfiwg",
      "6Z5oFHVHrR4b5xh3E7nmQNLWjB9nE2C9vmqdaxDCc7i8seatENHyra2y5cZLsbbYn1",
      "7MatuKWRgbVHoBRiMSQ7T1vyam7PpLBhhc5nJAsFCHiKGNkZYHaE3xqcVVcVX8rthu",
      "7RM51rp12raGyxP4mbet3YTMqrrVpE7sqrBLABM1JVs8jCTmAYX1v9Dy3C7hn37kUp",
      "7M8CGZF83tqtPEeDRdGsHVCKXicrfYuBzdckmHvJ3NyqhcWKA62pAmcQWrJUDETjgN",
      "6BPja6PpMnrggpF2735JEXVz5AXprrwCrt7E3vnFDzH3hVuXaekMb4hoSAB6mTZBjt",
      "67S6BnB9WwJgixgAGArUxxZNcrwAKgQKajZcpAbmxWg2zBBpZeZ6Lch8hVS6VKEFas",
      "6z8V3ALPZYaENgccZrBt6zhPvWvYmC7nngp2rMMxH1Gu9B6MWgV1QLNTerU44Gb7ti",
      "6WjdAs3KfgMU7ghQJ2DhUr54RK3vva9UPEYY2eBjmdhSpSaAEcDdn2BBTEg6gMp59G",
      "5q6x1ZB47DvRiHnMjM7hoJaykczPYJF4qYRJuxvpkMB7Ca1uyfdwtpfHSqD7EJxDzy",
      "7ZvC6KWxs4C2H4Qz1cPzNvhPyEXFg7AcvbKndXHGYM5wgi84rzsKPbEkbrQCT5RfX3",
      "7DYCdusKW3SLj1CsFNKyV6fnczqrJfGmPLY1CCZFyHnzgkctQasmxkGxkgPUZnr51D",
      "6FhHDv2dFhniUeuptTWviHUFCXpoFwBWNqFHdTgB95B9pK4YTbR3t5G9mJXBoJArBm",
      "5u4PAK7oTzUKprGzoprsWygiMftP4sJZMgLKADE78cxZkxTMLws9FFJewzk7QftuXr",
      "7e2KSLPhN4WETRh8TnCEFVxqAE2ULMFSZRvHbJaT8HUgaHWEd8VcGkFc8Fk41NwQe5",
      "6bxWw14AD53EN6BBRKymxQz9Ck2n9nKqPjSEEVhsremhxi8Tbn9HoEk4nVAguNiXb5",
      "5rK1Wng3fmaUWSoCgyJLTQTqcJQCWvZBNK5ak97p9DrdEbcCxed766mizRAM2NAHnm"
    ]

    actor2 = [
      "72draQDGAeauUcdqdNGVEBa9TgTimZBsR9PTM2zUDEJgPkzTPuqBG8fLEFaBgG9j6N",
      "6GWeWCuPzmGyQ5gn1F8kNK52VEyMKfXu1p655DqFozi5HdMVZaVPHxCVr7r2cU44R8",
      "5v7ikipZDFrUq26tAcHHXvyxsJByf4HTqGc8W2BPVHT9Q1vZwvNRfK1xHXDVR18mbH"
    ]

    crab = [
      "6bmQpVDCyPBj3eNQ4Bz7zjGCC52rZ2PgtBANazbkESPVjxoHyGkJuPmmyB15ikekTH",
      "72F3MbVLuUzxALsXAsTEJptYFGL9ewrHFhktZCGvj7JhWXnKJScpVqbbVTAEvU9Tok"
    ]

    egypt = [
      "6bntFSNoGRQtaJkqD9czp9RxkiajVYg9mdnYd6h8gV3CFZKUd4eC6vCGWWfXHjMUXX",
      "6PAzwkAhjNPFrXDBE2Ew9YovvAZ3Z3abFEA6xFuRAgRDT2dsNyxDvrLLX7HVQwWht7",
      "72draQDGAeauUcdqdNGVEBa9TgTimZBsR9PTM2zUDEJgPkzTPuqBG8fLEFaBgG9j6N",
      "77PbahMBp91VnyQsBc3f59JvEiGoSuS6JUUtYmm1i3XZHxYyekgNoaoifJ5NLHA7sJ",
      "6GWeWCuPzmGyQ5gn1F8kNK52VEyMKfXu1p655DqFozi5HdMVZaVPHxCVr7r2cU44R8",
      "5v7ikipZDFrUq26tAcHHXvyxsJByf4HTqGc8W2BPVHT9Q1vZwvNRfK1xHXDVR18mbH",
      "6bvLJw48Lm1i8DBPfi1wMKBooqF2Vspsd9MQ3GXpJ1ec3notVrMePB1yBB8fiF2qtu",
      "7QSjY8KmZCkptqeP4RhgUUV9EhUMWQwUijZMRNDQvFtjDyPSmqNh912EXk6TRS33F3",
      "6bmQpVDCyPBj3eNQ4Bz7zjGCC52rZ2PgtBANazbkESPVjxoHyGkJuPmmyB15ikekTH",
      "72F3MbVLuUzxALsXAsTEJptYFGL9ewrHFhktZCGvj7JhWXnKJScpVqbbVTAEvU9Tok"
    ]

    cond do
      addr in egypt ->
        "pharaon"

      addr in af ->
        "AF"

      addr in crab ->
        "crab"

      addr in will_caster ->
        "will_caster"

      addr in actor2 ->
        "actor2"

      addr in mia ->
        "mia"

      addr in initials ->
        "initial"

      true ->
        ""
    end
  end
end
