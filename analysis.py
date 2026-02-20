"""
SNR radius–age (R–t) relation plot.

Shows the Sedov–Taylor and radiative (pressure-driven snowplow) evolutionary
phases for 23 supernova remnants, with fitted and theoretical power-law tracks.

Data sources
------------
Ages (t_r):     Suzuki, Bamba & Shibata 2021, Table 3  (arXiv:2104.10052)
Distances:      Suzuki et al. 2021, Table 3
Angular sizes:  Green 2024, VizieR VII/297; dedicated studies for LMC/SMC SNRs

Usage
-----
    python snr_plot.py
Output: snr_rt.png  (in the current directory)
"""

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

ASPECT_W: int = 8
ASPECT_H: int = 4
SCALE: float = 16.0
OUTPUT_FILE: str = "assets/snr_rt.png"
OUTPUT_DPI: int = 1000

# Phase transition age (kyr) — rough boundary between S-T and radiative phase
# Typical value: 20–30 kyr for n ~ 1 cm⁻³, E₅₁ = 1 (Blondin et al. 1998)
T_TRANSITION_KYR: float = 20.0

# CATPPUCCIN MOCHA PALETTE
BASE = "#1e1e2e"
MANTLE = "#181825"
SURFACE0 = "#313244"
SURFACE1 = "#45475a"
OVERLAY0 = "#6c7086"
OVERLAY1 = "#7f849c"
TEXT = "#cdd6f4"
LAVENDER = "#b4befe"
SAPPHIRE = "#74c7ec"
TEAL = "#94e2d5"
BLUE = "#89b4fa"
MAUVE = "#cba6f7"
RED = "#f38ba8"
PEACH = "#fab387"
GREEN = "#a6e3a1"
YELLOW = "#f9e2af"

# SNR DATA
# Columns: name, reliable age t_r (kyr), distance (kpc), ang. diameter (arcmin)
#
# Age priority: historical > light-echo > tkin,ej > tkin,NS > tdyn
# Angular diameters: Green VII/297 for Galactic; dedicated studies for LMC/SMC

SNR_DATA = [
    # name                  t_r(kyr)  d(kpc)  θ(arcmin)
    ("Cassiopeia A", 0.340, 3.4, 5.0),  # historical
    ("Kepler", 0.416, 4.2, 3.0),  # historical
    ("Tycho", 0.448, 3.0, 8.0),  # historical
    ("3C 58", 0.839, 3.2, 9.0),  # historical
    ("Crab", 0.966, 2.2, 7.0),  # historical
    ("SN 1006", 1.014, 2.2, 30.0),  # historical
    ("G11.2−0.3", 1.634, 4.4, 4.0),  # historical
    ("RCW 86", 1.835, 2.5, 42.0),  # historical
    ("0509−67.5", 0.400, 48.0, 0.50),  # light-echo  (LMC)
    ("0519−69.0", 0.600, 48.0, 0.57),  # light-echo  (LMC)
    ("N103B", 0.860, 48.0, 0.47),  # light-echo  (LMC)
    ("1E 0102.2−7219", 1.738, 60.6, 0.80),  # tkin,ej     (SMC)
    ("N132D", 2.450, 48.0, 2.00),  # tkin,ej     (LMC)
    ("G292.0+1.8", 2.990, 6.0, 8.0),  # tkin,ej
    ("Puppis A", 3.700, 2.0, 55.0),  # tkin,ej
    ("IC 443", 4.000, 1.5, 46.0),  # tdyn
    ("Vela", 11.300, 0.294, 255.0),  # τ_c (pulsar char. age)
    ("G114.3+0.3", 7.700, 0.7, 60.0),  # tdyn
    ("W44", 20.400, 3.0, 31.0),  # τ_c
    ("CTB 80", 107.000, 2.0, 78.0),  # tkin,NS
    ("W41", 148.000, 4.6, 27.0),  # tkin,NS
    ("S147", 140.000, 1.47, 180.0),  # tkin,NS
    ("Monogem", 128.000, 0.28, 1380.0),  # tdyn
]

# DERIVED QUANTITIES

names = np.array([r[0] for r in SNR_DATA])
age_kyr = np.array([r[1] for r in SNR_DATA])
dist = np.array([r[2] for r in SNR_DATA])
ang = np.array([r[3] for r in SNR_DATA])

