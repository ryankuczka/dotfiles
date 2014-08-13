#!/usr/bin/env python
# -*- coding: UTF-8 -*-

# Parse getopt-style help texts for options
# and generate zsh(1) completion function.
# Original from: http://github.com/RobSis/zsh-completion-generator

# Usage: program --help | ./help2comp.py program_name

import sys
import re
from string import Template


STRIP_CHARS = " \t\n,="

COMPLETE_FUNCTION_TEMPLATE = """
#compdef $program_name

# zsh completions for '$program_name'
local arguments

arguments=(
$argument_list
    '*:filename:_files'
)

_arguments -s $arguments
"""

ARGUMENT_TEMPLATE = """    {$opts}'[$description]$style'"""
SINGLE_ARGUMENT_TEMPLATE = """    '$opt[$description]$style'"""
OPTION_REGEX = re.compile(
    '^(?P<opt>--?(?:\[[A-Za-z0-9-]+\])?[A-Za-z0-9-]+)'  # Option itself
    '(?:[[ =][^- ][A-Za-z<>[|:\]-_?#]*]?)?'   # Optional option argument desc
)


def cut_option(line):
    """
    Cuts out the first option (short or long) and its argument.
    """
    opt = OPTION_REGEX.match(line).group(0)
    if opt is None:
        return line, None
    else:
        opt = opt.group(0)
        line = line.replace(opt[0], '', 1).strip(STRIP_CHARS)
        return line, opt


def parse_options(help_text):
    """
    Parses the options line by line.
    When description is missing and options are missing on
    consecutive line, link them together.
    """
    all_options = []
    previous_description_missing = False
    for line in help_text:
        line = line.strip(STRIP_CHARS)
        options = []

        opt_match = OPTION_REGEX.match(line)
        if not opt_match and previous_description_missing:
            all_options[-1][-1] = line
            previous_description_missing = False
            continue

        while opt_match:
            opt = opt_match.group('opt')
            line = OPTION_REGEX.sub('', line).strip(STRIP_CHARS)

            options.append(opt)
            opt_match = OPTION_REGEX.match(line)

        if len(line) == 0:
            previous_description_missing = True
        options.append(line)
        all_options.append(options)

    return all_options


def _escape(line):
    """
    Escape the syntax-breaking characters.
    """
    line = line.replace('[', '\[').replace(']', '\]')
    line = line.replace('\'', '')
    return line


def generate_argument_list(options):
    """
    Generate list of arguments from the template.
    """
    argument_list = []
    for opts in options:
        model = {}
        # remove unescapable chars.

        model['description'] = _escape(opts[-1])
        model['style'] = ""
        if (len(opts) > 2):
            model['opts'] = ",".join(opts[:-1])
            argument_list.append(Template(ARGUMENT_TEMPLATE).safe_substitute(model))
        elif (len(opts) == 2):
            model['opt'] = opts[0]
            argument_list.append(Template(SINGLE_ARGUMENT_TEMPLATE).safe_substitute(model))
        else:
            pass

    return "\n".join(argument_list)


def generate_completion_function(options, program_name):
    """
    Generate completion function from the template.
    """
    model = {}
    model['program_name'] = program_name
    model['argument_list'] = generate_argument_list(options)
    return Template(COMPLETE_FUNCTION_TEMPLATE).safe_substitute(model).strip()


if __name__ == "__main__":
    if len(sys.argv) > 1:
        options = parse_options(sys.stdin.readlines())
        if (len(options) == 0):
            sys.exit(2)

        print generate_completion_function(options, sys.argv[1])
    else:
        print "Please specify program name."