# Physical radius: R = ½ × D × θ   (D in pc, θ in radians)
rad_pc = 0.5 * (dist * 1e3) * np.deg2rad(ang / 60.0)

mask_st = age_kyr < T_TRANSITION_KYR
mask_rad = age_kyr >= T_TRANSITION_KYR


def fit_powerlaw(t: np.ndarray, r: np.ndarray):
    """OLS power-law fit in log–log space. Returns (A, α, R²) where R = A·tᵅ."""
    lt, lr = np.log10(t), np.log10(r)
    alpha, logA = np.polyfit(lt, lr, 1)
    pred = logA + alpha * lt
    r2 = 1.0 - np.sum((lr - pred) ** 2) / np.sum((lr - lr.mean()) ** 2)
    sigma = np.std(lr - pred)  # scatter in dex
    return 10**logA, alpha, r2, sigma


A_st, a_st, r2_st, sig_st = fit_powerlaw(age_kyr[mask_st], rad_pc[mask_st])
A_rad, a_rad, r2_rad, sig_rad = fit_powerlaw(age_kyr[mask_rad], rad_pc[mask_rad])

# FIGURE
fig_w = SCALE * ASPECT_W / max(ASPECT_W, ASPECT_H)
fig_h = SCALE * ASPECT_H / max(ASPECT_W, ASPECT_H)

plt.rcParams.update(
    {
        "figure.facecolor": BASE,
        "axes.facecolor": MANTLE,
        "axes.edgecolor": SURFACE0,
        "axes.labelcolor": TEXT,
        "axes.grid": True,
        "grid.color": SURFACE0,
        "grid.linewidth": 0.5,
        "grid.linestyle": "--",
        "xtick.color": TEXT,
        "ytick.color": TEXT,
        "xtick.labelcolor": TEXT,
        "ytick.labelcolor": TEXT,
        "text.color": TEXT,
        "legend.facecolor": SURFACE0,
        "legend.edgecolor": SURFACE1,
        "font.family": "monospace",
        "mathtext.fontset": "cm",
    }
)

fig, ax = plt.subplots(figsize=(fig_w, fig_h))

# Phase background shading
ax.axvspan(1e-2, T_TRANSITION_KYR, alpha=0.06, color=SAPPHIRE, zorder=0)
ax.axvspan(T_TRANSITION_KYR, 1e3, alpha=0.06, color=MAUVE, zorder=0)

ax.text(
    0.013,
    90,
    "Sedov–Taylor phase",
    color=SAPPHIRE,
    fontsize=10,
    alpha=0.9,
    fontstyle="italic",
    va="top",
)
ax.text(
    22,
    90,
    "Radiative / snowplow phase",
    color=MAUVE,
    fontsize=10,
    alpha=0.9,
    fontstyle="italic",
    va="top",
)

# Phase transition marker
ax.axvline(T_TRANSITION_KYR, color=YELLOW, lw=1.0, ls=":", alpha=0.6, zorder=1)
ax.text(
    T_TRANSITION_KYR * 1.06,
    1.15,
    r"$t_\mathrm{trans} \approx 20\,\mathrm{kyr}$",
    color=YELLOW,
    fontsize=8,
    alpha=0.8,
)

# Theory tracks (dotted)
t_st_th = np.logspace(-2, np.log10(T_TRANSITION_KYR), 400)
t_rad_th = np.logspace(np.log10(T_TRANSITION_KYR), 3, 400)

# Theory lines anchored to the fitted S-T normalisation at t_trans
r_at_trans = A_st * T_TRANSITION_KYR**a_st

ax.loglog(
    t_st_th,
    A_st * t_st_th ** (2 / 5),
    ":",
    color=RED,
    lw=1.5,
    alpha=0.5,
    label=r"Theory: $R \propto t^{2/5}$ (Sedov–Taylor)",
)
ax.loglog(
    t_rad_th,
    r_at_trans * (t_rad_th / T_TRANSITION_KYR) ** (2 / 7),
    ":",
    color=GREEN,
    lw=1.5,
    alpha=0.5,
    label=r"Theory: $R \propto t^{2/7}$ (pressure-driven snowplow)",
)

# Fitted power laws
ax.loglog(
    t_st_th,
    A_st * t_st_th**a_st,
    "-",
    color=RED,
    lw=2.2,
    zorder=2,
    label=rf"Fit S-T:  $R \propto t^{{{a_st:.2f}}}$  "
    rf"($R^2 = {r2_st:.2f}$)",
)
ax.loglog(
    t_rad_th,
    A_rad * t_rad_th**a_rad,
    "-",
    color=GREEN,
    lw=2.2,
    zorder=2,
    label=rf"Fit radiative:  $R \propto t^{{{a_rad:.2f}}}$  "
    rf"($R^2 = {r2_rad:.2f}$)",
)


# ±1σ scatter bands
def scatter_band(t_arr, A, alpha, t_data, r_data):
    """Return (upper, lower) envelope at ±1σ of the log-residuals."""
    residuals = np.log10(r_data) - np.log10(A * t_data**alpha)
    sigma = np.std(residuals)
    r_fit = A * t_arr**alpha
    return r_fit * 10**sigma, r_fit / 10**sigma, sigma


hi_st, lo_st, _ = scatter_band(t_st_th, A_st, a_st, age_kyr[mask_st], rad_pc[mask_st])
hi_rad, lo_rad, _ = scatter_band(
    t_rad_th, A_rad, a_rad, age_kyr[mask_rad], rad_pc[mask_rad]
)

ax.fill_between(t_st_th, lo_st, hi_st, color=RED, alpha=0.10, zorder=1)
ax.fill_between(t_rad_th, lo_rad, hi_rad, color=GREEN, alpha=0.10, zorder=1)

# Data points
ax.loglog(
    age_kyr[mask_st],
    rad_pc[mask_st],
    "o",
    ms=8,
    color=BLUE,
    markeredgecolor=BASE,
    markeredgewidth=0.8,
    label="SNR data — Sedov–Taylor phase",
    zorder=5,
)

ax.loglog(
    age_kyr[mask_rad],
    rad_pc[mask_rad],
    "s",
    ms=8,
    color=PEACH,
    markeredgecolor=BASE,
    markeredgewidth=0.8,
    label="SNR data — radiative phase",
    zorder=5,
)

# Point labels
for name, t, r in zip(names, age_kyr, rad_pc):
    ax.annotate(
        name,
        (t, r),
        fontsize=6.5,
        color=OVERLAY1,
        textcoords="offset points",
        xytext=(7, 3),
    )

# Scatter annotation
ax.text(
    0.013,
    1.9,
    f"1σ scatter: ×{10**sig_st:.1f}  (ISM density variation)",
    color=RED,
    fontsize=7.5,
    alpha=0.75,
    va="bottom",
)
ax.text(
    22,
    1.9,
    f"1σ scatter: ×{10**sig_rad:.1f}",
    color=GREEN,
    fontsize=7.5,
    alpha=0.75,
    va="bottom",
)

# Axes, labels, title
ax.set_xlim(1e-2, 1e3)
ax.set_ylim(1.0, 200)

ax.set_xlabel(
    r"Reliable remnant age $t_r$ (kyr)",
    fontsize=13,
    labelpad=8,
)
ax.set_ylabel(
    r"Physical shock radius $R$ (pc)",
    fontsize=13,
    labelpad=8,
)
ax.set_title(
    "Supernova Remnant Expansion: Sedov–Taylor → Radiative Phase",
    fontsize=13,
    color=LAVENDER,
    pad=14,
)

ax.tick_params(which="both", direction="in", length=4, width=0.8)
ax.spines[:].set_color(SURFACE0)

# Legend
legend = ax.legend(
    fontsize=8.5,
    framealpha=0.88,
    loc="upper left",
    ncol=2,
    columnspacing=1.2,
    handlelength=2.2,
)
for txt in legend.get_texts():
    txt.set_color(TEXT)

fig.tight_layout()
fig.savefig(OUTPUT_FILE, dpi=OUTPUT_DPI, bbox_inches="tight", facecolor=BASE)
print(f"Saved → {OUTPUT_FILE}  ({fig_w:.1f}″ × {fig_h:.1f}″ at {OUTPUT_DPI} dpi)")
print(f"S-T fit:       R = {A_st:.2f} · t^{a_st:.3f}   R² = {r2_st:.3f}")
print(f"Radiative fit: R = {A_rad:.2f} · t^{a_rad:.3f}   R² = {r2_rad:.3f}")
